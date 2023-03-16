<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.HeadquarterDAO" %>
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
        String HeadquarterID = request.getParameter("HeadquarterID");
        String Planet = request.getParameter("Planet");
        String Name = request.getParameter("Name");
        String Tel = request.getParameter("Tel");
        String Address = request.getParameter("Address");
        String ManagerName = request.getParameter("ManagerName");
        
        if(HeadquarterID.equals("") || Planet.equals("") || Name.equals("")|| 
        		Tel.equals("") || Address.equals("")|| ManagerName.equals("")){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else {
        	HeadquarterDAO headquarterDAO = new HeadquarterDAO();
        	headquarterDAO.setHeadquarterID(HeadquarterID);
        	headquarterDAO.setPlanet(Planet);
        	headquarterDAO.setName(Name);
        	headquarterDAO.setTel(Tel);
        	headquarterDAO.setAddress(Address);
        	headquarterDAO.setManagerName(ManagerName);
        	
            int result = headquarterDAO.insert(headquarterDAO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
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
            	script.println("location.href = 'headquarter_manage.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>