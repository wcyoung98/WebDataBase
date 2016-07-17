<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body style="background-color: #C4E4CD;">
<%
	String table_name = request.getParameter("name"); //테이블명 파라미터
	String[] value = request.getParameterValues("value"); //INSERT할 값 파라미터

	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";

	//INSERT Query 변수
	StringBuffer query = new StringBuffer("INSERT INTO ");
	
	query.append(table_name).append(" VALUES(");
	for(int i = 0; i < value.length; i++){
		query.append("?");
		if(i != (value.length - 1)){
			query.append(",");
		}
	}
	query.append(")");

	Connection con = null;
	
	//데이터베이스 연결
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		con.setAutoCommit(false);
		PreparedStatement pstmt = con.prepareStatement(query.toString());
		for(int i = 0; i < value.length; i++){
			pstmt.setString(i+1, value[i]);
		}
		pstmt.executeUpdate();
		pstmt.close();
		con.commit();
		con.setAutoCommit(true);
		con.close();
	} catch(Exception e){
		if(con != null){
			try{
				con.rollback();
			} catch(SQLException sql){
				sql.printStackTrace();
			}
		}
		e.printStackTrace();
%>
	<script type="text/javascript">
	alert("입력하신 값이 오류를 발생시켰습니다.\n다시 확인해주세요.\nauto_increment는 0을 입력해주세요.");
	</script>
<%
	}
%>
	<script type="text/javascript">
	var name = "<%=table_name%>";
	location.href="select.jsp?name="+name;
	</script>
</body>
</html>