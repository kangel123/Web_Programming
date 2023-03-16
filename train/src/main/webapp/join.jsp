<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="ko">

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
    <!--          link 선언          -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    
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
        <form method="post" action="join_Action.jsp">
        <table class="table">
            <tr>
				<th class="active" style="text-align:center">*아이디</th>
				<td class="form-inline"><input type="text" name ="userID" id="userID" maxlength="20" minlength="6"></td>
            </tr>
            <tr >
                <th class="active" style="text-align:center">*비밀번호</th>
				<td class="form-inline"><input type="password" name="userPassword" id="userPassword" maxlength="20" minlength="6"></td>
            </tr>
            <tr>
                <th class="active" style="text-align:center">*이름</th>
				<td class="form-inline"><input type="text" name="userName" id="userName"/>
            </tr>
            <tr>
                <th class="active" style="text-align:center">전화번호</th>
				<td class="form-inline"><input type="text" name="userTel1" id="userTel1" style="width:10%"/>&nbsp;-&nbsp;
                <input type="text" name="userTel2" id="userTel2" style="width:10%"/>&nbsp;-&nbsp;
                <input type="text" name="userTel3" id="userTel3" style="width:10%"/></td>
            </tr>
            <tr>
                <th class="active" style="text-align:center">이메일</th>
				<td class="form-inline">
				<input type="text" name="user_Email_id" id="user_Email_id" style="width:20%"/> &nbsp;@ &nbsp;
				<select class="select" name="user_Email_domain" id="user_Email_domain">
    				<option value="">-선택-</option>
   					<option value="naver.com">naver.com</option>
    				<option value="gmail.com">gmail.com</option>
    				<option value="yonsei.ac.kr">yonsei.ac.kr</option>
				</select>
				</td>
            </tr>
           
        </table>
        <center>
            <input type="submit" class="btn btn-primary" style="width:20%" value="완료">
             &nbsp; &nbsp; &nbsp;
			<input type="button" class="btn btn-primary" style="width:20%" onclick="location.href='login.jsp'" value="취소"/>
        </form>
        </center>
    </div>

 <jsp:include page="footer.jsp" />
</body>

</html>
