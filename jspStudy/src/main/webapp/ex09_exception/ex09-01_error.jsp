<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 현재 페이지에서 오류 발생하면 errorPage 호출 --%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>exception 내장객체의 error</title>
</head>
<body>
	<% int num = Integer.parseInt("abc"); %>
</body>
</html>