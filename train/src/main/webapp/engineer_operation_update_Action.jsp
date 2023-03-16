<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.OperationDAO" %>
<%@ page import="dto.EngineerDAO" %>
<%@ page import="user.UserDAO" %>
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
     	String id = request.getParameter("id");
	    OperationDAO operation = operationDAO.operation(id);
 		Date date = new Date();
  		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
        
  		String TrainCodeID = request.getParameter("TrainCodeID");
        String TrainID = request.getParameter("Train_ID");
        String Status = request.getParameter("Status");
        String Updatetime = format.format(date);
        
        if(TrainCodeID.equals("")|| TrainID.equals("") || 
        		Status.equals("")|| Updatetime.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	operation.setTrainCodeID(TrainCodeID);
        	operation.setTrainID(TrainID);
        	operation.setStatus(Status);
        	operation.setUpdatetime(Updatetime);
        	
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
            	script.println("location.href = 'engineer_operation_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>