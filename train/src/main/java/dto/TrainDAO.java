package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class TrainDAO {
	private ArrayList<TrainDAO> listOfTrain = new ArrayList<TrainDAO>();
	private String Train_ID;
	private String Type;
	private String Condition;
	private int ProductionYear;
	private float Speed;
	
	private Connection con;
	private ResultSet rs;
	
	public TrainDAO() {
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
	public boolean Train_ID_Check(String train_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM train WHERE Train_ID = ?");
			pst.setString(1, train_ID);
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
	public boolean Foreign_Key_Check1(String train_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM operation WHERE train_ID = ?");
			pst.setString(1, train_ID);
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
	
	public boolean Foreign_Key_Check2(String train_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicle WHERE train_ID = ?");
			pst.setString(1, train_ID);
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
	public int insert(TrainDAO trainDAO) {
		if(!Train_ID_Check(trainDAO.getTrainID())) return 0;		
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Train VALUES (?,?,?,?,?)");
			pst.setString(1, trainDAO.getTrainID());
			pst.setString(2, trainDAO.getType());
			pst.setString(3, trainDAO.getCondition());
			pst.setInt(4, trainDAO.getProductionYear());
			pst.setFloat(5, trainDAO.getSpeed());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Train_Update(TrainDAO trainDAO){
			if(Train_ID_Check(trainDAO.getTrainID())) return 0;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Train SET Type=?, Conditon=?, ProductionYear=?, Speed=? WHERE Train_ID = ?");
				pst.setString(1, trainDAO.getType());
				pst.setString(2, trainDAO.getCondition());
				pst.setInt(3, trainDAO.getProductionYear());
				pst.setFloat(4, trainDAO.getSpeed());
				pst.setString(5, trainDAO.getTrainID());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 물품,1:성공
		public int Train_Delete(TrainDAO trainDAO){
			if(Train_ID_Check(trainDAO.getTrainID())) return 0;
			if(Foreign_Key_Check1(trainDAO.getTrainID())) return -2;
			if(Foreign_Key_Check2(trainDAO.getTrainID())) return -3;
						try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM Train WHERE Train_ID=?");
				
				pst.setString(1, trainDAO.getTrainID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<TrainDAO> Train_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Train");
				rs = pst.executeQuery();
				while (rs.next()) {
					TrainDAO trainDAO = new TrainDAO();
					trainDAO.setTrainID(rs.getString(1));
					trainDAO.setType(rs.getString(2));
					trainDAO.setCondition(rs.getString(3));
					trainDAO.setProductionYear(rs.getInt(4));
					trainDAO.setSpeed(rs.getFloat(5));
					listOfTrain.add(trainDAO);
				}
				return listOfTrain;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<TrainDAO> train_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM train WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					TrainDAO trainDAO = new TrainDAO();
					trainDAO.setTrainID(rs.getString(1));
					trainDAO.setType(rs.getString(2));
					trainDAO.setCondition(rs.getString(3));
					trainDAO.setProductionYear(rs.getInt(4));
					trainDAO.setSpeed(rs.getFloat(5));
					listOfTrain.add(trainDAO);
				}
				return listOfTrain;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 열차만 조회
		public TrainDAO train(String trainid){
			TrainDAO trainDAO = new TrainDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM train WHERE train_ID=?");
				pst.setString(1, trainid);
				rs = pst.executeQuery();
				if(rs.next()) {	
				trainDAO.setTrainID(rs.getString(1));
				trainDAO.setType(rs.getString(2));
				trainDAO.setCondition(rs.getString(3));
				trainDAO.setProductionYear(rs.getInt(4));
				trainDAO.setSpeed(rs.getFloat(5));
				return trainDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	
	public String getTrainID() {
		return Train_ID;
	}
	public void setTrainID(String Train_ID) {
		this.Train_ID = Train_ID;
	}
	public String getType() {
		return Type;
	}
	public void setType(String Type) {
		this.Type = Type;
	}
	public String getCondition() {
		return Condition;
	}
	public void setCondition(String Condition) {
		this.Condition = Condition;		
	}
	public float getSpeed() {
		return Speed;
	}
	public void setSpeed(float Speed) {
		this.Speed = Speed;
	}
	public int getProductionYear() {
		return ProductionYear;
	}
	public void setProductionYear(int ProductionYear) {
		this.ProductionYear = ProductionYear;
	}
}
