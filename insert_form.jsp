<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="CSS/main.css">
	<title>데이터 삽입</title>
</head>
<body>
<%
	String table_name = request.getParameter("name"); //테이블명 파라미터

	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
%>
	<div id="wrap">
		<h2 class="head-line"><a href="index.jsp"><%= db %></a></h2>
		<h3 class="head-line"><%= table_name %></h3>
		<form name = "insert_form" action="insert_action.jsp">
			<input type="hidden" name="name" value=<%= table_name %>>
			<table class="db_show">
				<tr>
					<th>필드명</th>
					<th>타입</th>
					<th>Extra</th>
					<th>값</th>
				</tr>
<%
	Connection con = null;

	//데이터베이스 연결
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		String query = "DESC "+table_name;
		PreparedStatement pstmt = con.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
%>
				<tr>
					<td><%= rs.getString("Field") %></td>
					<td><%= rs.getString("Type") %></td>
					<td><%= rs.getString("Extra") %></td>
					<td><input type="text" name="value"></td>
				</tr>
<%
		}
		rs.close();
		pstmt.close();
		con.close();;
	} catch(Exception e){
		e.printStackTrace();
	}
%>
				<tr>
					<td colspan="4"><input type="button" value="삽입" class="submitButton" onclick="insertSubmit()"></td>
				</tr>
				<tr>
					<td colspan="4">
					<p>Auto_Increment는 추후의 수정하겠습니다.</p>
					<p>일단 Auto_Increment는 0을 입력해주세요.</p>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript" src="JS/main.js"></script>
</body>
</html>