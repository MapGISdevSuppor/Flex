<%@ WebHandler Language="C#" Class="GPSHandler" %>

using System;
using System.Web;
using Mapgis7.WebService.BasLib;
using System.Data;
using System.Text;
using System.Configuration;

public class GPSHandler : IHttpHandler {
    public static string GPS_SQL_LASTPOS="select top 1 * from {0} where PDevice={1} order by id desc";
    public static string GPS_SQL_HISTORY = "select  * from {0} where ptime > '{1}' and ptime < '{2}' and pdevice={3}";
    public static string connString = ConfigurationManager.AppSettings["GPS_DB_CONN"];
    public void ProcessRequest (HttpContext context) {
        try
        {
        String method = getParam(context,"method");
        switch (method)
        {
            case "getLastPos":
                DataSet ds = CommonSqlHelper.ExecuteDataset(connString, string.Format(GPS_SQL_LASTPOS, getParam(context, "gpsType"), getParam(context, "PDevice")));
                context.Response.Write(GetPosInfo(ds));
                break;
            case "getHistoryPath":
                ds = CommonSqlHelper.ExecuteDataset(connString, string.Format(GPS_SQL_HISTORY, getParam(context, "gpsType"), getParam(context, "beginTime"), getParam(context, "endTime"), getParam(context, "PDevice")));
                context.Response.Write(GetPosInfo(ds));
                break;
            default:
                context.Response.Write("unknown method");
                break;
        }
        }
        catch(Exception e)
        {
            context.Response.Write(e.Message);
        }
    }
    public string getParam(HttpContext context, string key)
    {
        string obj = context.Request.QueryString[key];
        if (obj == null)
        {
            throw new Exception(string.Format("parameter error. the {0} is null.",key)); 
        }
        return obj;
    }
    public string GetPosInfo(DataSet ds)
    {
        int columnNum = ds.Tables[0].Columns.Count;
        int rowNum = ds.Tables[0].Rows.Count;
        StringBuilder obj = new StringBuilder();
        
        for (int i = 0; i < columnNum; i++)
        {
            obj.Append(string.Format("{0},", ds.Tables[0].Columns[i].ColumnName));
        }
        obj.Remove(obj.Length - 1, 1);
        obj.Append("*");
        for (int r = 0; r < rowNum; r++)
        {
            for (int i = 0; i < columnNum; i++)
            {
                obj.Append(string.Format("{0},", ds.Tables[0].Rows[r][i]));
            }
            obj.Remove(obj.Length - 1, 1);
            obj.Append(";");
        }
        obj.Remove(obj.Length - 1, 1);
        return obj.ToString();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}