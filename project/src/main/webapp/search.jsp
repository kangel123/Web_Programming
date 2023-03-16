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
		
		ArrayList<ProductDAO> listOfProduct = new ArrayList<ProductDAO>();
		String SearchField = request.getParameter("searchField");
		String SearchText = request.getParameter("searchText");
		listOfProduct=productDAO.Product_Search(SearchField, SearchText);
		
	%>
    <jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품검색</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="search.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="productName">상품명</option>
								<option value="category">카테고리</option>
								<option value="Manufacturer">제조사</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	
	
	<div class="container">
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
	<jsp:include page="footer.jsp" />
</body>
</html>