<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>include 예제</title>
</head>
<body>
	<h3>ex06-03_include.jsp 페이지</h3>
	<hr>
	<%
		String msg = "ex06-03_include.jsp의 메세지";
		pageContext.include("ex06-03_include2.jsp");
	%>
	<hr>
	test 파라미터 : <%= request.getParameter("test") %>
</body>
</html>