package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class LineDAO {
	private ArrayList<LineDAO> listOfLine = new ArrayList<LineDAO>();
	private String Line_ID;
	private String Name;
	private int Capacity;
	private String Start_station;
	private String Finish_station;
	
	private Connection con;
	private ResultSet rs;
	
	public LineDAO() {
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
	public boolean Line_ID_Check(String line_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM line WHERE Line_ID = ?");
			pst.setString(1, line_ID);
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
	public boolean Foreign_Key_Check1(String line_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM traincode WHERE Line_ID = ?");
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
	public boolean Foreign_Key_Check2(String line_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM connect WHERE Line_ID = ?");
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
	public int insert(LineDAO lineDAO) {
		if(!Line_ID_Check(lineDAO.getLineID())) return 0;
		
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Line VALUES (?,?,?,?,?)");
			pst.setString(1, lineDAO.getLineID());
			pst.setString(2, lineDAO.getName());
			pst.setInt(3, lineDAO.getCapacity());
			pst.setString(4, lineDAO.getStart_station());
			pst.setString(5, lineDAO.getFinish_station());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Line_Update(LineDAO lineDAO){
			if(Line_ID_Check(lineDAO.getLineID())) return 0;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Line SET Name=?, Capacity=?, Start_station=?, Finish_station=? WHERE Line_ID = ?");
				pst.setString(1, lineDAO.getName());
				pst.setInt(2, lineDAO.getCapacity());
				pst.setString(3, lineDAO.getStart_station());
				pst.setString(4, lineDAO.getFinish_station());
				pst.setString(5, lineDAO.getLineID());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Line_Delete(LineDAO lineDAO){
			if(Line_ID_Check(lineDAO.getLineID())) return 0;
			if(Foreign_Key_Check1(lineDAO.getLineID())) return -2;
			if(Foreign_Key_Check2(lineDAO.getLineID())) return -3;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM line WHERE Line_ID=?");
				pst.setString(1, lineDAO.getLineID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<LineDAO> Line_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Line");
				rs = pst.executeQuery();
				while (rs.next()) {
					LineDAO lineDAO = new LineDAO();
					lineDAO.setLineID(rs.getString(1));
					lineDAO.setName(rs.getString(2));
					lineDAO.setCapacity(rs.getInt(3));
					lineDAO.setStart_station(rs.getString(4));
					lineDAO.setFinish_station(rs.getString(5));
					listOfLine.add(lineDAO);
				}
				return listOfLine;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<LineDAO> line_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM line WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					LineDAO lineDAO = new LineDAO();
					lineDAO.setLineID(rs.getString(1));
					lineDAO.setName(rs.getString(2));
					lineDAO.setCapacity(rs.getInt(3));
					lineDAO.setStart_station(rs.getString(4));
					lineDAO.setFinish_station(rs.getString(5));
					listOfLine.add(lineDAO);
				}
				return listOfLine;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 본부만 조회
		public LineDAO line(String lineid){
			LineDAO lineDAO = new LineDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM line WHERE line_ID=?");
				pst.setString(1, lineid);
				rs = pst.executeQuery();
				if(rs.next()) {	
				lineDAO.setLineID(rs.getString(1));
				lineDAO.setName(rs.getString(2));
				lineDAO.setCapacity(rs.getInt(3));
				lineDAO.setStart_station(rs.getString(4));
				lineDAO.setFinish_station(rs.getString(5));
				return lineDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	public String getLineID() {
		return Line_ID;
	}
	public void setLineID(String Line_ID) {
		this.Line_ID = Line_ID;
	}
	
	public String getName() {
		return Name;
	}
	public void setName(String Name) {
		this.Name = Name;		
	}
	public String getStart_station() {
		return Start_station;
	}
	public void setStart_station(String Start_station) {
		this.Start_station = Start_station;
	}
	public int getCapacity() {
		return Capacity;
	}
	public void setCapacity(int Capacity) {
		this.Capacity = Capacity;
	}
	public String getFinish_station() {
		return Finish_station;
	}
	public void setFinish_station(String Finish_station) {
		this.Finish_station = Finish_station;
	}
}
