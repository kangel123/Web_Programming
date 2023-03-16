<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.OperationDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="operationDAO" class="dto.OperationDAO" scope="session" />
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
			String id = request.getParameter("id");
			OperationDAO operation = operationDAO.operation(id);
			operation.setCurrentStationNum(operation.getCurrentStationNum()+1);
			operation.setUpdatetime(format.format(date));
			String station = operation.engineer_operation_station(operation.getCurrentStationNum(), operation.getEngineerID(), operation.getOperationID());
        	if(station.equals("-")){
        		operation.setStatus("운행 종료");
        	}else{
        		operation.setStatus("운행 중");
        	}
			int result = operation.Operation_Update(operation);
            	
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
            }else if(result == 0) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('아이디가 존재하지 않습니다.')");
            	script.println("history.back()");
            	script.println("</script>");
            } else {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('변경 완료.')");
            	script.println("location.href = 'engineer_operation_manage.jsp'");
            	script.println("</script>");
            }
        %>
    </body>
    
</html>