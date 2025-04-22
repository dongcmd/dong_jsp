<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	로그인 한 경우만 이 페이지 출력
	로그아웃상태: 로그인해라
	 => opener를 loginForm.jsp
	 내 창은 닫아야 함
--%>
<%
	String login = (String)session.getAttribute("login");
	if(login == null) {
%>
<script>
	alert("로그인 필요");
	opener.location.href="loginForm.jsp";
	self.close();
</script>
<% } else { %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비번 변경하기</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<form action="password.jsp" method="post" name="f" onsubmit="return input_check(this)">
	<table><caption>비번 변경</caption>
		<tr><th>현재 비번</th>
				<td><input type="password" name="pass"></td></tr>
		<tr><th>변경할 비번</th>
				<td><input type="password" name="chgpass"></td></tr>
		<tr><th>변경할 비번 재입력</th>
				<td><input type="password" name="chgpass2"></td></tr>
		<tr><td colspan="2">
			<input type="submit" value="비번 변경">
			<input type="reset" value="초기화"></td></tr>
	</table></form>
<script>
	function input_check(f) {
		if(f.chgpass.value != f.chgpass2.value) {
			alert("변경할 비번과 재입력이 다릅니다.")
			f.chgpass2.value="";
			f.chgpass2.focus();
			return false; 
		}
		if(f.chgpass.value == "") {
			alert("변경할 비번을 입력하세요");
			f.chgpass.focus();
			return false;
		}
		return true;
	}
</script>
</body>
</html>
<% } %>