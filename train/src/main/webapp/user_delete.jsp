<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<jsp:useBean id="userDAO" class="user.UserDAO" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		UserDAO user = userDAO.getUser(id);
		int result = user.User_Delete(user);
		 if(result == -1) {
         	PrintWriter script = response.getWriter();
         	script.println("<script>");
         	script.println("alert('서버오류')");
         	script.println("history.back()");
         	script.println("</script>");
         }  else if(result == -2) {
        	PrintWriter script = response.getWriter();
          	script.println("<script>");
          	script.println("alert('해당 유저ID를 참고로하는 기관사ID가 존재합니다')");
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
         	script.println("location.href = 'user_manage.jsp'");
         	script.println("</script>");
         }
	%>
</body>
</html>