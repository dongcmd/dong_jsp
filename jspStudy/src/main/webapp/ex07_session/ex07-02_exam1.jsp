<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>현재 날짜 session 객체에 등록하기</h3>
	<%
		Date date = new Date();
		session.setAttribute("date", date);
	%>
	등록된 날짜 : <%= date %><br>
	<a href="ex07-02_exam2.jsp">등록날짜 조회하기</a>
</body>
</html>