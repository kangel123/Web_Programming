<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.ConnectDAO" %>
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
	ConnectDAO connectDAO = new ConnectDAO();
	ArrayList<ConnectDAO> listOfConnect= new ArrayList<ConnectDAO>();
	if(SearchField==null){
		listOfConnect = connectDAO.Connect_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfConnect=connectDAO.connect_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="connect_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Connect_ID">연결노선ID</option>
								<option value="Station_ID">역ID</option>
								<option value="Line_ID">라인ID</option>
								<option value="StationNum">순서</option>
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
			<h3>연결노선 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./connect_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>연결노선ID</th>
				<th>역ID</th>
				<th>라인ID</th>
				<th>순서</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfConnect.size();i++){%>
			<tr>
				<td><%=listOfConnect.get(i).getConnectID()%></td>
				<td><%=listOfConnect.get(i).getStationID()%></td>
				<td><%=listOfConnect.get(i).getLineID()%></td>
				<td><%=listOfConnect.get(i).getStationNum()%></td>
				<td><a href="./connect_update.jsp?id=<%=listOfConnect.get(i).getConnectID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./connect_delete.jsp?id=<%=listOfConnect.get(i).getConnectID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
