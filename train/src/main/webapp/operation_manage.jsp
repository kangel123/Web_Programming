<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.OperationDAO" %>
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
	OperationDAO operationDAO = new OperationDAO();
	ArrayList<OperationDAO> listOfOperation= new ArrayList<OperationDAO>();
	if(SearchField==null){
		listOfOperation = operationDAO.Operation_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfOperation=operationDAO.operation_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="operation_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Operation_ID">운행ID</option>
								<option value="TrainCode_ID">열차코드ID</option>
								<option value="Train_ID">열차ID</option>
								<option value="Status">상태</option>
								<option value="Updatetime">업데이트 시간</option>
								<option value="Updatetime">현재역 순서</option>
								<option value="Engineer_ID">기관사ID</option>
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
			<h3>운행 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./operation_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>운행ID</th>
				<th>열차코드ID</th>
				<th>열차ID</th>
				<th>상태</th>
				<th>업데이트 시간</th>
				<th>현재역순서</th>
				<th>기관사ID</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfOperation.size();i++){%>
			<tr>
				<td><%=listOfOperation.get(i).getOperationID()%></td>
				<td><%=listOfOperation.get(i).getTrainCodeID()%></td>
				<td><%=listOfOperation.get(i).getTrainID()%></td>
				<td><%=listOfOperation.get(i).getStatus()%></td>
				<td><%=listOfOperation.get(i).getUpdatetime()%></td>
				<td><%=listOfOperation.get(i).getCurrentStationNum()%></td>
				<td><%=listOfOperation.get(i).getEngineerID()%></td>
				<td><a href="./operation_update.jsp?id=<%=listOfOperation.get(i).getOperationID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./operation_delete.jsp?id=<%=listOfOperation.get(i).getOperationID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
