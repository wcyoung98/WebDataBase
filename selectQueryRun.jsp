<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="CSS/main.css">
	<title>테이블 내용 보기</title>
</head>
<body>
<%
	String query = request.getParameter("query"); //Query 파라미터
	
	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
%>
	<div id="wrap">
		<h2 class="head-line"><a href="index.jsp"><%= db %></a></h2>
		<h3 class="head-line">table_name</h3>
		<form name="selectForm">
			<table class="db_show">
				<tr>
					<th></th>
<%
	Connection con = null;

	//데이터베이스 연결
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		PreparedStatement pstmt = con.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			
		}
	} catch(Exception e){
		e.printStackTrace();
	}
%>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>