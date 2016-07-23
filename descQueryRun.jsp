<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="CSS/main.css">
	<title>DESCRIBE</title>
</head>
<body>
<%
	String query = request.getParameter("query");

	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
	
	String[] queryArray = query.split(" ");
%>
	<div id="wrap">
		<h2 class="head-line"><a href="index.jsp"><%= db %></a></h2>
		<h3 class="head-line"><%= queryArray[1].replace(";", "") %></h3>
		<table class="db_show">
			<tr>
				<th>Field</th>
				<th>Type</th>
				<th>Null</th>
				<th>Key</th>
				<th>Default</th>
				<th>Extra</th>
			</tr>
<%
	Connection con = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		PreparedStatement pstmt = con.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
%>
			<tr>
				<td><%= rs.getString("Field") %></td>
				<td><%= rs.getString("Type") %></td>
				<td><%= rs.getString("Null") %></td>
				<td><%= rs.getString("Key") %></td>
				<td><%= rs.getString("Default") %></td>
				<td><%= rs.getString("Extra") %></td>
			</tr>
<%
		}
		rs.close();
		pstmt.close();
		con.close();
	} catch(Exception e){
%>
	<script type="text/javascript">
	alert("입력하신 Query가 오류를 발생시켰습니다.\n다시 확인해주세요.");
	location.href="index.jsp";
	</script>
<%
		e.printStackTrace();
	}
%>
		</table>
	</div>
</body>
</html>