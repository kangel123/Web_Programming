package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class HeadquarterDAO {
	private ArrayList<HeadquarterDAO> listOfHeadquarter = new ArrayList<HeadquarterDAO>();
	private String Headquarter_ID;
	private String Planet;
	private String Name;
	private String Address;
	private String Tel;
	private String ManagerName;
	
	private Connection con;
	private ResultSet rs;
	
	public HeadquarterDAO() {
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
	public boolean Headquarter_ID_Check(String headquarter_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM headquarter WHERE Headquarter_ID = ?");
			pst.setString(1, headquarter_ID);
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
	public boolean Foreign_Key_Check1(String headquarter_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM station WHERE Headquarter_ID = ?");
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
	public boolean Foreign_Key_Check2(String headquarter_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM engineer WHERE Headquarter_ID = ?");
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
	
	// 등록
	public int insert(HeadquarterDAO headquarterDAO) {
		if(!Headquarter_ID_Check(headquarterDAO.getHeadquarterID())) return 0;
		
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Headquarter VALUES (?,?,?,?,?,?)");
			pst.setString(1, headquarterDAO.getHeadquarterID());
			pst.setString(2, headquarterDAO.getPlanet());
			pst.setString(3, headquarterDAO.getName());
			pst.setString(4, headquarterDAO.getAddress());
			pst.setString(5, headquarterDAO.getTel());
			pst.setString(6, headquarterDAO.getManagerName());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Headquarter_Update(HeadquarterDAO headquarterDAO){
			if(Headquarter_ID_Check(headquarterDAO.getHeadquarterID())) return 0;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Headquarter SET Planet=?, Name=?, Address=?, Tel=?, ManagerName=? WHERE Headquarter_ID = ?");
				pst.setString(1, headquarterDAO.getPlanet());
				pst.setString(2, headquarterDAO.getName());
				pst.setString(3, headquarterDAO.getAddress());
				pst.setString(4, headquarterDAO.getTel());
				pst.setString(5, headquarterDAO.getManagerName());
				pst.setString(6, headquarterDAO.getHeadquarterID());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Headquarter_Delete(HeadquarterDAO headquarterDAO){
			if(Headquarter_ID_Check(headquarterDAO.getHeadquarterID())) return 0;
			if(Foreign_Key_Check1(headquarterDAO.getHeadquarterID())) return -2;
			if(Foreign_Key_Check1(headquarterDAO.getHeadquarterID())) return -3;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM headquarter WHERE Headquarter_ID=?");
				pst.setString(1, headquarterDAO.getHeadquarterID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<HeadquarterDAO> Headquarter_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Headquarter");
				rs = pst.executeQuery();
				while (rs.next()) {
					HeadquarterDAO headquarterDAO = new HeadquarterDAO();
					headquarterDAO.setHeadquarterID(rs.getString(1));
					headquarterDAO.setPlanet(rs.getString(2));
					headquarterDAO.setName(rs.getString(3));
					headquarterDAO.setAddress(rs.getString(4));
					headquarterDAO.setTel(rs.getString(5));
					headquarterDAO.setManagerName(rs.getString(6));
					listOfHeadquarter.add(headquarterDAO);
				}
				return listOfHeadquarter;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<HeadquarterDAO> headquarter_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM headquarter WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					HeadquarterDAO headquarterDAO = new HeadquarterDAO();
					headquarterDAO.setHeadquarterID(rs.getString(1));
					headquarterDAO.setPlanet(rs.getString(2));
					headquarterDAO.setName(rs.getString(3));
					headquarterDAO.setAddress(rs.getString(4));
					headquarterDAO.setTel(rs.getString(5));
					headquarterDAO.setManagerName(rs.getString(6));
					listOfHeadquarter.add(headquarterDAO);
				}
				return listOfHeadquarter;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 본부만 조회
		public HeadquarterDAO headquarter(String headquarterid){
			HeadquarterDAO headquarterDAO = new HeadquarterDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM headquarter WHERE headquarter_ID=?");
				pst.setString(1, headquarterid);
				rs = pst.executeQuery();
				if(rs.next()) {	
				headquarterDAO.setHeadquarterID(rs.getString(1));
				headquarterDAO.setPlanet(rs.getString(2));
				headquarterDAO.setName(rs.getString(3));
				headquarterDAO.setAddress(rs.getString(4));
				headquarterDAO.setTel(rs.getString(5));
				headquarterDAO.setManagerName(rs.getString(6));
				return headquarterDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	public String getHeadquarterID() {
		return Headquarter_ID;
	}
	public void setHeadquarterID(String Headquarter_ID) {
		this.Headquarter_ID = Headquarter_ID;
	}
	public String getPlanet() {
		return Planet;
	}
	public void setPlanet(String Planet) {
		this.Planet = Planet;
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
}
