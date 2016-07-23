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
	String query = request.getParameter("query");

	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
	
%>
</body>
</html>