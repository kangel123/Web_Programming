<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>

<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>메인화면</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<img src="yonrail.png" width=100%>
	
	<jsp:include page="footer.jsp" />
</body>
</html>
