<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="product.ProductDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="productDAO" class="product.ProductDAO" scope="session" />
    
<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html>
<head>
<meta charset="UTF-8">
<title>상품삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		ProductDAO product = productDAO.Product(id);
		int result = product.Product_Delete(product);
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
         	script.println("alert('삭제 완료.')");
         	script.println("location.href = 'product_manage.jsp'");
         	script.println("</script>");
         }
	%>
</body>
</html>