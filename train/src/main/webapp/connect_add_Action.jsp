<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.ConnectDAO" %>
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
        String ConnectID = request.getParameter("ConnectID");
     	String StationID = request.getParameter("StationID");
     	String LineID = request.getParameter("LineID");
        String StationNum = request.getParameter("StationNum");
        
        if(ConnectID.equals("") || StationID.equals("") || 
        		StationNum.equals("") || LineID.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	ConnectDAO connectDAO = new ConnectDAO();
        	connectDAO.setConnectID(ConnectID);
        	connectDAO.setStationID(StationID);
        	connectDAO.setLineID(LineID);
        	connectDAO.setStationNum(Integer.parseInt(StationNum));
        	
            int result = connectDAO.insert(connectDAO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == -2) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 역ID는 없습니다.')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == -3) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 라인ID는 없습니다.')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == 0) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('아이디가 이미 존재합니다.')");
            	script.println("history.back()");
            	script.println("</script>");
            } else {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('입력 완료.')");
            	script.println("location.href = 'connect_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>