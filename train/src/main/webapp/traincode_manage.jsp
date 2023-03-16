<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.TraincodeDAO" %>
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
	TraincodeDAO traincodeDAO = new TraincodeDAO();
	ArrayList<TraincodeDAO> listOfTraincode= new ArrayList<TraincodeDAO>();
	if(SearchField==null){
		listOfTraincode = traincodeDAO.Traincode_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfTraincode=traincodeDAO.traincode_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="traincode_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Traincode_ID">열차코드ID</option>
								<option value="Code">코드</option>
								<option value="Day">날짜</option>
								<option value="StartStation">출발예정시간</option>
								<option value="EndTime">도착예정시간</option>
								<option value="Line_ID">라인ID</option>
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
			<h3>열차코드 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./traincode_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>열차코드ID</th>
				<th>코드</th>
				<th>날짜</th>
				<th>출발예정시간</th>
				<th>도착예정시간</th>
				<th>라인ID</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfTraincode.size();i++){%>
			<tr>
				<td><%=listOfTraincode.get(i).getTraincodeID()%></td>
				<td><%=listOfTraincode.get(i).getCode()%></td>
				<td><%=listOfTraincode.get(i).getDay()%></td>
				<td><%=listOfTraincode.get(i).getStartTime()%></td>
				<td><%=listOfTraincode.get(i).getEndTime()%></td>
				<td><%=listOfTraincode.get(i).getLineID()%></td>
				<td><a href="./traincode_update.jsp?id=<%=listOfTraincode.get(i).getTraincodeID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./traincode_delete.jsp?id=<%=listOfTraincode.get(i).getTraincodeID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
