<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.VehicleDAO" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>
        데이터관리
    </title>
</head>
	
<body>

<jsp:include page="menu.jsp" />
	
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">데이터관리</h1>
		</div>
	</div>
	<%
	String SearchField=request.getParameter("searchField");
	VehicleDAO vehicleDAO = new VehicleDAO();
	ArrayList<VehicleDAO> listOfVehicle= new ArrayList<VehicleDAO>();
	if(SearchField==null){
		listOfVehicle = vehicleDAO.Vehicle_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfVehicle=vehicleDAO.vehicle_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="vehicle_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Vehicle_ID">차량ID</option>
								<option value="Type">타입</option>
								<option value="Model">모델</option>
								<option value="Status">상태</option>
								<option value="Train_ID">본부ID</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-primary">검색</button></td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	
    <div class="container">
            <table class="table">
            <div style="float: left; padding-right:10px;">
			<h3>차량 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./vehicle_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>차량ID</th>
				<th>타입</th>
				<th>모델</th>
				<th>상태</th>
				<th>기차ID</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfVehicle.size();i++){%>
			<tr>
				<td><%=listOfVehicle.get(i).getVehicleID()%></td>
				<td><%=listOfVehicle.get(i).getType()%></td>
				<td><%=listOfVehicle.get(i).getModel()%></td>
				<td><%=listOfVehicle.get(i).getStatus()%></td>
				<td><%=listOfVehicle.get(i).getTrainID()%></td>
				<td><a href="./vehicle_update.jsp?id=<%=listOfVehicle.get(i).getVehicleID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./vehicle_delete.jsp?id=<%=listOfVehicle.get(i).getVehicleID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
