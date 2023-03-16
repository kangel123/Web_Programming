<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand  navbar-dark bg-dark">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="./main.jsp">Home</a>
			<a class="navbar-brand" href="./products.jsp">상품검색</a>
			<a class="navbar-brand" href="./product_registration.jsp">상품등록</a>
			<%
			String userposition =(String)session.getAttribute("userPosition");
			if(userposition != null && userposition.equals("관리자")){%>
			<a class="navbar-brand" href="./product_manage.jsp">상품관리</a>	
			
			<%} %>
		</div>
			<%if(session.getAttribute("userID")== null){%>
		<div>
			<button type="button" class="btn btn-primary" onclick="location.href='join.jsp' ">회원가입</button>
			<button type="button" class="btn btn-primary" onclick="location.href='login.jsp' ">로그인</button>
		</div>
        <%} else{ %> 
	 	<div>
	 		<button type="button" class="btn btn-primary" onclick="location.href='./mypage.jsp' ">마이페이지</button>
	 		<button type="button" class="btn btn-primary" onclick="location.href='logoutCheck.jsp' ">로그아웃</button>
		</div>
 		<%}; %>
	</div>
	
</nav>

