<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.TraincodeDAO" %>
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
        String TraincodeID = request.getParameter("TraincodeID");
        String Code = request.getParameter("Code");
        String Day = request.getParameter("Day");
        String StartTime = request.getParameter("StartTime");
        String EndTime = request.getParameter("EndTime");
        String LineID = request.getParameter("LineID");
        
        if(TraincodeID.equals("") || Code.equals("")|| LineID.equals("")
	        	|| Day.equals("") || StartTime.equals("")|| EndTime.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	TraincodeDAO traincodeDAO = new TraincodeDAO();
        	traincodeDAO.setTraincodeID(TraincodeID);
        	traincodeDAO.setCode(Code);
        	traincodeDAO.setDay(Integer.parseInt(Day));
        	traincodeDAO.setStartTime(StartTime);
        	traincodeDAO.setEndTime(EndTime);
        	traincodeDAO.setLineID(LineID);
        	
            int result = traincodeDAO.insert(traincodeDAO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == -2) {
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
            	script.println("location.href = 'traincode_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>