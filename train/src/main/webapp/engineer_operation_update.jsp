<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="dto.OperationDAO" %>
<jsp:useBean id="operationDAO" class="dto.OperationDAO" scope="session" />

<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html lang="ko">

<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>
    	역수정
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />
	<%
		String id = request.getParameter("id");
		OperationDAO operation = operationDAO.operation(id);
	%>
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">역정보 수정</h1>
		</div>
	</div>
	
        <form method="post" action="./engineer_operation_update_Action.jsp?id=<%=operation.getOperationID()%>">
    <div class="container">
    <div class="form-group row">
			<h3>역수정</h3>
			<div class="col-sm-offset-2 col-sm-10 ">
	            <input type="submit" class="bt_join" value="완료">
	            <input type="button" class="bt_join" onclick="location.href='engineer_operation_manage.jsp'" value="취소"/>
    	   		</div>
    	   		</div>
            <table class="table">
			<tr>
				<th>열차코드ID</th>
				<th>열차ID</th>
				<th>상태</th>
			</tr>
			<tr>
				<td><input type="text" class="input" value="<%=operation.getTrainCodeID()%>" name=TrainCodeID class="form-control"/></td>
				<td><input type="text" class="input" value="<%=operation.getTrainID()%>" name=Train_ID class="form-control"/></td>
				<td><input type="text" class="input" value="<%=operation.getStatus()%>" name=Status class="form-control"readonly/></td>
			</tr>						
       		</table>
   </div>
	</form>   

 <jsp:include page="footer.jsp" />
</body>

</html>
