<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        
        <title>
        	마이페이지
        </title>
    </head>
    
    <body>
        <%
        String userID = request.getParameter("userID");
        String userPassword = request.getParameter("userPassword");
        String userName = request.getParameter("userName");
        String userTel = request.getParameter("userTel");
        String userEmaill = request.getParameter("userEmaill");
        String userPosition = "일반사용자";
        
     	// -1: 서버 오류 / 0: 이미존재하는 아이디 / 1: 성공
        if(userID.equals("") || userPassword.equals("") || userName.equals("")
        || userTel.equals("") || userEmaill.equals("")) {
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	UserDAO userDAO = new UserDAO();
        	
        	userDAO.setUserID(userID);
        	userDAO.setUserPassword(userPassword);
        	userDAO.setUserName(userName);
        	userDAO.setUserTel(userTel);
        	userDAO.setUserEmaill(userEmaill);
        	userDAO.setUserPosition(userPosition);
        	
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
            	script.println("location.href = 'mypage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>