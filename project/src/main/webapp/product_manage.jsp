<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="product.ProductDAO" %>
<!DOCTYPE html>
<jsp:useBean id="user" class="user.UserDAO" scope="page" />
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
        상품관리
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />
	<%
		ProductDAO productDAO = new ProductDAO();
		ArrayList<ProductDAO> listOfProduct= new ArrayList<ProductDAO>();
		listOfProduct = productDAO.Product_Lookup();
	%>
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품관리</h1>
		</div>
	</div>
	
    <div class="container">
            <table class="table">
			<h3>등록상품</h3>
			<tr>
				<th>상품ID</th>
				<th>상품명</th>
				<th>분류</th>
				<th>제조사</th>
				<th>가격</th>
				<th>판매개수</th>
				<th>상세정보</th>
				<th>현황</th>
				<th>판매자</th>
				<th></th>
			</tr>
			<% for(int i=0; i<listOfProduct.size();i++){%>
			<tr>
				<td><%out.println(listOfProduct.get(i).getProductID()); %></td>
				<td><%out.println(listOfProduct.get(i).getProductName()); %></td>
				<td><%out.println(listOfProduct.get(i).getCategory());%></td>
				<td><%out.println(listOfProduct.get(i).getManufacturer()); %></td>
				<td><%out.println(listOfProduct.get(i).getUnitPrice()); %></td>
				<td><%out.println(listOfProduct.get(i).getUnitStock()); %></td>
				<td><%out.println(listOfProduct.get(i).getDescription()); %></td>
				<td><%out.println(listOfProduct.get(i).getSituation()); %></td>
				<td><%out.println(listOfProduct.get(i).getSeller()); %></td>
				<td><a href="./product_update.jsp?id=<%=listOfProduct.get(i).getProductID()%>" class="btn btn-secondary" role="button"> 수정</a></td>
				<td><a href="./product_delete.jsp?id=<%=listOfProduct.get(i).getProductID()%>" class="btn btn-secondary" role="button"> 삭제</a></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>
       			
        

 <jsp:include page="footer.jsp" />
</body>

</html>
