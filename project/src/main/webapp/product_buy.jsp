<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="productDAO" class="product.ProductDAO" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(session.getAttribute("userID")== null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후에 사용 가능합니다'); history.go(-1);");
		script.println("</script>");	
	} else{%>
	
	<% String id = request.getParameter("id");
		productDAO=productDAO.Product(id);
		 productDAO.setUnitStock(Integer.toString(Integer.parseInt(productDAO.getUnitStock())-1));
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
         	script.println("alert('이미 아이디가 존재하지 않습니다.')");
         	script.println("history.back()");
         	script.println("</script>");
         } else {
         	PrintWriter script = response.getWriter();
         	script.println("<script>");
         	script.println("alert('구매완료')");
         	if( Integer.parseInt(productDAO.getUnitStock())<=0){
         		script.println("location.href = 'products.jsp'");
         	}
         	else{
         		script.println("history.back()");
         	}
         	script.println("</script>");
         	
         }
	}%>
</body>
</html>