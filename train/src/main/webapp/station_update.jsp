<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.StationDAO" %>
<jsp:useBean id="stationDAO" class="dto.StationDAO" scope="session" />

<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html lang="ko">

<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>
    	역수정
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />
	<%
		String id = request.getParameter("id");
		StationDAO station = stationDAO.station(id);
	%>
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">역정보 수정</h1>
		</div>
	</div>
	
        <form method="post" action="./station_update_Action.jsp">
    <div class="container">
    <div class="form-group row">
			<h3>역수정</h3>
			<div class="col-sm-offset-2 col-sm-10 ">
	            <input type="submit" class="bt_join" value="완료">
	            <input type="button" class="bt_join" onclick="location.href='station_manage.jsp'" value="취소"/>
    	   		</div>
    	   		</div>
            <table class="table">
			<tr>
				<th>역ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>책임자</th>
				<th>예산</th>
				<th>본부ID</th>
			</tr>
			<tr>
				<td><input type="text" class="input" value="<%=station.getStationID()%>" name=StationID class="form-control" readonly/></td>
				<td><input type="text" class="input" value="<%=station.getName()%>" name=Name class="form-control"/></td>
				<td><input type="text" class="input" value="<%=station.getTel()%>" name=Tel class="form-control"/></td>
				<td><input type="text" class="input" value="<%=station.getAddress()%>" name=Address class="form-control"/></td>
				<td><input type="text" class="input" value="<%=station.getManagerName()%>" name=ManagerName class="form-control"/></td>
				<td><input type="text" class="input" value="<%=station.getBudget()%>" name=Budget class="form-control"/></td>
				<td><input type="text" class="input" value="<%=station.getHeadquarterID()%>" name=HeadquarterID class="form-control"/></td>
			</tr>						
       		</table>
   </div>
	</form>   

 <jsp:include page="footer.jsp" />
</body>

</html>
