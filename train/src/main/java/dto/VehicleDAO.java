package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class VehicleDAO {
	private ArrayList<VehicleDAO> listOfVehicle = new ArrayList<VehicleDAO>();
	private String Vehicle_ID;
	private String Type;
	private String Model;
	private String Status;
	private String Train_ID;
	
	private Connection con;
	private ResultSet rs;
	
	public VehicleDAO() {
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
	public boolean Vehicle_ID_Check(String vehicle_ID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicle WHERE Vehicle_ID = ?");
			pst.setString(1, vehicle_ID);
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
		public boolean Train_ID_Check(String train_ID) {
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM train WHERE Train_ID = ?");
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
	public int insert(VehicleDAO vehicleDAO) {
		if(!Vehicle_ID_Check(vehicleDAO.getVehicleID())) return 0;
		if(!Train_ID_Check(vehicleDAO.getTrainID())) return -2;
		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO Vehicle VALUES (?,?,?,?,?)");
			pst.setString(1, vehicleDAO.getVehicleID());
			pst.setString(2, vehicleDAO.getType());
			pst.setString(3, vehicleDAO.getModel());
			pst.setString(4, vehicleDAO.getStatus());
			pst.setString(5, vehicleDAO.getTrainID());
			
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 수정
		public int Vehicle_Update(VehicleDAO vehicleDAO){
			if(Vehicle_ID_Check(vehicleDAO.getVehicleID())) return 0;
			if(!Train_ID_Check(vehicleDAO.getTrainID())) return -2;
			try {
				PreparedStatement pst = con.prepareStatement("UPDATE Vehicle SET Type=?, Model=?, Status=?, Train_ID=? WHERE Vehicle_ID = ?");
				pst.setString(5, vehicleDAO.getVehicleID());
				pst.setString(1, vehicleDAO.getType());
				pst.setString(2, vehicleDAO.getModel());
				pst.setString(3, vehicleDAO.getStatus());
				pst.setString(4, vehicleDAO.getTrainID());
				return pst.executeUpdate();
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}
		
		// 삭제
		// -1: 실패, 0:존재하지 않은 아이디,1:성공
		public int Vehicle_Delete(VehicleDAO vehicleDAO){
			if(Vehicle_ID_Check(vehicleDAO.getVehicleID())) return 0;
			try {
				PreparedStatement pst = con.prepareStatement("DELETE FROM vehicle WHERE Vehicle_ID=?");
				pst.setString(1, vehicleDAO.getVehicleID());
				pst.executeUpdate();
				return 1;
			} catch (Exception e) {
					e.printStackTrace();
					return -1;
			}
		}

		// 전체조회
		public ArrayList<VehicleDAO> Vehicle_Lookup(){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM Vehicle");
				rs = pst.executeQuery();
				while (rs.next()) {
					VehicleDAO vehicleDAO = new VehicleDAO();
					vehicleDAO.setVehicleID(rs.getString(1));
					vehicleDAO.setType(rs.getString(2));
					vehicleDAO.setModel(rs.getString(3));
					vehicleDAO.setStatus(rs.getString(4));
					vehicleDAO.setTrainID(rs.getString(5));
					
					listOfVehicle.add(vehicleDAO);
				}
				return listOfVehicle;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		//검색
		public ArrayList<VehicleDAO> vehicle_Search(String SF, String ST){
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicle WHERE "+SF+" LIKE ?");
				pst.setString(1, "%"+ST+"%");
				rs = pst.executeQuery();
				while (rs.next()) {
					VehicleDAO vehicleDAO = new VehicleDAO();
					vehicleDAO.setVehicleID(rs.getString(1));
					vehicleDAO.setType(rs.getString(2));
					vehicleDAO.setModel(rs.getString(3));
					vehicleDAO.setStatus(rs.getString(4));
					vehicleDAO.setTrainID(rs.getString(5));
					listOfVehicle.add(vehicleDAO);
				}
				return listOfVehicle;
			} catch (Exception e) {
					e.printStackTrace();
			}
			return null;
		}
		
		// 특정 본부만 조회
		public VehicleDAO vehicle(String vehicleid){
			VehicleDAO vehicleDAO = new VehicleDAO();
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicle WHERE vehicle_ID=?");
				pst.setString(1, vehicleid);
				rs = pst.executeQuery();
				if(rs.next()) {	
					vehicleDAO.setVehicleID(rs.getString(1));
					vehicleDAO.setType(rs.getString(2));
					vehicleDAO.setModel(rs.getString(3));
					vehicleDAO.setStatus(rs.getString(4));
					vehicleDAO.setTrainID(rs.getString(5));
				return vehicleDAO;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	public String getVehicleID() {
		return Vehicle_ID;
	}
	public void setVehicleID(String Vehicle_ID) {
		this.Vehicle_ID = Vehicle_ID;
	}
	public String getType() {
		return Type;
	}
	public void setType(String Type) {
		this.Type = Type;		
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String Status) {
		this.Status = Status;
	}
	public String getModel() {
		return Model;
	}
	public void setModel(String Model) {
		this.Model = Model;
	}

	public String getTrainID() {
		return Train_ID;
	}
	public void setTrainID(String Train_ID) {
		this.Train_ID = Train_ID;
	}
	
}
