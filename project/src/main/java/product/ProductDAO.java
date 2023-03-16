package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class ProductDAO {
	private ArrayList<ProductDAO> listOfProduct = new ArrayList<ProductDAO>();
	private String productID;
	private String productName;
	private String category;
	private String manufacturer;
	private String unitPrice; 
	private String unitStock; 
	private String description;
	private String situation;  
	private String seller;
	
	private Connection con;
	private ResultSet rs;
	
	
	public ProductDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/shop";
			String dbID = "root";
			String dbPassword = "kjw98800";
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 물품 확인
		public boolean Product_Check(String productID) {
			try {
				PreparedStatement pst = con.prepareStatement("SELECT * FROM product WHERE productID = ?");
				pst.setString(1, productID);
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
		public int registration(ProductDAO productDAO) {
			
			try {
				PreparedStatement pst = con.prepareStatement("INSERT INTO product VALUES (?,?,?,?,?,?,?,?,?)");
				pst.setString(1, productDAO.getProductID());
				pst.setString(2, productDAO.getProductName());
				pst.setString(3, productDAO.getCategory());
				pst.setString(4, productDAO.getManufacturer());
				pst.setString(5, productDAO.getUnitPrice());
				pst.setString(6, productDAO.getUnitStock());
				pst.setString(7, productDAO.getDescription());
				pst.setString(8, productDAO.getSituation());
				pst.setString(9, productDAO.getSeller());
				
				return pst.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			}
		}
	
	// 수정
	public int Product_Update(ProductDAO productDAO){
		if(!Product_Check(productDAO.getProductID())) return 0;
		try {
			PreparedStatement pst = con.prepareStatement("UPDATE product SET productName=?, Category=?, Manufacturer=?, UnitPrice=?, UnitStock=?, Description=?, Situation=?, Seller=? WHERE productID = ?");
			pst.setString(1, productDAO.getProductName());
			pst.setString(2, productDAO.getCategory());
			pst.setString(3, productDAO.getManufacturer());
			pst.setString(4, productDAO.getUnitPrice());
			pst.setString(5, productDAO.getUnitStock());
			pst.setString(6, productDAO.getDescription());
			if(getUnitStock().equals("0")) {
				pst.setString(7, "판매완료");
			}
			else {
				pst.setString(7, productDAO.getSituation());
			}
			pst.setString(8, productDAO.getSeller());
			pst.setString(9, productDAO.getProductID());
			return pst.executeUpdate();
		} catch (Exception e) {
				e.printStackTrace();
				return -1;
		}
	}
	
	// 삭제
	// -1: 실패, 0:존재하지 않은 물품,1:성공
	public int Product_Delete(ProductDAO productDAO){
		if(!Product_Check(productDAO.getProductID())) return 0;
		try {
			PreparedStatement pst = con.prepareStatement("DELETE FROM product WHERE productID=?");
			
			pst.setString(1, productDAO.getProductID());
			pst.executeUpdate();
			return 1;
		} catch (Exception e) {
				e.printStackTrace();
				return -1;
		}
	}
	
	// 전체조회
	public ArrayList<ProductDAO> Product_Lookup(){
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM product");
			rs = pst.executeQuery();
			while (rs.next()) {
				ProductDAO productDAO = new ProductDAO();
				productDAO.setProductID(rs.getString(1));
				productDAO.setProductName(rs.getString(2));
				productDAO.setCategory(rs.getString(3));
				productDAO.setManufacturer(rs.getString(4));
				productDAO.setUnitPrice(rs.getString(5));
				productDAO.setUnitStock(rs.getString(6));
				productDAO.setDescription(rs.getString(7));
				productDAO.setSituation(rs.getString(8));
				productDAO.setSeller(rs.getString(9));
				listOfProduct.add(productDAO);
			}
			return listOfProduct;
		} catch (Exception e) {
				e.printStackTrace();
		}
		return null;
	}
	
	//검색
	public ArrayList<ProductDAO> Product_Search(String SF, String ST){
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM product WHERE "+SF+" LIKE ?");
			pst.setString(1, "%"+ST+"%");
			rs = pst.executeQuery();
			while (rs.next()) {
				ProductDAO productDAO = new ProductDAO();
				productDAO.setProductID(rs.getString(1));
				productDAO.setProductName(rs.getString(2));
				productDAO.setCategory(rs.getString(3));
				productDAO.setManufacturer(rs.getString(4));
				productDAO.setUnitPrice(rs.getString(5));
				productDAO.setUnitStock(rs.getString(6));
				productDAO.setDescription(rs.getString(7));
				productDAO.setSituation(rs.getString(8));
				productDAO.setSeller(rs.getString(9));
				listOfProduct.add(productDAO);
			}
			return listOfProduct;
		} catch (Exception e) {
				e.printStackTrace();
		}
		return null;
	}
	
	// 특정 등록물품 조회
	public ProductDAO Product(String productid){
		ProductDAO productDAO = new ProductDAO();
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM product WHERE productID=?");
			pst.setString(1, productid);
			rs = pst.executeQuery();
			if(rs.next()) {				
				productDAO.setProductID(rs.getString(1));
				productDAO.setProductName(rs.getString(2));
				productDAO.setCategory(rs.getString(3));
				productDAO.setManufacturer(rs.getString(4));
				productDAO.setUnitPrice(rs.getString(5));
				productDAO.setUnitStock(rs.getString(6));
				productDAO.setDescription(rs.getString(7));
				productDAO.setSituation(rs.getString(8));
				productDAO.setSeller(rs.getString(9));
				return productDAO;
			}
		} catch (Exception e) {
				e.printStackTrace();
		}
		return null;
	}
	
	// 유저의 등록물품 전체조회
	public ArrayList<ProductDAO> getproducts(String userID, ArrayList<ProductDAO> listOfProduct) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM product WHERE Seller = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			while (rs.next()) {
				ProductDAO productDAO = new ProductDAO();
				productDAO.setProductID(rs.getString(1));
				productDAO.setProductName(rs.getString(2));
				productDAO.setCategory(rs.getString(3));
				productDAO.setManufacturer(rs.getString(4));
				productDAO.setUnitPrice(rs.getString(5));
				productDAO.setUnitStock(rs.getString(6));
				productDAO.setDescription(rs.getString(7));
				productDAO.setSituation(rs.getString(8));
				productDAO.setSeller(rs.getString(9));	
				listOfProduct.add(productDAO);
			}
			return listOfProduct;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 유저의 등록물품 개수
		public int getproductNum(String userID) {
			try {
				int num=0;
				PreparedStatement pst = con.prepareStatement("SELECT * FROM product WHERE Seller = ?");
				pst.setString(1, userID);
				rs = pst.executeQuery();
				while (rs.next()) {
					num+=1;
				}
				return num;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
	
	public String getProductID() {
		return productID;
	}
	public void setProductID(String productID) {
		this.productID = productID;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;		
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getUnitStock() {
		return unitStock;
	}
	public void setUnitStock(String unitStock) {
		this.unitStock = unitStock;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSituation() {
		return situation;
	}
	public void setSituation(String situation) {
		this.situation = situation;
	}

	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	
	
}
