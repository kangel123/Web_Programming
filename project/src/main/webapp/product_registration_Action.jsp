<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        
        <title>
        	데이터 입력
        </title>
    </head>
    
    <body>
        <%
        String ProductID=null;
        String ProductName = request.getParameter("pname");
        String Category= request.getParameter("category");
        String Manufacturer	= request.getParameter("manufacturer");
        String UnitPrice= request.getParameter("unitPrice");
    	String UnitStock = request.getParameter("unitStock");
        String Description = request.getParameter("description");
        String Situation = "확인중";
     	String Seller = (String)session.getAttribute("userID");
     	
     	if(ProductName.equals("") || Category.equals("")|| UnitStock.equals("") || Description.equals("")){
     	       	PrintWriter script = response.getWriter();
     	        script.println("<script>");
     	       	script.println("alert('빈칸을 확인해 주세요')");
     	       	script.println("history.back()");
     	       	script.println("</script>");
     	       	} else {
				UserDAO userDAO = new UserDAO();
				user=userDAO.getUser(Seller);
								
	        	ProductDAO productDAO = new ProductDAO();
     	        int num=productDAO.getproductNum(Seller)+1;
     	   		if(num>0){		
     	       		ProductID = user.getUserName().substring(0)+ Seller.substring(0,3)+String.valueOf(num);
     	   		}
        	productDAO.setProductID(ProductID);
        	productDAO.setProductName(ProductName);
        	productDAO.setCategory(Category);
        	productDAO.setManufacturer(Manufacturer);
        	productDAO.setUnitPrice(UnitPrice);
        	productDAO.setUnitStock(UnitStock);
        	productDAO.setDescription(Description);
        	productDAO.setSituation(Situation);
        	productDAO.setSeller(Seller);
        	
        	 int result = productDAO.registration(productDAO);
         	
             if(result == -1) {
             	PrintWriter script = response.getWriter();
             	script.println("<script>");
             	script.println("alert('서버오류')");
             	script.println("history.back()");
             	script.println("</script>");
             } else if(result == 0) {
             	PrintWriter script = response.getWriter();
             	script.println("<script>");
             	script.println("alert('이미 아이디가 존재합니다.')");
             	script.println("history.back()");
             	script.println("</script>");
             } else {
             	PrintWriter script = response.getWriter();
             	script.println("<script>");
             	script.println("alert('입력완료')");
             	script.println("location.href = 'product_registration.jsp'");
             	script.println("</script>");
             }
         }
        %>
    </body>
    
</html>