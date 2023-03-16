<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.LineDAO" %>
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
        String LineID = request.getParameter("LineID");
        String Name = request.getParameter("Name");
        String Capacity = request.getParameter("Capacity");
        String Start_station = request.getParameter("Start_station");
        String Finish_station = request.getParameter("Finish_station");
        
        if(LineID.equals("") || Name.equals("")|| 
        		Capacity.equals("") || Start_station.equals("")|| Finish_station.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	LineDAO lineDAO = new LineDAO();
        	lineDAO.setLineID(LineID);
        	lineDAO.setName(Name);
        	lineDAO.setCapacity(Integer.parseInt(Capacity));
        	lineDAO.setStart_station(Start_station);
        	lineDAO.setFinish_station(Finish_station);
        	
            int result = lineDAO.Line_Update(lineDAO);
            	
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
            	script.println("location.href = 'line_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>