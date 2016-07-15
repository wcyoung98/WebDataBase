<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="CSS/main.css">
	<title>테이블 내용 보기</title>
</head>
<body>
<% 

	String table_name = request.getParameter("name"); //테이블명 파라미터

	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";

	//컬럼명 출력 Query 변수
	String loopQuery = "SELECT column_name FROM information_schema.columns WHERE table_name = '"+table_name+"'";
	
	int colCount = 0; //컬럼의 개수 변수
	
	ArrayList<String> column = new ArrayList<String>();  //컬럼명 저장 ArrayList
%>
	<div id="wrap">
		<h2 class="head-line"><a href="index.jsp"><%= db %></a></h2>
		<h3 class="head-line"><%= table_name %></h3>
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
		PreparedStatement pstmt = con.prepareStatement(loopQuery);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			column.add(rs.getString("column_name")); //ArrayList에 컬럼명 저장
%>
					<th><%= column.get(colCount) %></th>
<%
			colCount++; //컬럼수 증가
		}
		rs.close();
		pstmt.close();
	} catch(Exception e){
		e.printStackTrace();
	}
%>
				</tr>
				<input type="hidden" name="name" value="<%= table_name %>">
<% 
	for(int i = 0; i < colCount; i++){
%>
				<input type="hidden" name="column" value="<%= column.get(i) %>">
<%
	}

	StringBuffer query = new StringBuffer("SELECT "); //데이터 출력 Query 변수
	
	for(int i = 0; i < colCount; i++){
		query.append(column.get(i));
		if(i != (colCount-1)){
			query.append(", ");
		}
	}
	query.append(" FROM ").append(table_name);
	
	try {
		PreparedStatement pstmt = con.prepareStatement(query.toString());
		ResultSet rs = pstmt.executeQuery();
		int rowCount = 0; //행의 개수 변수
		while(rs.next()){
%>
				<tr>
					<td><input type="checkbox" name="value<%=rowCount%>[0]" class="check"></td>
<%
			for(int i = 0; i < colCount; i++){
%>
					<td><input type="text" name="value<%=rowCount%>[<%=i+1%>]" value="<%= rs.getString(column.get(i)) %>"></td>
<%
			}
%>
				</tr>
<%
			rowCount++; //행의 개수 증가
		}
%>
				<tr>
					<td colspan="<%=colCount+1%>">레코드 총 <%= rowCount %>개<button type="button" onclick="insertHref('<%=table_name%>')" class="submitButton">삽입</button></td>
					<input type="hidden" name="rowCount" value="<%= rowCount %>">
					<input type="hidden" name="colCount" value="<%= colCount %>">
				</tr>
<%
	rs.close();
	pstmt.close();
	con.close();
	} catch(Exception e){
		e.printStackTrace();
	}
%>
			</table>
			<div class="checkbox_choice">
				<img src="IMG/arrow.png" alt="pointer">
				<input type="button" value="전체선택" onclick="selectCheck(1)"> 
				<input type="button" value="전체해제" onclick="selectCheck(0)"> / 
				<input type="button" value="수정" onclick="submitAction(1)"> / 
				<input type="button" value="삭제" onclick="submitAction(0)">
			</div>
		</form>
	</div>
	<script type="text/javascript" src="JS/main.js"></script>
</body>
</html>