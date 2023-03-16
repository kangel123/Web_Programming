<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.EngineerDAO" %>
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
	EngineerDAO engineerDAO = new EngineerDAO();
	ArrayList<EngineerDAO> listOfEngineer= new ArrayList<EngineerDAO>();
	if(SearchField==null){
		listOfEngineer = engineerDAO.Engineer_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfEngineer=engineerDAO.engineer_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="engineer_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="Engineer_ID">기관사ID</option>
								<option value="Name">이름</option>
								<option value="MajorCareer">경력기간</option>
								<option value="CareerPeriod">주요경력</option>
								<option value="Tel">전화번호</option>
								<option value="Headquarter_ID">본부ID</option>
								<option value="User_ID">유저ID</option>
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
			<h3>기관사 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./engineer_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>기관사ID</th>
				<th>이름</th>
				<th>경력기간</th>
				<th>주요경력</th>
				<th>전화번호</th>
				<th>연금</th>
				<th>본부ID</th>
				<th>유저ID</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfEngineer.size();i++){%>
			<tr>
				<td><%=listOfEngineer.get(i).getEngineerID()%></td>
				<td><%=listOfEngineer.get(i).getName()%></td>
				<td><%=listOfEngineer.get(i).getCareerPeriod()%></td>
				<td><%=listOfEngineer.get(i).getMajorCareer()%></td>
				<td><%=listOfEngineer.get(i).getTel()%></td>
				<td><%=listOfEngineer.get(i).getSalary()%></td>
				<td><%=listOfEngineer.get(i).getHeadquarterID()%></td>
				<td><%=listOfEngineer.get(i).getUserID()%></td>
				<td><a href="./engineer_update.jsp?id=<%=listOfEngineer.get(i).getEngineerID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./engineer_delete.jsp?id=<%=listOfEngineer.get(i).getEngineerID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>	

 <jsp:include page="footer.jsp" />
</body>

</html>
