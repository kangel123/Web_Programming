package user;

import java.sql.Connection;
import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dto.EngineerDAO;

public class UserDAO {

	private ArrayList<UserDAO> listOfUser = new ArrayList<UserDAO>();
	private String userID;
	private String userPassword;
	private String userName;
	private String userTel;
	private String userEmaill;
	private String userPosition;
	
	private Connection con;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	// 로그인
	/*
	 * -2: 아이디없음
	 * -1: 서버오류
	 * 0: 비밀번호 틀림
	 * 1: 성공
	 */
	public int login(String userID, String userPassword) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT userPassword FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getString(1).equals(userPassword) ? 1 : 0;
			} else {
				return -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -2;
		}
	}
	
	// 중복여부 확인
	public boolean ID_Check(String userID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID = ?");
			pst.setString(1, userID);
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
	public boolean Foreign_Key_Check(String user_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM engineer WHERE user_ID = ?");
			pst.setString(1, user_ID);
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
	
	// 회원가입
	/*
	 * -1: 서버오류
	 * 0: 이미 존재하는 아이디
	 * 1: 성공
	 */
	public int join(UserDAO userDAO) {
		if(!ID_Check(userDAO.getUserID())) return 0;
		
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO user VALUES (?,?,?,?,?,?)");
			pst.setString(1, userDAO.getUserID());
			pst.setString(2, userDAO.getUserPassword());
			pst.setString(3, userDAO.getUserName());
			pst.setString(4, userDAO.getUserTel());
			pst.setString(5, userDAO.getUserEmaill());
			pst.setString(6, userDAO.getUserPosition());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 내정보 수정
	public int myupdate(UserDAO userDAO) {
		if(ID_Check(userDAO.getUserID())) return 0;
		
		try {
			PreparedStatement pst = con.prepareStatement("UPDATE user SET userPassword=?, userName=?, userTel=?, userEmaill=? WHERE userID=?");
			pst.setString(5, userDAO.getUserID());
			pst.setString(1, userDAO.getUserPassword());
			pst.setString(2, userDAO.getUserName());
			pst.setString(3, userDAO.getUserTel());
			pst.setString(4, userDAO.getUserEmaill());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 전체조회
			public ArrayList<UserDAO> User_Lookup(){
				try {
					PreparedStatement pst = con.prepareStatement("SELECT * FROM User");
					rs = pst.executeQuery();
					while (rs.next()) {
						UserDAO userDAO = new UserDAO();
						userDAO.setUserID(rs.getString(1));
						userDAO.setUserPassword(rs.getString(2));
						userDAO.setUserName(rs.getString(3));
						userDAO.setUserTel(rs.getString(4));
						userDAO.setUserEmaill(rs.getString(5));
						userDAO.setUserPosition(rs.getString(6));
						listOfUser.add(userDAO);
					}
					return listOfUser;
				} catch (Exception e) {
						e.printStackTrace();
				}
				return null;
			}
			
			//검색
			public ArrayList<UserDAO> user_Search(String SF, String ST){
				try {
					PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE "+SF+" LIKE ?");
					pst.setString(1, "%"+ST+"%");
					rs = pst.executeQuery();
					while (rs.next()) {
						UserDAO userDAO = new UserDAO();
						userDAO.setUserID(rs.getString(1));
						userDAO.setUserPassword(rs.getString(2));
						userDAO.setUserName(rs.getString(3));
						userDAO.setUserTel(rs.getString(4));
						userDAO.setUserEmaill(rs.getString(5));
						userDAO.setUserPosition(rs.getString(6));
						listOfUser.add(userDAO);
					}
					return listOfUser;
				} catch (Exception e) {
						e.printStackTrace();
				}
				return null;
			}
			
			// 유저 정보수정
			public int update(UserDAO userDAO) {
				if(ID_Check(userDAO.getUserID())) return 0;
				
				try {
					PreparedStatement pst = con.prepareStatement("UPDATE user SET userPassword=?, userName=?, userTel=?, userEmaill=?, userPosition=? WHERE userID=?");
					pst.setString(1, userDAO.getUserPassword());
					pst.setString(2, userDAO.getUserName());
					pst.setString(3, userDAO.getUserTel());
					pst.setString(4, userDAO.getUserEmaill());
					pst.setString(5, userDAO.getUserPosition());
					pst.setString(6, userDAO.getUserID());					
					return pst.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
					return -1;
				}
			}
	
			// 삭제
			// -1: 실패, 0:존재하지 않은 아이디,1:성공, -2:foreign key
			public int User_Delete(UserDAO userDAO){
				if(ID_Check(userDAO.getUserID())) return 0;
				if(Foreign_Key_Check(userDAO.getUserID())) return -2;				
				try {
					PreparedStatement pst = con.prepareStatement("DELETE FROM user WHERE userID=?");
					pst.setString(1, userDAO.getUserID());
					pst.executeUpdate();
					return 1;
				} catch (Exception e) {
						e.printStackTrace();
						return -1;
				}
			}
	// 유저 데이터 가져오기
	public UserDAO getUser(String userID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID=?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				UserDAO userDAO = new UserDAO();
				userDAO.setUserID(rs.getString(1));
				userDAO.setUserPassword(rs.getString(2));
				userDAO.setUserName(rs.getString(3));
				userDAO.setUserTel(rs.getString(4));
				userDAO.setUserEmaill(rs.getString(5));
				userDAO.setUserPosition(rs.getString(6));
				return userDAO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	// 기관사 데이터 가져오기
		public EngineerDAO getEngineer(String userID) {
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM engineer WHERE user_ID=?");
				pst.setString(1, userID);
				rs = pst.executeQuery();
				if (rs.next()) {
					EngineerDAO engineerDAO = new EngineerDAO();
					engineerDAO.setEngineerID(rs.getString(1));
					engineerDAO.setName(rs.getString(2));
					engineerDAO.setCareerPeriod(Integer.parseInt(rs.getString(3)));
					engineerDAO.setMajorCareer(rs.getString(4));
					engineerDAO.setSalary(Integer.parseInt(rs.getString(5)));
					engineerDAO.setTel(rs.getString(6));
					engineerDAO.setHeadquarterID(rs.getString(7));
					engineerDAO.setUserID(rs.getString(8));
					return engineerDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;		
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getUserEmaill() {
		return userEmaill;
	}
	public void setUserEmaill(String userEmaill) {
		this.userEmaill = userEmaill;
	}
	public String getUserPosition() {
		return userPosition;
	}
	public void setUserPosition(String userPosition) {
		this.userPosition = userPosition;
	}
}
