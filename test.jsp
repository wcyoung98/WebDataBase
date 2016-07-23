<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript">
	function test(){
		var check = document.form.check.checked;
		if(check == true){
			document.getElementById("text").style.display = "block";
			document.getElementById("span").style.display = "none";
		} else {
			document.getElementById("text").style.display = "none";
			document.getElementById("span").style.display = "block";
		}
	}
	</script>
</head>
<body>
	<form name="form">
	<table border="1">
		<tr>
			<td><input type="checkbox" name="check" onclick="test()"></td>
			<td><input type="text" name="text" id="text" value="abcd" style="display:none">
			<span id="span">abcd</span></td>
		</tr>
	</table>
	</form>
<%
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebdataBase";
	String id = "root";
	String pw = "apmsetup";

	Connection con = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		String query = "DESC test";
		PreparedStatement pstmt = con.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			%><br><%=rs.getString("field") %><br><%
		}
		rs.close();
		pstmt.close();
		con.close();
	} catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>