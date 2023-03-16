<%@ page import="java.io.PrintWriter" %>
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
        데이터 입력
    </title>
</head>

<body>

	<%if(session.getAttribute("userID")== null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후에 사용 가능합니다'); history.go(-1);");
		script.println("</script>");	
	} %>
	
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	<div class="container">
		<form name="newProduct" action="./product_registration_Action.jsp" class="form-horizontal" method="post">			
			
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="pname" class="form-control" required>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-2">
				<select name="category">
					<option value="Import">수입명품</option>
					<option value="Cloth">패션의류</option>
					<option value="Beauty">뷰티</option>
					<option value="Car">중고차</option>
					<option value="Leisure">레저/여행</option>
					<option value="Laptop">노트북/데스크탑</option>
					<option value="Tool">공구/산업용품</option>
					<option value="Sport">스포츠</option>
					<option value="Game">게임</option>
					<option value="Book">도서/음반/문구</option>
					<option value="Etc">기타</option>
					
				</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control" >
				</div>
			</div>
			
			
			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-3">
					<input type="number" name="unitPrice" min="1" class="form-control" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">판매개수</label>
				<div class="col-sm-3">
			<input type="number" name="unitStock" min="1" class="form-control" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm-5">
					<textarea name="description" cols="50" rows="2"
						class="form-control"></textarea>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary" value="등록완료" >
					<input type="Button" class="btn btn-primary" onclick="location.href='main.jsp'"value="취소" >				
				</div>
			</div>
		</form>
	</div>	
</body>

</html>
