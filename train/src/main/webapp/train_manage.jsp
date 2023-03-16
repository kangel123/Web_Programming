<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.TrainDAO" %>
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
	TrainDAO trainDAO = new TrainDAO();
	ArrayList<TrainDAO> listOfTrain= new ArrayList<TrainDAO>();
	if(SearchField==null){
		listOfTrain = trainDAO.Train_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfTrain=trainDAO.train_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="train_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Train_ID">열차ID</option>
								<option value="Type">타입</option>
								<option value="Conditon">상태</option>
								<option value="ProductionYear">생산년도</option>
								<option value="Speed">스피드</option>
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
			<h3>열차 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./train_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>열차ID</th>
				<th>타입</th>
				<th>상태</th>
				<th>생산년도</th>
				<th>스피드</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfTrain.size();i++){%>
			<tr>
				<td><%=listOfTrain.get(i).getTrainID()%></td>
				<td><%=listOfTrain.get(i).getType()%></td>
				<td><%=listOfTrain.get(i).getCondition()%></td>
				<td><%=listOfTrain.get(i).getProductionYear()%></td>
				<td><%=listOfTrain.get(i).getSpeed()%></td>
				<td><a href="./train_update.jsp?id=<%=listOfTrain.get(i).getTrainID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./train_delete.jsp?id=<%=listOfTrain.get(i).getTrainID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
