<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand  navbar-dark bg-dark">
        <div class="container">
                <ul class="navbar-nav">
	                <li>
        	        	<a class="navbar-brand" href="main.jsp"><strong class="text-primary">Yonrail</strong> </a>
    	            </li>
                    <li>
                        <a class="navbar-brand" href="#">소개</a>
                    </li>
                    <li>
                    <%
                    String userposition = (String)session.getAttribute("userPosition");
					if(userposition != null && userposition.equals("engineer")){%>
					<a class="navbar-brand" href="engineer_operation_manage.jsp">운행기록</a>
					<%
					} else if(userposition != null && userposition.equals("admin")){%>
					<a class="navbar-brand" href="#">데이터관리</a>	
					<ul class="navbar-nav">
						<li><a class="navbar-brand" href="user_manage.jsp">유저관리</a></li>
						<li><a class="navbar-brand" href="headquarter_manage.jsp">본부관리</a></li>
						<li><a class="navbar-brand" href="station_manage.jsp">역관리</a></li>
						<li><a class="navbar-brand" href="train_manage.jsp">열차관리</a></li>
						<li><a class="navbar-brand" href="line_manage.jsp">라인관리</a></li>
						<li><a class="navbar-brand" href="traincode_manage.jsp">열차코드관리</a></li>
						<li><a class="navbar-brand" href="engineer_manage.jsp">기관사관리</a></li>
						<li><a class="navbar-brand" href="vehicle_manage.jsp">차량관리</a></li>
						<li><a class="navbar-brand" href="connect_manage.jsp">연결노선관리</a></li>
						<li><a class="navbar-brand" href="operation_manage.jsp">운행관리</a></li>
					</ul>
					<%} %>
                    </li>
               </ul>
               <ul class="navbar-nav">
                    <li class="nav-item ml-md-4">
                    	<%if(session.getAttribute("userID")== null){%>
					<div>
						<button type="button" class="btn btn-primary" onclick="location.href='join.jsp' ">회원가입</button>
						<button type="button" class="btn btn-primary" onclick="location.href='login.jsp' ">로그인</button>
					</div>
        			<%} else{ %> 
				 	<div>
	 					<button type="button" class="btn btn-primary" onclick="location.href='./mypage.jsp' ">마이페이지</button>
	 					<button type="button" class="btn btn-primary" onclick="location.href='logoutCheck.jsp' ">로그아웃</button>
					</div>
 					<%}; %>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
