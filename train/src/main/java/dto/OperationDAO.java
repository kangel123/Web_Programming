package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class OperationDAO {
	private ArrayList<OperationDAO> listOfOperation = new ArrayList<OperationDAO>();
	private String Operation_ID;
	private String TrainCode_ID;
	private String Train_ID;
	private String Status;
	private String Updatetime;
	private int CurrentStationNum;
	private String Engineer_ID;
	
	private Connection con;
	private ResultSet rs;
	
	public OperationDAO() {
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
	public boolean Operation_ID_Check(String operation_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM operation WHERE Operation_ID = ?");
			pst.setString(1, operation_ID);
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
	public boolean TrainCode_ID_Check(String traincode_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM traincode WHERE traincode_ID = ?");
			pst.setString(1, traincode_ID);
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
	public boolean Train_ID_Check(String train_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM train WHERE train_ID = ?");
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
	public boolean Engineer_ID_Check(String engineer_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM engineer WHERE engineer_ID = ?");
			pst.setString(1, engineer_ID);
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
	public int insert(OperationDAO operationDAO) {
		if(!Operation_ID_Check(operationDAO.getOperationID())) return 0;
		if(!TrainCode_ID_Check(operationDAO.getTrainCodeID())) return -2;
		if(!Train_ID_Check(operationDAO.getTrainID())) return -3;
		if(!Engineer_ID_Check(operationDAO.getEngineerID())) return -4;
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Operation(TrainCode_ID, Train_ID, Status, Updatetime, CurrentStationNum, Engineer_ID) VALUES (?,?,?,?,?,?)");
			pst.setString(1, operationDAO.getTrainCodeID());
			pst.setString(2, operationDAO.getTrainID());
			pst.setString(3, operationDAO.getStatus());
			pst.setString(4, operationDAO.getUpdatetime());
			pst.setInt(5, operationDAO.getCurrentStationNum());
			pst.setString(6, operationDAO.getEngineerID());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	// 수정
	public int Operation_Update(OperationDAO operationDAO){
		if(Operation_ID_Check(operationDAO.getOperationID())) return 0;
		if(!TrainCode_ID_Check(operationDAO.getTrainCodeID())) return -2;
		if(!Train_ID_Check(operationDAO.getTrainID())) return -3;
		if(!Engineer_ID_Check(operationDAO.getEngineerID())) return -4;
		try {
			PreparedStatement pst = con.prepareStatement("UPDATE Operation SET TrainCode_ID=?, Train_ID=?, Status=?, Updatetime=?, CurrentStationNum=?,Engineer_ID=? WHERE Operation_ID = ?");
			pst.setString(7, operationDAO.getOperationID());
			pst.setString(1, operationDAO.getTrainCodeID());
			pst.setString(2, operationDAO.getTrainID());
			pst.setString(3, operationDAO.getStatus());
			pst.setString(4, operationDAO.getUpdatetime());
			pst.setInt(5, operationDAO.getCurrentStationNum());
			pst.setString(6, operationDAO.getEngineerID());
			return pst.executeUpdate();
		} catch (Exception e) {
				e.printStackTrace();
				return -1;
		}
	}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Operation_Delete(OperationDAO operationDAO){
			if(Operation_ID_Check(operationDAO.getOperationID())) return 0;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM operation WHERE Operation_ID=?");
				pst.setString(1, operationDAO.getOperationID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<OperationDAO> Operation_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Operation");
				rs = pst.executeQuery();
				while (rs.next()) {
					OperationDAO operationDAO = new OperationDAO();
					operationDAO.setOperationID(rs.getString(1));
					operationDAO.setTrainCodeID(rs.getString(2));
					operationDAO.setTrainID(rs.getString(3));
					operationDAO.setStatus(rs.getString(4));
					operationDAO.setUpdatetime(rs.getString(5));
					operationDAO.setCurrentStationNum(Integer.parseInt(rs.getString(6)));
					operationDAO.setEngineerID(rs.getString(7));
					
					listOfOperation.add(operationDAO);
				}
				return listOfOperation;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<OperationDAO> operation_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM operation WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					OperationDAO operationDAO = new OperationDAO();
					operationDAO.setOperationID(rs.getString(1));
					operationDAO.setTrainCodeID(rs.getString(2));
					operationDAO.setTrainID(rs.getString(3));
					operationDAO.setStatus(rs.getString(4));
					operationDAO.setUpdatetime(rs.getString(5));
					operationDAO.setCurrentStationNum(Integer.parseInt(rs.getString(6)));
					operationDAO.setEngineerID(rs.getString(7));
					listOfOperation.add(operationDAO);
				}
				return listOfOperation;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 operation만 조회
		public OperationDAO operation(String operationid){
			OperationDAO operationDAO = new OperationDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM operation WHERE operation_ID=?");
				pst.setString(1, operationid);
				rs = pst.executeQuery();
				if(rs.next()) {	
					operationDAO.setOperationID(rs.getString(1));
					operationDAO.setTrainCodeID(rs.getString(2));
					operationDAO.setTrainID(rs.getString(3));
					operationDAO.setStatus(rs.getString(4));
					operationDAO.setUpdatetime(rs.getString(5));
					operationDAO.setCurrentStationNum(Integer.parseInt(rs.getString(6)));
					operationDAO.setEngineerID(rs.getString(7));
				return operationDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		// 해당 기관사에 대한 운행정보 
		public ArrayList<OperationDAO> engineer_operation_lookup(String engineerID){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Operation where engineer_id=?");
				pst.setString(1, engineerID);
				rs = pst.executeQuery();
				while (rs.next()) {
					OperationDAO operationDAO = new OperationDAO();
					operationDAO.setOperationID(rs.getString(1));
					operationDAO.setTrainCodeID(rs.getString(2));
					operationDAO.setTrainID(rs.getString(3));
					operationDAO.setStatus(rs.getString(4));
					operationDAO.setUpdatetime(rs.getString(5));
					operationDAO.setCurrentStationNum(Integer.parseInt(rs.getString(6)));
					operationDAO.setEngineerID(rs.getString(7));
					
					listOfOperation.add(operationDAO);
				}
				return listOfOperation;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		// 해당 기관사에 대한 운행(현재역)
		public String engineer_operation_station(int currentstation, String engineerID, String operationID){
					try {
						PreparedStatement pst = con.prepareStatement("select station.name from station, (select connect.station_id, connect.line_id from operation join connect, traincode where operation.engineer_id = ? and connect.stationnum=? and connect.line_id=traincode.line_id and operation.operation_id=?) con where station.station_id=con.station_id;");
						pst.setString(1, engineerID);
						pst.setInt(2, currentstation);
						pst.setString(3, operationID);
						rs = pst.executeQuery();
						while (rs.next()) {			
								return rs.getString(1);
						}
					} catch (Exception e) {
							e.printStackTrace();
					}
					return "-";
				}
				// 해당 기관사에 대한 운행(날짜)
				public String engineer_operation_day(String engineerID,String operationID){
					try {
						PreparedStatement pst = con.prepareStatement("select day from traincode natural join operation where operation.engineer_id=? and operation.operation_id=?;");
						pst.setString(1, engineerID);
						pst.setString(2, operationID);
						rs = pst.executeQuery();
						while (rs.next()) {	
								return rs.getString(1);
						}
					} catch (Exception e) {
							e.printStackTrace();
					}
					return null;
				}
		

	public String getOperationID() {
		return Operation_ID;
	}
	public void setOperationID(String Operation_ID) {
		this.Operation_ID = Operation_ID;
	}
	public String getTrainCodeID() {
		return TrainCode_ID;
	}
	public void setTrainCodeID(String TrainCode_ID) {
		this.TrainCode_ID = TrainCode_ID;		
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String Status) {
		this.Status = Status;
	}
	public String getTrainID() {
		return Train_ID;
	}
	public void setTrainID(String Train_ID) {
		this.Train_ID = Train_ID;
	}
	public String getUpdatetime() {
		return Updatetime;
	}
	public void setUpdatetime(String Updatetime) {
		this.Updatetime = Updatetime;
	}
	public int getCurrentStationNum() {
		return CurrentStationNum;
	}
	public void setCurrentStationNum(int CurrentStationNum) {
		this.CurrentStationNum = CurrentStationNum;
	}
	public String getEngineerID() {
		return Engineer_ID;
	}
	public void setEngineerID(String Engineer_ID) {
		this.Engineer_ID = Engineer_ID;
	}
	
}
