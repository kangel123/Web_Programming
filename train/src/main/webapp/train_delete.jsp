<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.TrainDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="trainDAO" class="dto.TrainDAO" scope="session" />
    
<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		TrainDAO train = trainDAO.train(id);
		int result = train.Train_Delete(train);
		if(result == -1) {
         	PrintWriter script = response.getWriter();
         	script.println("<script>");
         	script.println("alert('서버오류')");
         	script.println("history.back()");
         	script.println("</script>");
          } else if(result == -2) {
          	PrintWriter script = response.getWriter();
          	script.println("<script>");
          	script.println("alert('해당 열차ID를 참고로하는 운행ID가 존재합니다')");
          	script.println("history.back()");
          	script.println("</script>");
     	}  else if(result == -3) {
        	PrintWriter script = response.getWriter();
          	script.println("<script>");
          	script.println("alert('해당 열차ID를 참고로하는 차량ID가 존재합니다')");
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
         	script.println("alert('삭제 완료.')");
         	script.println("location.href = 'train_manage.jsp'");
         	script.println("</script>");
         }
	%>
</body>
</html>