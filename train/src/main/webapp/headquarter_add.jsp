<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.HeadquarterDAO" %>

<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html lang="ko">

<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>
    	본부추가
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />

    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">본부정보 추가</h1>
		</div>
	</div>
	
        <form method="post" action="headquarter_add_Action.jsp">
    <div class="container">
    <div class="form-group row">
			<h3>본부추가</h3>
			<div class="col-sm-offset-2 col-sm-10 ">
	            <input type="submit" class="bt_join" value="완료">
	            <input type="button" class="bt_join" onclick="location.href='headquarter_manage.jsp'" value="취소"/>
    	   		</div>
    	   		</div>
            <table class="table">
			<tr>
				<th>본부ID</th>
				<th>행성</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>책임자</th>
			</tr>
			<tr>
				<td><input type="text" class="input" name=HeadquarterID class="form-control" /></td>
				<td><input type="text" class="input" name=Planet class="form-control"/></td>
				<td><input type="text" class="input" name=Name class="form-control"/></td>
				<td><input type="text" class="input" name=Tel class="form-control"/></td>
				<td><input type="text" class="input" name=Address class="form-control"/></td>
				<td><input type="text" class="input" name=ManagerName class="form-control"/></td>
			</tr>						
       		</table>
   </div>
	</form>   

 <jsp:include page="footer.jsp" />
</body>

</html>
