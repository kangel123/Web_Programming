<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="product.ProductDAO" %>
<jsp:useBean id="productDAO" class="product.ProductDAO" scope="session" />

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
		String id = request.getParameter("id");
		ProductDAO product = productDAO.Product(id);
		String category=product.getCategory();
	%>
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품수정</h1>
		</div>
	</div>
	
        <form method="post" action="./product_update_Action.jsp">
    <div class="container">
    <div class="form-group row">
			<h3>등록상품</h3>
			<div class="col-sm-offset-2 col-sm-10 ">
	            <input type="submit" class="bt_join" value="완료">
	            <input type="button" class="bt_join" onclick="location.href='product_manage.jsp'" value="취소"/>
    	   		</div>
    	   		</div>
            <table class="table">
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
			</tr>
			<tr>
				<td><input type="text" class="input" value="<%=product.getProductID()%>" name=ProductID class="form-control" readonly/></td>
				<td><input type="text" class="input" value="<%=product.getProductName()%>" name=ProductName class="form-control"/></td>
				<td>
				<select name="Category">
					<option value="Import" <%if(category.equals("Import")){ %>selected<%;}%>>수입명품</option>
					<option value="Cloth" <%if(category.equals("Cloth")){ %>selected<%;}%>>패션의류</option>
					<option value="Beauty" <%if(category.equals("Beauty")){ %>selected<%;}%>>뷰티</option>
					<option value="Car" <%if(category.equals("Car")){ %>selected<%;}%>>중고차</option>
					<option value="Leisure" <%if(category.equals("Leisure")){ %>selected<%;}%>>레저/여행</option>
					<option value="Laptop" <%if(category.equals("Laptop")){ %>selected<%;}%>>노트북/데스크탑</option>
					<option value="Tool" <%if(category.equals("Tool")){ %>selected<%;}%>>공구/산업용품</option>
					<option value="Sport" <%if(category.equals("Sport")){ %>selected<%;}%>>스포츠</option>
					<option value="Game" <%if(category.equals("Game")){ %>selected<%;}%>>게임</option>
					<option value="Book" <%if(category.equals("Book")){ %>selected<%;}%>>도서/음반/문구</option>
					<option value="Etc" <%if(category.equals("Etc")){ %>selected<%;}%>>기타</option>
					
				</select>
				</td>
				<td><input type="text" class="input" value="<%=product.getManufacturer()%>" name=Manufacturer class="form-control"/></td>
				<td><input type="text" class="input" value="<%=product.getUnitPrice()%>" name=UnitPrice class="form-control"/></td>
				<td><input type="text" class="input" value="<%=product.getUnitStock()%>" name=UnitStock class="form-control"/></td>
				<td><input type="text" class="input" value="<%=product.getDescription() %>" name=Description class="form-control"/></td>
				<td><select name="Situation">
				<%if(product.getSituation().equals("확인중")){ %>
					<option value="확인중" selected>확인중</option>
					<option value="판매중" >판매중</option>
					<option value="판매완료" >판매완료</option>
					<%}else if(product.getSituation().equals("판매중")){  %>
					<option value="확인중" selected>확인중</option>
					<option value="판매중" >판매중</option>
					<option value="판매완료" >판매완료</option>
					<%} else{%>					
					<option value="확인중" selected>확인중</option>
					<option value="판매중" >판매중</option>
					<option value="판매완료" >판매완료</option>
					<%} %>
				</select>
				</td>
				<td><input type="text" class="input" value="<%=product.getSeller() %>" name=Seller class="form-control"/></td>
				
			</tr>			
			
       		</table>
   </div>
       			</form>
        

 <jsp:include page="footer.jsp" />
</body>

</html>
