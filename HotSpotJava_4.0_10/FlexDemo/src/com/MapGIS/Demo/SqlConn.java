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
			Class.forName(driver);//ͨ���ַ������������� ��ʵ����
			 con = DriverManager.getConnection(url);
		} catch (ClassNotFoundException e) {
			System.out.println("��������");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("û�л�õ�����");
			e.printStackTrace();
		}
		return con;
	}
	
	
}
