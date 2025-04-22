<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core 태그 : if, choose</title>
</head>
<body>
<h3>조건문 관련 태그 if choose</h3>
<c:if test="${5 < 10 }" >
	<h4>5는 10보다 작다</h4>
</c:if>

<% if(5 < 10) { %>
	<h4>5는 10보다 작다</h4>
<% } %>

<c:choose>
	<c:when test = "${ 5+10 == 25 }">
		<h4> 5 + 10 = 25</h4>
	</c:when>
	<c:when test="${5+10 == 15}">
		<h4> 5 + 10 = 15</h4>
	</c:when>
	<c:when test="${5+10 == 510}">
		<h4> 5 + 10 = 510</h4>
	</c:when>
	<c:otherwise>
		<h4>ㅁㄹ</h4>
	</c:otherwise>
</c:choose>

</body>
</html>