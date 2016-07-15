<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="CSS/main.css">
	<title>테이블 생성</title>
</head>
<body>
	<div id="wrap">
<%
	String table_name = request.getParameter("name"); //테이블명 파라미터
	int count = Integer.parseInt(request.getParameter("count")); //컬럼 수 파라미터
%>
		<h3 class="head-line"><a href="index.jsp">Main Page</a></h3>
		<h4 class="head-line"><%= table_name %></h4>
		<form name = "create_form" action="create_action.jsp">
			<input type="hidden" name="name" value=<%=table_name%>>
			<input type="hidden" name="count" value=<%=count%>>
			<table class="db_show">
				<tr>
					<th>필드명</th>
					<th>타입</th>
					<th>길이/값</th>
					<th>기본키</th>
					<th>null값 허용</th>
					<th>AUTO_INCREMENT</th>
				</tr>
<%
	for(int i = 0; i < count; i++){
%>
				<tr>
					<td><input type="text" name="fieldName"></td>
					<td>
						<select name="type">
							<option value="INT">INT</option>
							<option value="VARCHAR">VARCHAR</option>
							<option value="TEXT">TEXT</option>
							<option value="DATE">DATE</option>
							<optgroup label="NUMERIC">
								<option value="INT">INT</option>
								<option value="FLOAT">FLOAT</option>
								<option value="DOUBLE">DOUBLE</option>
								<option value="BIT">BIT</option>
								<option value="BOOL">BOOL</option>
							</optgroup>
							<optgroup label="DATE and TIME">
								<option value="DATE">DATE</option>
								<option value="DATETIME">DATETIME</option>
								<option value="TIME">TIME</option>
								<option value="YEAR">YEAR</option>
							</optgroup>
							<optgroup label="STRING">
								<option value="CHAR">CHAR</option>
								<option value="VARCHAR">VARCHAR</option>
								<option value="TEXT">TEXT</option>
								<option value="ENUM">ENUM</option>
							</optgroup>
						</select>
					</td>
					<td><input type="text" name="length"></td>
					<td>
						<select name="primary">
							<option value="" selected>NOT PRIMARY KEY</option>
							<option value="primary key">PRIMARY KEY</option>
						</select>
					</td>
					<td>
						<select name="null">
							<option value="" selected>null 허용</option>
							<option value="not null">null 비허용</option>
						</select>
					</td>
					<td>
						<select name="auto">
							<option value="" selected>None</option>
							<option value="auto_increment">Auto_Increment</option>
						</select>
					</td>
				</tr>
<%
	}
%>
				<tr>
					<td colspan="7"><input type="button" value="생성" class="submitButton" onclick="createActionSubmit()"></td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript" src="JS/main.js"></script>
</body>
</html>