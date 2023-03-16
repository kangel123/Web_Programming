<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.OperationDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
	  	Date date = new Date();
  		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
        String OperationID = request.getParameter("OperationID");
        String TrainCodeID = request.getParameter("TrainCodeID");
        String TrainID = request.getParameter("Train_ID");
        String Status = request.getParameter("Status");
        String Updatetime = format.format(date);
        String CurrentStationNum = request.getParameter("CurrentStationNum");
        String EngineerID = request.getParameter("EngineerID");
        
        if(OperationID.equals("") || TrainCodeID.equals("")|| EngineerID.equals("") || 
        		CurrentStationNum.equals("") || TrainID.equals("") || Status.equals("")|| Updatetime.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	OperationDAO operationDAO = new OperationDAO();
        	operationDAO.setOperationID(OperationID);
        	operationDAO.setTrainCodeID(TrainCodeID);
        	operationDAO.setTrainID(TrainID);
        	operationDAO.setStatus(Status);
        	operationDAO.setUpdatetime(Updatetime);
        	operationDAO.setCurrentStationNum(Integer.parseInt(CurrentStationNum));
        	operationDAO.setEngineerID(EngineerID);
        	
            int result = operationDAO.Operation_Update(operationDAO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else if(result == -2) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 열차코드ID는 없습니다.')");
            	script.println("history.back()");
            	script.println("</script>");
            }else if(result == -3) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 열차ID는 없습니다.')");
            	script.println("history.back()");
            	script.println("</script>");
            }else if(result == -4) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 기관사ID는 없습니다.')");
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
            	script.println("location.href = 'operation_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>