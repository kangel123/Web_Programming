package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class StationDAO {
	private ArrayList<StationDAO> listOfStation = new ArrayList<StationDAO>();
	private String Station_ID;
	private String Name;
	private String Address;
	private String Tel;
	private String ManagerName;
	private int Budget;
	private String Headquarter_ID;
	
	private Connection con;
	private ResultSet rs;
	
	public StationDAO() {
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
	public boolean Station_ID_Check(String station_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM station WHERE Station_ID = ?");
			pst.setString(1, station_ID);
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
	public boolean Headquarter_ID_Check(String headquarter_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM headquarter WHERE Headquarter_ID = ?");
			pst.setString(1, headquarter_ID);
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
	public boolean Foreign_Key_Check(String station_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM connect WHERE station_ID = ?");
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
	
	// 등록
	public int insert(StationDAO stationDAO) {
		if(!Station_ID_Check(stationDAO.getStationID())) return 0;
		if(!Headquarter_ID_Check(stationDAO.getHeadquarterID())) return -2;
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Station VALUES (?,?,?,?,?,?,?)");
			pst.setString(1, stationDAO.getStationID());
			pst.setString(2, stationDAO.getName());
			pst.setString(3, stationDAO.getAddress());
			pst.setString(4, stationDAO.getTel());
			pst.setString(5, stationDAO.getManagerName());
			pst.setInt(6, stationDAO.getBudget());
			pst.setString(7, stationDAO.getHeadquarterID());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Station_Update(StationDAO stationDAO){
			if(Station_ID_Check(stationDAO.getStationID())) return 0;
			if(!Headquarter_ID_Check(stationDAO.getHeadquarterID())) return -2;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Station SET Name=?, Address=?, Tel=?, ManagerName=?, Budget=?, Headquarter_ID=? WHERE Station_ID = ?");
				pst.setString(7, stationDAO.getStationID());
				pst.setString(1, stationDAO.getName());
				pst.setString(2, stationDAO.getAddress());
				pst.setString(3, stationDAO.getTel());
				pst.setString(4, stationDAO.getManagerName());
				pst.setInt(5, stationDAO.getBudget());
				pst.setString(6, stationDAO.getHeadquarterID());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Station_Delete(StationDAO stationDAO){
			if(Station_ID_Check(stationDAO.getStationID())) return 0;
			if(Foreign_Key_Check(stationDAO.getStationID())) return -2;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM station WHERE Station_ID=?");
				pst.setString(1, stationDAO.getStationID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<StationDAO> Station_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Station");
				rs = pst.executeQuery();
				while (rs.next()) {
					StationDAO stationDAO = new StationDAO();
					stationDAO.setStationID(rs.getString(1));
					stationDAO.setName(rs.getString(2));
					stationDAO.setAddress(rs.getString(3));
					stationDAO.setTel(rs.getString(4));
					stationDAO.setManagerName(rs.getString(5));
					stationDAO.setBudget(Integer.parseInt(rs.getString(6)));
					stationDAO.setHeadquarterID(rs.getString(7));
					
					listOfStation.add(stationDAO);
				}
				return listOfStation;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<StationDAO> station_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM station WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					StationDAO stationDAO = new StationDAO();
					stationDAO.setStationID(rs.getString(1));
					stationDAO.setName(rs.getString(2));
					stationDAO.setAddress(rs.getString(3));
					stationDAO.setTel(rs.getString(4));
					stationDAO.setManagerName(rs.getString(5));
					stationDAO.setBudget(Integer.parseInt(rs.getString(6)));
					stationDAO.setHeadquarterID(rs.getString(7));
					listOfStation.add(stationDAO);
				}
				return listOfStation;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 본부만 조회
		public StationDAO station(String stationid){
			StationDAO stationDAO = new StationDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM station WHERE station_ID=?");
				pst.setString(1, stationid);
				rs = pst.executeQuery();
				if(rs.next()) {	
					stationDAO.setStationID(rs.getString(1));
					stationDAO.setName(rs.getString(2));
					stationDAO.setAddress(rs.getString(3));
					stationDAO.setTel(rs.getString(4));
					stationDAO.setManagerName(rs.getString(5));
					stationDAO.setBudget(Integer.parseInt(rs.getString(6)));
					stationDAO.setHeadquarterID(rs.getString(7));
				return stationDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	public String getStationID() {
		return Station_ID;
	}
	public void setStationID(String Station_ID) {
		this.Station_ID = Station_ID;
	}
	public String getName() {
		return Name;
	}
	public void setName(String Name) {
		this.Name = Name;		
	}
	public String getTel() {
		return Tel;
	}
	public void setTel(String Tel) {
		this.Tel = Tel;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String Address) {
		this.Address = Address;
	}
	public String getManagerName() {
		return ManagerName;
	}
	public void setManagerName(String ManagerName) {
		this.ManagerName = ManagerName;
	}
	
	public int getBudget() {
		return Budget;
	}
	public void setBudget(int Budget) {
		this.Budget = Budget;
	}
	
	public String getHeadquarterID() {
		return Headquarter_ID;
	}
	public void setHeadquarterID(String Headquarter_ID) {
		this.Headquarter_ID = Headquarter_ID;
	}
	
}
