<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.StationDAO" %>
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
	StationDAO stationDAO = new StationDAO();
	ArrayList<StationDAO> listOfStation= new ArrayList<StationDAO>();
	if(SearchField==null){
		listOfStation = stationDAO.Station_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfStation=stationDAO.station_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="station_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Station_ID">역ID</option>
								<option value="Name">이름</option>
								<option value="Address">주소</option>
								<option value="Tel">전화번호</option>
								<option value="ManagerName">책임자</option>
								<option value="Headquarter_ID">본부ID</option>
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
			<h3>역 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./station_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>역ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>책임자</th>
				<th>예산</th>
				<th>본부ID</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfStation.size();i++){%>
			<tr>
				<td><%=listOfStation.get(i).getStationID()%></td>
				<td><%=listOfStation.get(i).getName()%></td>
				<td><%=listOfStation.get(i).getTel()%></td>
				<td><%=listOfStation.get(i).getAddress()%></td>
				<td><%=listOfStation.get(i).getManagerName()%></td>
				<td><%=listOfStation.get(i).getBudget()%></td>
				<td><%=listOfStation.get(i).getHeadquarterID()%></td>
				<td><a href="./station_update.jsp?id=<%=listOfStation.get(i).getStationID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./station_delete.jsp?id=<%=listOfStation.get(i).getStationID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
