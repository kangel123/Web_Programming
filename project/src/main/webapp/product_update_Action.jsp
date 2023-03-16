<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        
        <title>
        	상품수정
        </title>
    </head>
    
    <body>
        <%
        String ProductID = request.getParameter("ProductID");
        String ProductName = request.getParameter("ProductName");
        String Category = request.getParameter("Category");
        String Manufacturer = request.getParameter("Manufacturer");
        String UnitPrice = request.getParameter("UnitPrice");
        String UnitStock = request.getParameter("UnitStock");
        String Description = request.getParameter("Description");
        String Situation = request.getParameter("Situation");
        String Seller = request.getParameter("Seller");
        
        
        if(ProductID.equals("") || ProductName.equals("") || Category.equals("")|| 
        		UnitStock.equals("") || UnitPrice.equals("") ||
        		Description.equals("")||Situation.equals("")||Seller.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	ProductDAO productDAO = new ProductDAO();
        	productDAO.setProductID(ProductID);
        	productDAO.setProductName(ProductName);
        	productDAO.setCategory(Category);
        	productDAO.setManufacturer(Manufacturer);
        	productDAO.setUnitPrice(UnitPrice);
        	productDAO.setUnitStock(UnitStock);
        	productDAO.setDescription(Description);
        	productDAO.setSituation(Situation);
        	productDAO.setSeller(Seller);
        	
            int result = productDAO.Product_Update(productDAO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == 0) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('아이디가 존재하지 않습니다.')");
            	script.println("history.back()");
            	script.println("</script>");
            } else {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('수정 완료.')");
            	script.println("location.href = 'product_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>