<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="ko">

<head>
    <!--          meta 선언          -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--          link 선언          -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    
    <!--          script 선언          -->
    <script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <script src="../js/script.js"></script>

    <title>
        회원가입
    </title>
</head>

<body>
<jsp:include page="menu.jsp" />

    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원가입</h1>
		</div>
	</div>
	<div class="container">
        <form method="post" action="./join_Action.jsp">
            <div class="form-group row">
            <label class="col-sm-2">아이디</label>
            <div class="col-sm-3">
                <input type="text" class="input" style="ime-mode:disabled;" placeholder="아이디" name="userID" class="form-control" maxlength="20" minlength="6"/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">비밀번호</label>
                <div class="col-sm-3">
                <input type="password" class="input" placeholder="비밀번호" name="userPassword" class="form-control" maxlength="20" minlength="6"/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">이름</label>
                <div class="col-sm-3">
                <input type="text" class="input" placeholder="이름" name="userName" class="form-control" maxlength="5"/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">전화번호</label>
                <div class="col-sm-3">
                <input type="tel" class="input" placeholder="전화번호" name="userTel" class="form-control"/>
            </div>
            </div>
            <div class="form-group row">
            <label class="col-sm-2">이메일</label>
            <div class="col-sm-3">
                <input type="email" class="input" placeholder="이메일" name="userEmaill" class="form-control"/>
            </div>
            </div>

			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
            <input type="submit" class="bt_join" value="완료">
			<input type="button" class="bt_join" onclick="location.href='login.jsp'" value="취소"/>
       		</div>
       		</div>
        </form>
    </div>

 <jsp:include page="footer.jsp" />
</body>

</html>
