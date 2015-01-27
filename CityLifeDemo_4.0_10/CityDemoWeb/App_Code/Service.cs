using System;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
// [System.Web.Script.Services.ScriptService]
public class Service : System.Web.Services.WebService
{
    public Service()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod]
    //通过关键字查找地名
    public DataSet GetDataset(string key)
    {
        //连接SQL数据库
        string ConnectionString = ConfigurationManager.AppSettings["CityDemoSqlWeb"];
        //设置数据库查询条件
        string s = "'%" + key + "%'";
        string strSql = "select X,Y,placeName from C027 where placeName like" + s;
        //查询数据库
        using (SqlConnection connection = new SqlConnection(ConnectionString))
        {
            SqlDataAdapter da = new SqlDataAdapter(strSql, connection);
            DataSet ds = new DataSet();
            da.Fill(ds);
            return ds;
        }
    }

}
