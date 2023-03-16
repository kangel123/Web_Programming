<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
<html lang="ko">

<head>

    <!--          link 선언          -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    

    <title>
        회원가입
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />
	<%
		UserDAO userDAO = new UserDAO();
		String userID= (String) session.getAttribute("userID");
		user=userDAO.getUser(userID);
	%>
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">마이페이지</h1>
		</div>
	</div>
	<div class="container">
        <form method="post" action="./mypage_update.jsp">
            
			<div class="form-group row">
			<div><h3>회원정보</h3></div> 
				<div class="col-sm-offset-2 col-sm-10 ">
	            <input type="submit" class="bt_join" value="수정">
    	   		</div>
       		</div>
       		
            <div class="form-group row">
            <label class="col-sm-2">아이디</label>
            <div class="col-sm-3">
                <input type="text" class="input" style="ime-mode:disabled;" value="<%out.println(userID); %>" name=userID class="form-control" readonly/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">비밀번호</label>
                <div class="col-sm-3">
                <input type="text" class="input" value="<%out.println(user.getUserPassword()); %>" name=userPassword class="form-control" readonly/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">이름</label>
                <div class="col-sm-3">
                <input type="text" class="input" value="<%out.println(user.getUserName()); %>" name=userName class="form-control" readonly/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">전화번호</label>
                <div class="col-sm-3">
                <input type="tel" class="input" value="<%out.println(user.getUserTel()); %>" name=userTel class="form-control" readonly/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">이메일</label>
            <div class="col-sm-3">
                <input type="email" class="input" value="<%out.println(user.getUserEmaill()); %>" name=userEmaill class="form-control" readonly/>
            </div>
            </div>
        </form>      
    </div>
       			
        

 <jsp:include page="footer.jsp" />
</body>

</html>
