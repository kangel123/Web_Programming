<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.EngineerDAO" %>
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
        String EngineerID = request.getParameter("EngineerID");
        String Name = request.getParameter("Name");
        String CareerPeriod = request.getParameter("CareerPeriod");
        String MajorCareer = request.getParameter("MajorCareer");
        String Tel = request.getParameter("Tel");
        String Salary = request.getParameter("Salary");
        String HeadquarterID = request.getParameter("HeadquarterID");
        String UserID = request.getParameter("UserID");
        
        if(EngineerID.equals("") || Name.equals("")|| HeadquarterID.equals("") || 
        		Salary.equals("") || CareerPeriod.equals("") || Tel.equals("") || UserID.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	EngineerDAO engineerDAO = new EngineerDAO();
        	engineerDAO.setEngineerID(EngineerID);
        	engineerDAO.setName(Name);
        	engineerDAO.setCareerPeriod(Integer.parseInt(CareerPeriod));
        	engineerDAO.setMajorCareer(MajorCareer);
        	engineerDAO.setTel(Tel);
        	engineerDAO.setSalary(Integer.parseInt(Salary));
        	engineerDAO.setHeadquarterID(HeadquarterID);
        	engineerDAO.setUserID(UserID);
        	
            int result = engineerDAO.insert(engineerDAO);
            	
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
            	
            }else if(result == -3) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('해당 유저ID는 없습니다.')");
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
            	script.println("location.href = 'engineer_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>