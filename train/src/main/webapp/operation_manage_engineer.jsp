<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.LineDAO" %>
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
	LineDAO lineDAO = new LineDAO();
	ArrayList<LineDAO> listOfLine= new ArrayList<LineDAO>();
	if(SearchField==null){
		listOfLine = lineDAO.Line_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfLine=lineDAO.line_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="line_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Line_ID">라인ID</option>
								<option value="Name">이름</option>
								<option value="Capacity">역량</option>
								<option value="Start_station">시작점</option>
								<option value="Finish_station">도착점</option>
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
			<h3>라인 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./line_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>라인ID</th>
				<th>이름</th>
				<th>역량</th>
				<th>시작점</th>
				<th>도착점</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfLine.size();i++){%>
			<tr>
				<td><%=listOfLine.get(i).getLineID()%></td>
				<td><%=listOfLine.get(i).getName()%></td>
				<td><%=listOfLine.get(i).getCapacity()%></td>
				<td><%=listOfLine.get(i).getStart_station()%></td>
				<td><%=listOfLine.get(i).getFinish_station()%></td>
				<td><a href="./line_update.jsp?id=<%=listOfLine.get(i).getLineID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./line_delete.jsp?id=<%=listOfLine.get(i).getLineID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
