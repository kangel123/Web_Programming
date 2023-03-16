package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class TraincodeDAO {
	private ArrayList<TraincodeDAO> listOfTraincode = new ArrayList<TraincodeDAO>();
	private String Traincode_ID;
	private String Code;
	private int Day;
	private String StartTime;
	private String EndTime;
	private String Line_ID;
	
	private Connection con;
	private ResultSet rs;
	
	public TraincodeDAO() {
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
	public boolean Traincode_ID_Check(String traincode_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM traincode WHERE Traincode_ID = ?");
			pst.setString(1, traincode_ID);
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
	public boolean Foreign_Key_Check(String traincodeID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM operation WHERE traincode_ID = ?");
			pst.setString(1, traincodeID);
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
	public int insert(TraincodeDAO traincodeDAO) {
		if(!Traincode_ID_Check(traincodeDAO.getTraincodeID())) return 0;
		if(!Line_ID_Check(traincodeDAO.getLineID())) return -2;
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Traincode VALUES (?,?,?,?,?,?)");
			pst.setString(1, traincodeDAO.getTraincodeID());
			pst.setString(2, traincodeDAO.getCode());
			pst.setInt(3, traincodeDAO.getDay());
			pst.setString(4, traincodeDAO.getStartTime());
			pst.setString(5, traincodeDAO.getEndTime());
			pst.setString(6, traincodeDAO.getLineID());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Traincode_Update(TraincodeDAO traincodeDAO){
			if(Traincode_ID_Check(traincodeDAO.getTraincodeID())) return 0;
			if(!Line_ID_Check(traincodeDAO.getLineID())) return -2;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Traincode SET Code=?, Day=? ,StartTime=?, EndTime=?, Line_ID=? WHERE Traincode_ID = ?");
				pst.setString(6, traincodeDAO.getTraincodeID());
				pst.setString(1, traincodeDAO.getCode());
				pst.setInt(2, traincodeDAO.getDay());
				pst.setString(3, traincodeDAO.getStartTime());
				pst.setString(4, traincodeDAO.getEndTime());
				pst.setString(5, traincodeDAO.getLineID());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Traincode_Delete(TraincodeDAO traincodeDAO){
			if(Traincode_ID_Check(traincodeDAO.getTraincodeID())) return 0;
			if(Foreign_Key_Check(traincodeDAO.getTraincodeID())) return -2;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM traincode WHERE Traincode_ID=?");
				pst.setString(1, traincodeDAO.getTraincodeID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<TraincodeDAO> Traincode_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Traincode");
				rs = pst.executeQuery();
				while (rs.next()) {
					TraincodeDAO traincodeDAO = new TraincodeDAO();
					traincodeDAO.setTraincodeID(rs.getString(1));
					traincodeDAO.setCode(rs.getString(2));
					traincodeDAO.setDay(Integer.parseInt(rs.getString(3)));
					traincodeDAO.setStartTime(rs.getString(4));
					traincodeDAO.setEndTime(rs.getString(5));
					traincodeDAO.setLineID(rs.getString(6));
					
					listOfTraincode.add(traincodeDAO);
				}
				return listOfTraincode;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<TraincodeDAO> traincode_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM traincode WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					TraincodeDAO traincodeDAO = new TraincodeDAO();
					traincodeDAO.setTraincodeID(rs.getString(1));
					traincodeDAO.setCode(rs.getString(2));
					traincodeDAO.setDay(Integer.parseInt(rs.getString(3)));
					traincodeDAO.setStartTime(rs.getString(4));
					traincodeDAO.setEndTime(rs.getString(5));
					traincodeDAO.setLineID(rs.getString(6));
					listOfTraincode.add(traincodeDAO);
				}
				return listOfTraincode;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 본부만 조회
		public TraincodeDAO traincode(String traincodeid){
			TraincodeDAO traincodeDAO = new TraincodeDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM traincode WHERE traincode_ID=?");
				pst.setString(1, traincodeid);
				rs = pst.executeQuery();
				if(rs.next()) {	
					traincodeDAO.setTraincodeID(rs.getString(1));
					traincodeDAO.setCode(rs.getString(2));
					traincodeDAO.setDay(Integer.parseInt(rs.getString(3)));
					traincodeDAO.setStartTime(rs.getString(4));
					traincodeDAO.setEndTime(rs.getString(5));
					traincodeDAO.setLineID(rs.getString(6));
				return traincodeDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	public String getTraincodeID() {
		return Traincode_ID;
	}
	public void setTraincodeID(String Traincode_ID) {
		this.Traincode_ID = Traincode_ID;
	}
	public String getCode() {
		return Code;
	}
	public void setCode(String Code) {
		this.Code = Code;		
	}
	public int getDay() {
		return Day;
	}
	public void setDay(int Day) {
		this.Day = Day;		
	}
	public String getStartTime() {
		return StartTime;
	}
	public void setStartTime(String StartTime) {
		this.StartTime = StartTime;
	}
	
	public String getEndTime() {
		return EndTime;
	}
	public void setEndTime(String EndTime) {
		this.EndTime = EndTime;
	}
	
	public String getLineID() {
		return Line_ID;
	}
	public void setLineID(String Line_ID) {
		this.Line_ID = Line_ID;
	}
	
}
