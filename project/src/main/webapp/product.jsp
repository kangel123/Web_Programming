<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="user.UserDAO"%>
<jsp:useBean id="productDAO" class="product.ProductDAO" scope="session" />
<html>
<head>
<link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		String id = request.getParameter("id");
		ProductDAO product = productDAO.Product(id);
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h3><%=product.getProductName()%></h3>
				<p><b>분류</b> : <%=product.getCategory()%>
				<p><b>제조사</b> : <%=product.getManufacturer()%>
				<p><b>가격</b>:<%=product.getUnitPrice()%>원
				<p><b>재고 수</b> : <%=product.getUnitStock()%>개
				<p><b>상세설명</b> : <%=product.getDescription()%>
				<p><a href="./product_buy.jsp?id=<%=product.getProductID()%>" class="btn btn-info"> 상품 주문 &raquo;</a> <a	href="./products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>
			</div>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
