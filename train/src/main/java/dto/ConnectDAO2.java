package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class ConnectDAO2 {
	private ArrayList<ConnectDAO> listOfConnect = new ArrayList<ConnectDAO>();
	private String Connect_ID;
	private String Station_ID;
	private String Line_ID;
	private int StationNum;
	
	private Connection con;
	private ResultSet rs;
	
	public ConnectDAO2() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/train_db";
			String dbID = "root";
			String dbPassword = "kjw98800";
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 중복여부 확인
	public boolean Connect_ID_Check(String connect_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM connect WHERE Connect_ID = ?");
			pst.setString(1, connect_ID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Foreign key 확인
	// 있으면 true
	public boolean Station_ID_Check(String station_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM station WHERE Station_ID = ?");
			pst.setString(1, station_ID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public boolean Line_ID_Check(String line_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM line WHERE Line_ID = ?");
			pst.setString(1, line_ID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 등록
	public int insert(ConnectDAO connectDAO) {
		if(!Connect_ID_Check(connectDAO.getConnectID())) return 0;
		if(!Station_ID_Check(connectDAO.getStationID())) return -2;
		if(!Line_ID_Check(connectDAO.getLineID())) return -3;
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Connect VALUES (?,?,?,?)");
			pst.setString(1, connectDAO.getConnectID());
			pst.setString(2, connectDAO.getStationID());
			pst.setString(3, connectDAO.getLineID());
			pst.setInt(4, connectDAO.getStationNum());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Connect_Update(ConnectDAO connectDAO){
			if(Connect_ID_Check(connectDAO.getConnectID())) return 0;
			if(!Station_ID_Check(connectDAO.getStationID())) return -2;
			if(!Line_ID_Check(connectDAO.getLineID())) return -3;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Connect SET Station_ID=?, Line_ID=?, StationNum =?  WHERE Connect_ID = ?");
				pst.setString(4, connectDAO.getConnectID());
				pst.setString(1, connectDAO.getStationID());
				pst.setString(2, connectDAO.getLineID());
				pst.setInt(3, connectDAO.getStationNum());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Connect_Delete(ConnectDAO connectDAO){
			if(Connect_ID_Check(connectDAO.getConnectID())) return 0;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM connect WHERE Connect_ID=?");
				pst.setString(1, connectDAO.getConnectID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<ConnectDAO> Connect_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Connect");
				rs = pst.executeQuery();
				while (rs.next()) {
					ConnectDAO connectDAO = new ConnectDAO();
					connectDAO.setConnectID(rs.getString(1));
					connectDAO.setStationID(rs.getString(2));
					connectDAO.setLineID(rs.getString(3));
					connectDAO.setStationNum(Integer.parseInt(rs.getString(4)));
					
					listOfConnect.add(connectDAO);
				}
				return listOfConnect;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<ConnectDAO> connect_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM connect WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					ConnectDAO connectDAO = new ConnectDAO();
					connectDAO.setConnectID(rs.getString(1));
					connectDAO.setStationID(rs.getString(2));
					connectDAO.setLineID(rs.getString(3));
					connectDAO.setStationNum(Integer.parseInt(rs.getString(4)));
					listOfConnect.add(connectDAO);
				}
				return listOfConnect;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 본부만 조회
		public ConnectDAO connect(String connectid){
			ConnectDAO connectDAO = new ConnectDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM connect WHERE connect_ID=?");
				pst.setString(1, connectid);
				rs = pst.executeQuery();
				if(rs.next()) {	
					connectDAO.setConnectID(rs.getString(1));
					connectDAO.setStationID(rs.getString(2));
					connectDAO.setLineID(rs.getString(3));
					connectDAO.setStationNum(Integer.parseInt(rs.getString(4)));
				return connectDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	public String getConnectID() {
		return Connect_ID;
	}
	public void setConnectID(String Connect_ID) {
		this.Connect_ID = Connect_ID;
	}
	
	public int getStationNum() {
		return StationNum;
	}
	public void setStationNum(int StationNum) {
		this.StationNum = StationNum;
	}
	
	public String getStationID() {
		return Station_ID;
	}
	public void setStationID(String Station_ID) {
		this.Station_ID = Station_ID;
	}
	public String getLineID() {
		return Line_ID;
	}
	public void setLineID(String Line_ID) {
		this.Line_ID = Line_ID;
	}
	
}
