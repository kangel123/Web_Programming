<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.StationDAO" %>
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
        String StationID = request.getParameter("StationID");
        String Name = request.getParameter("Name");
        String Tel = request.getParameter("Tel");
        String Address = request.getParameter("Address");
        String ManagerName = request.getParameter("ManagerName");
        String Budget = request.getParameter("Budget");
        String HeadquarterID = request.getParameter("HeadquarterID");
        
        if(StationID.equals("") || Name.equals("")|| HeadquarterID.equals("") || 
        		Budget.equals("") || Tel.equals("") || Address.equals("")|| ManagerName.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	StationDAO stationDAO = new StationDAO();
        	stationDAO.setStationID(StationID);
        	stationDAO.setName(Name);
        	stationDAO.setTel(Tel);
        	stationDAO.setAddress(Address);
        	stationDAO.setManagerName(ManagerName);
        	stationDAO.setBudget(Integer.parseInt(Budget));
        	stationDAO.setHeadquarterID(HeadquarterID);
        	
            int result = stationDAO.Station_Update(stationDAO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == -2) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 본부ID는 없습니다.')");
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
            	script.println("alert('입력 완료.')");
            	script.println("location.href = 'station_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>