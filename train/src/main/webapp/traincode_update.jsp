<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.TraincodeDAO" %>
<jsp:useBean id="traincodeDAO" class="dto.TraincodeDAO" scope="session" />

<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html lang="ko">

<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>
    	열차코드수정
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />
	<%
		String id = request.getParameter("id");
		TraincodeDAO traincode = traincodeDAO.traincode(id);
	%>
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">열차코드정보 수정</h1>
		</div>
	</div>
	
        <form method="post" action="./traincode_update_Action.jsp">
    <div class="container">
    <div class="form-group row">
			<h3>열차코드수정</h3>
			<div class="col-sm-offset-2 col-sm-10 ">
	            <input type="submit" class="bt_join" value="완료">
	            <input type="button" class="bt_join" onclick="location.href='traincode_manage.jsp'" value="취소"/>
    	   		</div>
    	   		</div>
            <table class="table">
			<tr>
				<th>열차코드ID</th>
				<th>코드</th>
				<th>날짜</th>
				<th>출발예정시간</th>
				<th>도착예정시간</th>
				<th>라인ID</th>
			</tr>
			<tr>
				<td><input type="text" class="input" value="<%=traincode.getTraincodeID()%>" name=TraincodeID class="form-control" readonly/></td>
				<td><input type="text" class="input" value="<%=traincode.getCode()%>" name=Code class="form-control"/></td>
				<td><input type="text" class="input" value="<%=traincode.getDay()%>" name=Day class="form-control"/></td>
				<td><input type="text" class="input" value="<%=traincode.getStartTime()%>" name=StartTime class="form-control"/></td>
				<td><input type="text" class="input" value="<%=traincode.getEndTime()%>" name=EndTime class="form-control"/></td>
				<td><input type="text" class="input" value="<%=traincode.getLineID()%>" name=LineID class="form-control"/></td>
			</tr>						
       		</table>
   </div>
	</form>   

 <jsp:include page="footer.jsp" />
</body>

</html>
