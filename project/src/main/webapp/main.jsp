<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.ProductDAO" %>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body>
<%
		ProductDAO productDAO = new ProductDAO();
		ArrayList<ProductDAO> listOfProduct= new ArrayList<ProductDAO>();
		listOfProduct = productDAO.Product_Lookup();
	%>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">메인화면</h1>
		</div>
	</div>
	
	<div class="container">
	<h3><span style="background-color: #03f3b3;">전체상품</span></h3>
		<div class="row" align="center">
			<%
				for (int i = 0; i < listOfProduct.size(); i++) {
					ProductDAO product = listOfProduct.get(i);
			%>
			<% if(product.getSituation().equals("판매중")){%>
			<div class="col-md-4">
				<h3>상품명:<%=product.getProductName()%></h3>
				<p>카테고리:<%=product.getCategory()%>
				<p>가격:<%=product.getUnitPrice()%>원
				<p>개수:<%=product.getUnitStock()%>개
				<p><a href="./product.jsp?id=<%=product.getProductID()%>" class="btn btn-secondary" role="button"> 상세 정보 &raquo;</a>				
			 </div>
			<%} %>
			<%}%>
		</div>
		<hr>
	</div>

	<%if(session.getAttribute("userID")!= null){%>
	
	<div class="container">
		<h3><span style="background-color: #03f3b3;">판매상품 등록</span></h3>
		<form name="newProduct" action="./product_registration_Action.jsp" class="form-horizontal" method="post">			
			
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="pname" class="form-control" >
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
			<input type="number" name="unitStock" min="1" class="form-control">
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
	<% }%>
	
	<jsp:include page="footer.jsp" />
</body>
</html>
