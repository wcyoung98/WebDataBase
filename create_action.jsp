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
	int count = Integer.parseInt(request.getParameter("count")); //컬럼 수 파라미터
	String[] fieldName = request.getParameterValues("fieldName"); //필드명 파라미터
	String[] type = request.getParameterValues("type"); //데이터타입 파라미터
	String[] length = request.getParameterValues("length"); //데이터길이 파라미터
	String[] primary = request.getParameterValues("primary"); //기본키 설정 파라미터
	String[] notNull = request.getParameterValues("null"); //null값 허용 파라미터
	String[] auto = request.getParameterValues("auto"); //auto_increment 설정 파라미터

	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
	
	//CREATE TABLE Query 변수
	StringBuffer query = new StringBuffer("CREATE TABLE ");

	query.append(table_name).append(" (");
	for(int i = 0; i < count; i++){
		query.append(fieldName[i]).append(" ").append(type[i]);
		if(length[i] != ""){
			query.append("(").append(length[i]).append(")");
		}
		query.append(" ");
		if(primary[i] != ""){
			query.append(primary[i]).append(" ");
			query.append(auto[i]).append(" ");
		} else {
			query.append(notNull[i]).append(" ");
		}

		if(i != count-1){
			query.append(", ");
		}
	}
	query.append(")");
	
	Connection con = null;
	
	//데이터베이스 연결
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		con.setAutoCommit(false);
		PreparedStatement pstmt = con.prepareStatement(query.toString());
		pstmt.executeUpdate();
		pstmt.close();
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
		<script>
		var name = "<%=table_name%>";
		var count = "<%=count%>"
		alert("입력하신 값이 오류를 발생시켰습니다.\n다시확인해주세요.");
		location.href="create_form.jsp?name="+name+"&count="+count;
		</script>
<%
	}
%>
	<script type="text/javascript">location.href="index.jsp";</script>
</body>
</html>