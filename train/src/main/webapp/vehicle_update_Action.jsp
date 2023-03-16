<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.VehicleDAO" %>
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
        String VehicleID = request.getParameter("VehicleID");
        String Type = request.getParameter("Type");
        String Model = request.getParameter("Model");
        String Status = request.getParameter("Status");
        String TrainID = request.getParameter("TrainID");
        
        if(VehicleID.equals("") || Type.equals("")|| TrainID.equals("") || 
        		Model.equals("") || Status.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	VehicleDAO vehicleDAO = new VehicleDAO();
        	vehicleDAO.setVehicleID(VehicleID);
        	vehicleDAO.setType(Type);
        	vehicleDAO.setModel(Model);
        	vehicleDAO.setStatus(Status);
        	vehicleDAO.setTrainID(TrainID);
        	
            int result = vehicleDAO.Vehicle_Update(vehicleDAO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == -2) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 기차ID는 없습니다.')");
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
            	script.println("location.href = 'vehicle_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>