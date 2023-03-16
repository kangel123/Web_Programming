<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
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
	UserDAO userDAO = new UserDAO();
	ArrayList<UserDAO> listOfUser= new ArrayList<UserDAO>();
	if(SearchField==null){
		listOfUser = userDAO.User_Lookup();
	}else{
		String SearchText = request.getParameter("searchText");
		listOfUser=userDAO.user_Search(SearchField, SearchText);
	}
	%>
	
	<div class="container">
		<div style="float: right;">
			<form method="post" name="search" action="user_manage.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="userID">유저ID</option>
								<option value="userPassword">비밀번호</option>
								<option value="userName">이름</option>
								<option value="userTel">전화번호</option>
								<option value="userEmaill">이메일</option>
								<option value="userPosition">직위</option>
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
			<h3>유저 관리</h3>
			</div>
            <div style="float: left;">
			<a href="./user_add.jsp" class="btn btn-secondary"> 추가</a>
			</div>
			<tr>
				<th>유저ID</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>직위</th>
				<th></th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfUser.size();i++){%>
			<tr>
				<td><%=listOfUser.get(i).getUserID()%></td>
				<td><%=listOfUser.get(i).getUserPassword()%></td>
				<td><%=listOfUser.get(i).getUserName()%></td>
				<td><%=listOfUser.get(i).getUserTel()%></td>
				<td><%=listOfUser.get(i).getUserEmaill()%></td>
				<td><%=listOfUser.get(i).getUserPosition()%></td>
				<td><a href="./user_update.jsp?id=<%=listOfUser.get(i).getUserID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./user_delete.jsp?id=<%=listOfUser.get(i).getUserID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>
 <jsp:include page="footer.jsp" />
       		
</body>
</html>