using System;
using System.Collections.Generic;
using System.Web;

namespace ContourAnalyseService20
{
    /// <summary>
    /// 某个站点的雨量数据
    /// </summary>
    public class RainInfo
    {
        /// <summary>
        /// 站点号
        /// </summary>
        public string SiteNum { get; set; }
        /// <summary>
        /// 经度
        /// </summary>
        public double Lon { get; set; }
        /// <summary>
        /// 纬度
        /// </summary>
        public double Lat { get; set; }
        /// <summary>
        /// 实际雨量
        /// </summary>
        public double RainFall { get; set; }
    }
}