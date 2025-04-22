<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 발생 페이지</title>
</head>
<body>
	<% String str = null; %>
	<%= str.trim() %>
	
	<% int num = Integer.parseInt("abc"); %>
<%--
	error 페이지 설정시 우선 순위
	
	1. 해당 페이지에서 오류 페이지 설정 <%@ page errorPage="jsp 경로" %>
	2. web.xml에서 예외 클래스별로 설정 <error-page><exception-type> ...
	3. web.xml에서 HTTP 오류 코드로 설정 <error-page><error-code> ...
	4. WAS에서 제공해주는 에러 페이지


--%>

</body>
</html>