<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.TrainDAO" %>
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
        String TrainID = request.getParameter("TrainID");
        String Type = request.getParameter("Type");
        String Condition = request.getParameter("Condition");
        String ProductionYear = request.getParameter("ProductionYear");
        String Speed = request.getParameter("Speed");
        
        if(TrainID.equals("") || Type.equals("")||Condition.equals("") 
        		|| ProductionYear.equals("") || Speed.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	TrainDAO trainDAO = new TrainDAO();
        	trainDAO.setTrainID(TrainID);
        	trainDAO.setType(Type);
        	trainDAO.setCondition(Condition);
        	trainDAO.setProductionYear(Integer.parseInt(ProductionYear));
        	trainDAO.setSpeed(Float.parseFloat(Speed));
        	
            int result = trainDAO.Train_Update(trainDAO);
            	
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
            	script.println("alert('입력 완료.')");
            	script.println("location.href = 'train_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>