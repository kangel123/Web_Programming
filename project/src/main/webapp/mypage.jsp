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
        회원가입
    </title>
</head>
	
<body>
<jsp:include page="menu.jsp" />
	<%
		UserDAO userDAO = new UserDAO();
		String userID= (String) session.getAttribute("userID");
		user=userDAO.getUser(userID);
		
		ProductDAO productDAO = new ProductDAO();
		ArrayList<ProductDAO> listOfProduct= new ArrayList<ProductDAO>();
		listOfProduct = productDAO.getproducts(userID, listOfProduct);
	%>
    <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">마이페이지</h1>
		</div>
	</div>
	<div class="container">
        <form method="post" action="./user_update.jsp">
            
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
    <div class="container">
            <table class="table">
			<h3>등록상품</h3>
			<tr>
				<th>상품명</th>
				<th>분류</th>
				<th>제조사</th>
				<th>가격</th>
				<th>판매개수</th>
				<th>상세정보</th>
				<th>현황</th>
			</tr>
			<% for(int i=0; i<listOfProduct.size();i++){%>
			<tr>
				<td><%out.println(listOfProduct.get(i).getProductName()); %></td>
				<td><%out.println(listOfProduct.get(i).getCategory());%></td>
				<td><%out.println(listOfProduct.get(i).getManufacturer()); %></td>
				<td><%out.println(listOfProduct.get(i).getUnitPrice()); %></td>
				<td><%out.println(listOfProduct.get(i).getUnitStock()); %></td>
				<td><%out.println(listOfProduct.get(i).getDescription()); %></td>
				<td><%out.println(listOfProduct.get(i).getSituation()); %></td>
			</tr>			
			<%} %>
			
       		</table>
   </div>
       			
        

 <jsp:include page="footer.jsp" />
</body>

</html>
