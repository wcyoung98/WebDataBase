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
	int rowCount = Integer.parseInt(request.getParameter("rowCount")); //행의 개수 파라미터
	int colCount = Integer.parseInt(request.getParameter("colCount")); //컬럼 수 파라미터
	String table_name = request.getParameter("name"); //테이블명 파라미터
	String[] column = request.getParameterValues("column"); //컬럼명 파라미터
	String[][] value = new String[rowCount][colCount+1]; //SET값 파라미터
	
	for(int i = 0; i < rowCount; i++){
		for(int j = 0; j <= colCount; j++){
			value[i][j] = request.getParameter("value"+i+"["+j+"]");
		}
	}
	
	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
	
	Connection con = null;
	
	//데이터베이스 연결
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		con.setAutoCommit(false);
		StringBuffer query = new StringBuffer(); //UPDATE Query 변수
		StringBuffer selectQuery = new StringBuffer(); //변경될 값 SELECT Query 변수
		PreparedStatement pstmt;
		PreparedStatement selectPstmt;
		ResultSet rs;
		
		for(int i = 0; i < rowCount; i++){
			if(value[i][0] == null) continue;
			query.append("UPDATE ").append(table_name).append(" SET ");
			for(int j = 0; j < colCount; j++){
				query.append(column[j]).append("='").append(value[i][j+1]).append("'");
				if(j != (colCount-1)){
					query.append(", ");
				}
			}

			query.append(" WHERE ");
			selectQuery.append("SELECT ");
			for(int x = 0; x < column.length; x++){
				selectQuery.append(column[x]);
				if(x != (column.length-1)) selectQuery.append(", ");
			}
			selectQuery.append(" FROM ").append(table_name).append(" LIMIT ").append(i).append(", 1");
			%><br><%=selectQuery%><br><%
			selectPstmt = con.prepareStatement(selectQuery.toString());
			rs = selectPstmt.executeQuery();
			if(rs.next()){
				for(int x = 0; x < column.length; x++){
					query.append(column[x]).append("='").append(rs.getString(column[x])).append("'");
					if(x != (column.length-1)){
						query.append(" AND ");
					}
				}
			}
			query.append(" LIMIT 1");
			%><br><%=query%><br><%
			pstmt = con.prepareStatement(query.toString());
			pstmt.executeUpdate();
			rs.close();
			pstmt.close();
			query.setLength(0);
			selectQuery.setLength(0);
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
	alert("입력하신 값이 오류를 발생시켰습니다.\n다시확인해주세요.");
	</script>
<%
	}
%>
	<!-- <script type="text/javascript">
	var url = document.referrer;
	location.href=url;
	</script> -->
</body>
</html>