<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        
        <title>
        	수정
        </title>
    </head>
    
    <body>
        <%
        String UserID = request.getParameter("userID");
        String UserPassword = request.getParameter("userPassword");
        String UserName = request.getParameter("userName");
        String UserTel = request.getParameter("userTel");
        String UserEmaill = request.getParameter("userEmaill");
        String UserPosition = request.getParameter("userPosition");
        
        if(UserID.equals("") || UserPassword.equals("") || UserName.equals("")|| 
        		UserTel.equals("") || UserEmaill.equals("")|| UserPosition.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	UserDAO userDAO = new UserDAO();
        	userDAO.setUserID(UserID);
        	userDAO.setUserPassword(UserPassword);
        	userDAO.setUserName(UserName);
        	userDAO.setUserTel(UserTel);
        	userDAO.setUserEmaill(UserEmaill);
        	userDAO.setUserPosition(UserPosition);
        	
            int result = userDAO.update(userDAO);
            	
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
            	script.println("location.href = 'user_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>