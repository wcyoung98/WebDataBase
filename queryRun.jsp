<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
</head>
<body style="background-color: #C4E4CD;">
<%
	String query = request.getParameter("query"); //Query �Ķ����

	//�����ͺ��̽� ���� ����
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";

	String[] splitQuery = query.split(";"); //Query�� ';'������ �߶� �迭�� ����
	
	Connection con = null;
	
	//�����ͺ��̽� ����
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
	alert("�Է��Ͻ� Query�� ������ �߻����׽��ϴ�.\n�ٽ� Ȯ�����ּ���.");
	</script>		
<%
	}
%>
	<script type="text/javascript">location.href="index.jsp";</script>
</body>
</html>