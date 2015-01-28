package com.MapGIS.Demo;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class SqlConn {
	private static String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public static String url="jdbc:sqlserver://122.49.20.12:1433;databaseName=HotSpotData;user=zondy;password=webgis_1i2";
    static	Connection con = null;
	
	public static void close(ResultSet rs,Statement st,Connection con){
		try {
			if(null!=rs)
			rs.close();
			if(null!=st)
            st.close();
			if(null!=con)
            con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static Connection getCon(){
		try {
			Class.forName(driver);//通过字符串加载驱动类 并实例化
			 con = DriverManager.getConnection(url);
		} catch (ClassNotFoundException e) {
			System.out.println("驱动不对");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("没有获得到连接");
			e.printStackTrace();
		}
		return con;
	}
	
	
}
