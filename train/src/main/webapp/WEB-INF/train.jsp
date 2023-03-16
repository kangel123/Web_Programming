<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String url = "jdbc:mariadb://localhost:3306/train_db";
	String uid = "root";
	String pass = "kjw98800";
	String sql = "select * from headquarter inner join station on headquarter.headquarter_id=station.headquarter_id";%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연세 철도 주식회사 웹페이지</title>
</head>
<body>
	<table>
		<tr>
			<th>본부ID</th>
			<th>행성</th>
			<th>본부이름</th>
			<th>주소(본부)</th>
			<th>전화번호(본부)</th>
			<th>담당자(본부)</th>
			<th>역ID</th>
			<th>역명</th>
			<th>주소(역)</th>
			<th>전화번호(역)</th>
			<th>담당자(역)</th>
		</tr>
		<%
			try {
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection(url, uid, pass);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td>" + rs.getString("Headquarter_id") + "</td>");
					out.println("<td>" + rs.getString("Planet") + "</td>");
					out.println("<td>" + rs.getString("Headquarter.Name") + "</td>");
					out.println("<td>" + rs.getString("Headquarter.Address") + "</td>");
					out.println("<td>" + rs.getString("Headquarter.Tel") + "</td>");
					out.println("<td>" + rs.getString("Headquarter.ManagerName") + "</td>");
					out.println("<td>" + rs.getString("Station_ID") + "</td>");
					out.println("<td>" + rs.getString("Station.Name") + "</td>");
					out.println("<td>" + rs.getString("Station.Address") + "</td>");
					out.println("<td>" + rs.getString("Station.Tel") + "</td>");
					out.println("<td>" + rs.getString("Station.ManagerName") + "</td>");
					out.println("</tr>");
				}//while의 끝
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					rs.close();
					stmt.close();
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}//finally의 끝
		%>
	</table>
</body>
</html>