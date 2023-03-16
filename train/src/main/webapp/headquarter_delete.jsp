<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.HeadquarterDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="headquarterDAO" class="dto.HeadquarterDAO" scope="session" />
    
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
		HeadquarterDAO headquarter = headquarterDAO.headquarter(id);
		int result = headquarter.Headquarter_Delete(headquarter);
		if(result == -1) {
         	PrintWriter script = response.getWriter();
         	script.println("<script>");
         	script.println("alert('서버오류')");
         	script.println("history.back()");
         	script.println("</script>");
         } else if(result == -2) {
           	PrintWriter script = response.getWriter();
           	script.println("<script>");
           	script.println("alert('해당 본부ID를 참고로하는 역ID가 존재합니다')");
           	script.println("history.back()");
           	script.println("</script>");
         }else if(result == -3) {
           	PrintWriter script = response.getWriter();
           	script.println("<script>");
           	script.println("alert('해당 본부ID를 참고로하는 기관사ID가 존재합니다')");
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
         	script.println("location.href = 'headquarter_manage.jsp'");
         	script.println("</script>");
         }
	%>
</body>
</html>