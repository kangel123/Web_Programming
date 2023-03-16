<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.ConnectDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="connectDAO" class="dto.ConnectDAO" scope="session" />
    
<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		ConnectDAO connect = connectDAO.connect(id);
		int result = connect.Connect_Delete(connect);
		if(result == -1) {
         	PrintWriter script = response.getWriter();
         	script.println("<script>");
         	script.println("alert('서버오류')");
         	script.println("history.back()");
         	script.println("</script>");
          }else if(result == 0) {
         	PrintWriter script = response.getWriter();
         	script.println("<script>");
         	script.println("alert('아이디가 존재하지 않습니다.')");
         	script.println("history.back()");
         	script.println("</script>");
         } else {
         	PrintWriter script = response.getWriter();
         	script.println("<script>");
         	script.println("alert('삭제 완료.')");
         	script.println("location.href = 'connect_manage.jsp'");
         	script.println("</script>");
         }
	%>
</body>
</html>