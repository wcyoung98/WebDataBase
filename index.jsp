<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="CSS/main.css">
	<title>Web DataBase</title>
</head>
<body>
<%
	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
%>
	<div id="wrap">
		<h3 class="head-line"><a href="index.jsp"><%= db %></a></h3>
		<form name="table_check">
			<table class="db_show">
				<tr>
					<th></th>
					<th>테이블명</th>
					<th colspan="3">실행</th>
					<th>엔진</th>
					<th>레코드 수</th>
					<th>인코딩</th>
				</tr>
<%
	Connection con = null;	

	//데이터베이스 연결
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		String query = "SELECT table_name, engine, table_rows, table_collation FROM information_schema.tables WHERE table_schema = '"+db+"'";
		PreparedStatement pstmt = con.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		int i = 0; //테이블 개수 변수
		while(rs.next()){
			++i; //테이블 개수 증가
%>
				<tr>
					<td><input type="checkbox" name="select" value=<%= rs.getString("table_name") %>></td>
					<td><%= rs.getString("table_name") %></td>
					<td><a href='select.jsp?name=<%=rs.getString("table_name")%>' class="link-button">보기</a></td>
					<td><a href='describe.jsp?name=<%=rs.getString("table_name")%>' class="link-button">구조</a></td>
					<td><a href='insert_form.jsp?name=<%=rs.getString("table_name")%>' class="link-button">삽입</a></td>
					<td><%= rs.getString("engine") %></td>
					<td class="text_right"><%= rs.getString("table_rows") %></td>
					<td><%= rs.getString("table_collation") %></td>
				</tr>
<%
		}
%>
				<tr>
					<td></td>
					<td>테이블 총 <%= i %>개 </td>
					<td colspan="9"></td>
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
				<input type="button" name="allSelectOn" onclick="check(1)" value="전체선택">
				<input type="button" name="allSelectOff" onclick="check(0)" value="전체해제">
				<select onchange="mySubmit(this.value)">
					<option selected>선택한 것을</option>
					<option value="delete">비우기</option>
					<option value="drop">삭제</option>
				</select>
			</div>
		</form>
		<form name="create_form" class="table_create" action="create_form.jsp">
			<fieldset>
				<legend><%= db %>에 새로운 테이블 생성하기</legend>
				테이블명: <input type="text" name="name">
				필드 수: <input type="number" name="count" min="1">
				<input type="button" value="실행" class="submitButton" onclick="createSubmit()">
			</fieldset>
		</form>
		<form name="query_form" class="table_create" action="queryRun.jsp">
			<fieldset>
				<legend>직접 Query작성하기</legend>
				<textarea name="query" class="sqlQuery" rows="10" cols="100"></textarea>
				</fieldset>
				<fieldset>
					<input type="button" value="실행" class="submitButton" onclick="querySubmit()">
				</fieldset>
		</form>
	</div>
	<script type="text/javascript" src="JS/main.js"></script>
</body>
</html>