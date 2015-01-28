using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.OleDb;
using System.Web;
using System.Web.Services;

using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace ContourAnalyseService20
{
    /// <summary>
    /// Service1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class Service1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }


        //-------------------------------------------------web.config里的参数设置----------------------------------------------------//
        /// <summary>
        /// 等值线分析功能关系数据库配置
        /// </summary>
        public static string ConnectionString = ConfigurationManager.ConnectionStrings["ContourConnectionString"].ToString();

        /// <summary>
        /// 获取雨量信息
        /// </summary>
        /// <param name="startDay">起始日期</param>
        /// <param name="endDay">终止日期</param>
        /// <param name="startTime">起始时间</param>
        /// <param name="endTime">终止时间</param>
        /// <returns>返回雨量信息</returns>
        [WebMethod]
        public List<RainInfo> getRainInfo(string startDay, string endDay, string startTime, string endTime)
        {
            DateTime startDayVal = (DateTime) Convert.ToDateTime(startDay);
            DateTime endDayVal = (DateTime) Convert.ToDateTime(endDay);
            DateTime startTimeVal = (DateTime)Convert.ToDateTime(startTime);
            DateTime endTimeVal = (DateTime)Convert.ToDateTime(endTime);
            List<RainInfo> rainInfos = GetRadarRf(startDayVal,endDayVal,startTimeVal,endTimeVal);
            if (rainInfos.Count==0)
            {
                MessageBox.Show("雨量信息不足！","提示");
                return null;
            }
            return rainInfos;
        }

        /// <summary>
        /// 获取雷达反演累积雨量数据，获取相关观测点信息
        /// </summary>
        /// <param name="startDate">开始日期</param>
        /// <param name="endDate">结束日期</param>
        /// <param name="startTime">开始时间</param>
        /// <param name="endTime">结束时间</param>
        /// <returns>站点相关信息列表，包括经纬度以及累积雨量值</returns>
        private List<RainInfo> GetRadarRf(DateTime startDate, DateTime endDate, DateTime startTime, DateTime endTime)
        {
            var rfList = new List<RainInfo>();
            var rfoldList = new List<RainInfo>();
            List<DataTable> dsList = GetRfByDates(startDate, endDate, startTime, endTime);
            if(dsList==null||dsList.Count==0)
            {
                return null;
            }

            List<decimal> temRainfall = new List<decimal>();
            List<string> stcdlist = new List<string>();
            for (int i = 0; i < dsList.Count; i++)
            {
                for (int j = 0; j < dsList[i].Rows.Count; j++)
                {
                    string stcdID = dsList[i].Rows[j].ItemArray[0].ToString();
                    if (!stcdlist.Contains(stcdID))
                    {
                        stcdlist.Add(stcdID);
                        var temInfo = new RainInfo();
                        temInfo.SiteNum = stcdID;
                        temInfo.Lon = Convert.ToDouble(dsList[i].Rows[j].ItemArray[1]);
                        temInfo.Lat = Convert.ToDouble(dsList[i].Rows[j].ItemArray[2]);
                        if (Convert.IsDBNull(dsList[i].Rows[j].ItemArray[3]))
                        {
                            temRainfall.Add(0);
                        }
                        else
                        {
                            temRainfall.Add(Math.Round(Convert.ToDecimal(dsList[i].Rows[j].ItemArray[3]),2));
                        }
                        rfoldList.Add(temInfo);
                    }
                    else
                    {
                        var indexSTCD = stcdlist.IndexOf(stcdID);
                        var oldRainFall = temRainfall[indexSTCD];
                        decimal nowRainFall = 0;
                        if (Convert.IsDBNull(dsList[i].Rows[j].ItemArray[3]))
                        {
                            nowRainFall = 0;
                        }
                        else
                        {
                            nowRainFall = Math.Round(Convert.ToDecimal(dsList[i].Rows[j].ItemArray[3]), 2);
                        }
                        temRainfall[indexSTCD] = oldRainFall + nowRainFall;
                    }
                }
            }

            for (int j = 0; j < stcdlist.Count; j++)
            {
                var temInfo = new RainInfo();
                temInfo.SiteNum = Convert.ToString(rfoldList[j].SiteNum);
                temInfo.Lon = Convert.ToDouble(rfoldList[j].Lon);
                temInfo.Lat = Convert.ToDouble(rfoldList[j].Lat);
                temInfo.RainFall = Convert.ToDouble(temRainfall[j]);
                rfList.Add(temInfo);
            }
            
            return rfList;
        }

        /// <summary>
        /// 查询某段时间的降雨量，每天存储一个datatable
        /// </summary>
        /// <param name="startDate">开始日期</param>
        /// <param name="endDate">结束日期</param>
        /// <param name="startTime">开始时间</param>
        /// <param name="endTime">结束时间</param>
        /// <returns>返回降雨量，一个表格对应一天的雨量</returns>
        private List<DataTable> GetRfByDates(DateTime startDate, DateTime endDate, DateTime startTime, DateTime endTime)
        {
            List<DataTable> rainFallList = new List<DataTable>();
            int days = (endDate.Date - startDate.Date).Days + 1;
            try
            {
                OleDbConnection connection = new OleDbConnection(ConnectionString);
                for (int i = 0; i < days; i++)
                {
                    string temTime = startDate.AddDays(i).ToString("yyyy/MM/dd") + " " +
                                     startTime.AddHours(i).ToString("HH:mm:ss");
                    string maxTime = endDate.AddDays(i).ToString("yyyy/MM/dd") + " " +
                                     endTime.AddHours(i).ToString("HH:mm:ss");
                    string sqlStr = "Select STCD,lgtd as x,lttd as y,DYP as z from st_rain where TM >= '" + temTime + "' and TM<='" + maxTime + "' order by STCD";
                    OleDbDataAdapter adapter = new OleDbDataAdapter(sqlStr, connection);
                    DataTable dataTable = new DataTable();
                    try
                    {
                        if (connection.State == ConnectionState.Closed)
                        {
                            connection.Open();
                        }
                        adapter.Fill(dataTable);
                        if (dataTable.Rows.Count > 0)
                        {
                            rainFallList.Add(dataTable);
                        }
                    }
                    catch (Exception e)
                    {

                        throw new Exception("RadarRf.GetRfByDates:" + e.Message);
                    }
                }
                connection.Close();
            }
            catch (Exception exp)
            {

                throw new Exception("RadarRf.GetRfByDates:" + exp.Message);
            }
            return rainFallList;
        }
    }
}