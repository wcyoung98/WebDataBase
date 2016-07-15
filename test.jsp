<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
			<td><input type="text" name="text" id="text" value="cddd" style="display:none">
			<span id="span">cddd</span></td>
			<td><input type="number"></td>
		</tr>
	</table>
	</form>
</body>
</html>