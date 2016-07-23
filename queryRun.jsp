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
	String query = request.getParameter("query"); //Query 파라미터

	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";

	String[] splitQuery = query.split(";"); //Query를 ';'단위로 잘라서 배열에 저장
	
	Connection con = null;
	
	//데이터베이스 연결
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		con.setAutoCommit(false);
		PreparedStatement pstmt;
		for(int i = 0; i < splitQuery.length; i++){
			pstmt = con.prepareStatement(splitQuery[i]);
			pstmt.executeUpdate();
			pstmt.close();
		}
		con.commit();
		con.setAutoCommit(true);
		con.close();
	} catch(Exception e){
		if(con != null){
			try {
				con.rollback();
			} catch(SQLException sql){
				sql.printStackTrace();
			}
		}
		e.printStackTrace();
%>
	<script type="text/javascript">
	alert("입력하신 Query가 오류를 발생시켰습니다.\n다시 확인해주세요.");
	</script>		
<%
	}
%>
	<script type="text/javascript">location.href="index.jsp";</script>
</body>
</html>