<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.EngineerDAO" %>

<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html lang="ko">

<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>
    	기관사추가
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />

    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">기관사정보 추가</h1>
		</div>
	</div>
	
        <form method="post" action="./engineer_add_Action.jsp">
    <div class="container">
    <div class="form-group row">
			<h3>기관사추가</h3>
			<div class="col-sm-offset-2 col-sm-10 ">
	            <input type="submit" class="bt_join" value="완료">
	            <input type="button" class="bt_join" onclick="location.href='engineer_manage.jsp'" value="취소"/>
    	   		</div>
    	   		</div>
            <table class="table">
			<tr>
				<th>기관사ID</th>
				<th>이름</th>
				<th>경력기간</th>
				<th>주요경력</th>
				<th>전화번호</th>
				<th>연급</th>
				<th>본부ID</th>
				<th>유저ID</th>
			</tr>
			<tr>
				<td><input type="text" class="input" name=EngineerID class="form-control" /></td>
				<td><input type="text" class="input" name=Name class="form-control"/></td>
				<td><input type="text" class="input" name=CareerPeriod class="form-control"/></td>
				<td><input type="text" class="input" name=MajorCareer class="form-control"/></td>
				<td><input type="text" class="input" name=Tel class="form-control"/></td>
				<td><input type="text" class="input" name=Salary class="form-control"/></td>
				<td><input type="text" class="input" name=HeadquarterID class="form-control"/></td>
				<td><input type="text" class="input" name=UserID class="form-control"/></td>
			</tr>						
       		</table>
   </div>
	</form>   

 <jsp:include page="footer.jsp" />
</body>

</html>
