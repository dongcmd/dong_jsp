<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- ex07-02_exam2.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>session에 등록된 날짜 조회하고,
		session 속성에서 제거하기<br>
		등록된 날짜 없으면 ex07-02_exam1.jsp 로 이동하기
</h3>
<hr>
<% Date date = (Date)session.getAttribute("date");
	if(date == null) {
%>
<script>
	// alert("등록된 날짜가 없다")
	// history.go(-1)
</script>
	<% response.sendRedirect("ex07-02_exam1.jsp"); %>
<% } else { %>
	exam1에서 등록한 날짜<br>
	session.getAttribute("date") :
	<%= date %>
	<% session.removeAttribute("date"); }%>

</body>
</html>