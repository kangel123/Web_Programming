<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>로그인</title>
</head>

<body>
<jsp:include page="menu.jsp" />

   <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	<div class="container">
        <form method="post" action="./login_Action.jsp">
            <h3>아이디</h3>
            <div class="loginID blockquote">
                <input type="text" class="input" placeholder="아이디" name="userID" maxlength="12"/>
            </div>
            <h3>비밀번호</h3>
            <div class="loginPassword blockquote">
                <input type="password" class="input" placeholder="비밀번호" name="userPassword" maxlength="12"/>
            </div>
            <div class="my-2">
            <input type="submit" class="bt_login" value="로그인"/>
            <input type="button" class="bt_login" onclick="location.href='join.jsp' " value="회원가입"/>
            </div>
        </form>
    </div>

	
 <jsp:include page="footer.jsp" />
</body>

</html>