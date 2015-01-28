package com.MapGIS.Demo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class GetHotSpot {
	// �������ݿ���ݼ������в�ѯ�õ����ݿ�����������Ϣ
	public List<HotSpotDTO> firstGetHotSpots(int levID,int maxLev,String SerIP,String SqlName,String SqlPass) {
		List<HotSpotDTO> list = new ArrayList<HotSpotDTO>();
		Connection conn = null;
		HotSpotDTO HSpot = null;
		SqlConn.url="jdbc:sqlserver://"+SerIP+";databaseName=HotSpotData;user="+SqlName+";password="+SqlPass;
		if (conn == null) {
			// �������ݿ�
			conn = SqlConn.getCon();
		}
		String sql = "";
		try {
			// -----begin �ж����ݴ洢��������Ƕ���
			sql = "select max(lev) FROM HotSpots";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (levID > rs.getInt(1)) {
					levID = rs.getInt(1);
				}
			}
			rs.close();
			// -------end-----------------------
			// -------begin���ݼ����õ�������������Ϣ
			sql = "";
			
		//	if(levID>maxLev){
		//		levID=maxLev;
		//	}
			
			sql = "SELECT id,name,coord,pnum,paddress FROM HotSpots where  lev=" + levID;
				ps = conn.prepareStatement(sql);
			 rs = ps.executeQuery();
			while (rs.next()) {
				// sb_loc.append(rs.getInt("id")+"#"+rs.getString("name")+"#"+rs.getString("coord")+"#");
				HSpot=new HotSpotDTO();
				HSpot.setId(rs.getInt("id"));
				HSpot.setName(rs.getString("name"));
				HSpot.setCoord(rs.getString("coord"));
				HSpot.setPnum(rs.getInt("pnum"));
				//if(rs.getString("paddress")!=null&&rs.getString("paddress")!=""){
				HSpot.setPaddress(rs.getString("paddress"));
				//}else{
					//HSpot.setPaddress("");
				//}
				
				list.add(HSpot);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	
	// �������ݿ���ݼ������в�ѯ�õ����ݿ�����������Ϣ
	public List<HotSpotDTO> getHotSpots(int levID,int maxLev) {
		List<HotSpotDTO> list = new ArrayList<HotSpotDTO>();
		Connection conn = null;
		HotSpotDTO HSpot = null;
		if (conn == null) {
			// �������ݿ�
			conn = SqlConn.getCon();
		}
		String sql = "";
		try {
			// -----begin �ж����ݴ洢��������Ƕ���
			sql = "select max(lev) FROM HotSpots";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (levID > rs.getInt(1)) {
					levID = rs.getInt(1);
				}
			}
			rs.close();
			// -------end-----------------------
			// -------begin���ݼ����õ�������������Ϣ
			sql = "";
			
		//	if(levID>maxLev){
		//		levID=maxLev;
		//	}
			
			sql = "SELECT id,name,coord,pnum,paddress FROM HotSpots where  lev=" + levID;
				ps = conn.prepareStatement(sql);
			 rs = ps.executeQuery();
			while (rs.next()) {
				// sb_loc.append(rs.getInt("id")+"#"+rs.getString("name")+"#"+rs.getString("coord")+"#");
				HSpot=new HotSpotDTO();
				HSpot.setId(rs.getInt("id"));
				HSpot.setName(rs.getString("name"));
				HSpot.setCoord(rs.getString("coord"));
				HSpot.setPnum(rs.getInt("pnum"));
				//if(rs.getString("paddress")!=null&&rs.getString("paddress")!=""){
				HSpot.setPaddress(rs.getString("paddress"));
				//}else{
					//HSpot.setPaddress("");
				//}
				
				list.add(HSpot);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	/*
	 * (non-Javadoc)
	 * �����������Ϣ
	 */
	public int insertHotspot(String hName,String Hcoords,int lev,String hPnum,String hPaddress) {
		Connection conn = SqlConn.getCon();
		int hpnum=Integer.parseInt(hPnum);
		int count = 0;
		try {
			PreparedStatement ps = conn
					.prepareStatement("insert into HotSpots(name,coord,lev,pnum,paddress) values(?,?,?,?,?)");
			ps.setString(1,hName);
			ps.setString(2,Hcoords);
			ps.setInt(3,lev);
			ps.setInt(4,hpnum);
			ps.setString(5,hPaddress);
			count = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	

	/*
	 * ͨ��id��ɾ��������Ϣ
	 * 
	 */
	public int deleteHotSpot(int bid) {  
		Connection conn = SqlConn.getCon();
		int count = 0;
		try {
			PreparedStatement ps = conn
					.prepareStatement("delete from HotSpots where id=? ");
			ps.setInt(1, bid);
			count = ps.executeUpdate();
	     
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	/*
	 * 
	 * 
	 * �޸�������Ϣ
	 */
	public int upHotData(String hName,String bid,String hPnum,String hpaddress,String hCoord) {
		Connection con =  SqlConn.getCon();
		int inthpnum=Integer.parseInt(hPnum);
		int hid=Integer.parseInt(bid);
		int count=0;
		try {
			PreparedStatement ps = con.prepareStatement("update  HotSpots set name=? ,pnum=? ,paddress=? ,coord=? where id=?");
			ps.setString(1,hName);
			ps.setInt(2,inthpnum);
			ps.setString(3,hpaddress);
			ps.setString(4,hCoord);
	        ps.setInt(5,hid);
	        count = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	/*
	 * (non-Javadoc)
	 * ע����Ϣ
	 */
	public int insertRegistInfo(String sName,String sCompany,String sTel,String sEmail) {
		Connection conn = SqlConn.getCon();
		int count = 0;
		try {
			PreparedStatement ps = conn
					.prepareStatement("insert into RegistInfo(uName,ucomPany,uTel,uEmail) values(?,?,?,?)");
			ps.setString(1,sName);
			ps.setString(2,sCompany);
			ps.setString(3,sTel);
			ps.setString(4,sEmail);
			count = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
