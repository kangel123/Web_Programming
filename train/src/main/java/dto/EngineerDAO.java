package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class EngineerDAO {
	private ArrayList<EngineerDAO> listOfEngineer = new ArrayList<EngineerDAO>();
	private String Engineer_ID;
	private String Name;
	private int CareerPeriod;
	private String MajorCareer;
	private String Tel;
	private int Salary;
	private String Headquarter_ID;
	private String User_ID;
	
	private Connection con;
	private ResultSet rs;
	
	public EngineerDAO() {
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
	public boolean Engineer_ID_Check(String engineer_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM engineer WHERE Engineer_ID = ?");
			pst.setString(1, engineer_ID);
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
	public boolean User_ID_Check(String user_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID=? and userPosition=?");
			pst.setString(1, user_ID);
			pst.setString(2, "engineer");
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
	
	public boolean Foreign_Key_Check(String engineerID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM operation WHERE engineer_ID = ?");
			pst.setString(1, engineerID);
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
	public int insert(EngineerDAO engineerDAO) {
		if(!Engineer_ID_Check(engineerDAO.getEngineerID())) return 0;
		if(!Headquarter_ID_Check(engineerDAO.getHeadquarterID())) return -2;
		if(!User_ID_Check(engineerDAO.getUserID())) return -3;
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Engineer VALUES (?,?,?,?,?,?,?,?)");
			pst.setString(1, engineerDAO.getEngineerID());
			pst.setString(2, engineerDAO.getName());
			pst.setInt(3, engineerDAO.getCareerPeriod());
			pst.setString(4, engineerDAO.getMajorCareer());
			pst.setString(5, engineerDAO.getTel());
			pst.setInt(6, engineerDAO.getSalary());
			pst.setString(7, engineerDAO.getHeadquarterID());
			pst.setString(8, engineerDAO.getUserID());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Engineer_Update(EngineerDAO engineerDAO){
			if(Engineer_ID_Check(engineerDAO.getEngineerID())) return 0;
			if(!Headquarter_ID_Check(engineerDAO.getHeadquarterID())) return -2;
			if(!User_ID_Check(engineerDAO.getUserID())) return -3;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Engineer SET Name=?, CareerPeriod=?, MajorCareer=?, Tel=?, Salary=?, Headquarter_ID=?, User_ID=? WHERE Engineer_ID = ?");
				pst.setString(8, engineerDAO.getEngineerID());
				pst.setString(1, engineerDAO.getName());
				pst.setInt(2, engineerDAO.getCareerPeriod());
				pst.setString(3, engineerDAO.getMajorCareer());
				pst.setString(4, engineerDAO.getTel());
				pst.setInt(5, engineerDAO.getSalary());
				pst.setString(6, engineerDAO.getHeadquarterID());
				pst.setString(7, engineerDAO.getUserID());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Engineer_Delete(EngineerDAO engineerDAO){
			if(Engineer_ID_Check(engineerDAO.getEngineerID())) return 0;
			if(Foreign_Key_Check(engineerDAO.getEngineerID())) return -2;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM engineer WHERE Engineer_ID=?");
				pst.setString(1, engineerDAO.getEngineerID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<EngineerDAO> Engineer_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Engineer");
				rs = pst.executeQuery();
				while (rs.next()) {
					EngineerDAO engineerDAO = new EngineerDAO();
					engineerDAO.setEngineerID(rs.getString(1));
					engineerDAO.setName(rs.getString(2));
					engineerDAO.setCareerPeriod(Integer.parseInt(rs.getString(3)));
					engineerDAO.setMajorCareer(rs.getString(4));
					engineerDAO.setTel(rs.getString(5));
					engineerDAO.setSalary(Integer.parseInt(rs.getString(6)));
					engineerDAO.setHeadquarterID(rs.getString(7));
					engineerDAO.setUserID(rs.getString(8));
					
					listOfEngineer.add(engineerDAO);
				}
				return listOfEngineer;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<EngineerDAO> engineer_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM engineer WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					EngineerDAO engineerDAO = new EngineerDAO();
					engineerDAO.setEngineerID(rs.getString(1));
					engineerDAO.setName(rs.getString(2));
					engineerDAO.setCareerPeriod(Integer.parseInt(rs.getString(3)));
					engineerDAO.setMajorCareer(rs.getString(4));
					engineerDAO.setTel(rs.getString(5));
					engineerDAO.setSalary(Integer.parseInt(rs.getString(6)));
					engineerDAO.setHeadquarterID(rs.getString(7));
					engineerDAO.setUserID(rs.getString(8));
					listOfEngineer.add(engineerDAO);
				}
				return listOfEngineer;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 본부만 조회
		public EngineerDAO engineer(String engineerid){
			EngineerDAO engineerDAO = new EngineerDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM engineer WHERE engineer_ID=?");
				pst.setString(1, engineerid);
				rs = pst.executeQuery();
				if(rs.next()) {	
					engineerDAO.setEngineerID(rs.getString(1));
					engineerDAO.setName(rs.getString(2));
					engineerDAO.setCareerPeriod(Integer.parseInt(rs.getString(3)));
					engineerDAO.setMajorCareer(rs.getString(4));
					engineerDAO.setTel(rs.getString(5));
					engineerDAO.setSalary(Integer.parseInt(rs.getString(6)));
					engineerDAO.setHeadquarterID(rs.getString(7));
					engineerDAO.setUserID(rs.getString(8));
				return engineerDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	public String getEngineerID() {
		return Engineer_ID;
	}
	public void setEngineerID(String Engineer_ID) {
		this.Engineer_ID = Engineer_ID;
	}
	public String getName() {
		return Name;
	}
	public void setName(String Name) {
		this.Name = Name;		
	}
	public String getMajorCareer() {
		return MajorCareer;
	}
	public void setMajorCareer(String MajorCareer) {
		this.MajorCareer = MajorCareer;
	}
	public int getCareerPeriod() {
		return CareerPeriod;
	}
	public void setCareerPeriod(int CareerPeriod) {
		this.CareerPeriod = CareerPeriod;
	}
	public String getTel() {
		return Tel;
	}
	public void setTel(String Tel) {
		this.Tel = Tel;
	}
	
	public int getSalary() {
		return Salary;
	}
	public void setSalary(int Salary) {
		this.Salary = Salary;
	}
	
	public String getHeadquarterID() {
		return Headquarter_ID;
	}
	public void setHeadquarterID(String Headquarter_ID) {
		this.Headquarter_ID = Headquarter_ID;
	}
	
	public String getUserID() {
		return User_ID;
	}
	public void setUserID(String User_ID) {
		this.User_ID = User_ID;
	}
	
}
