<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	이름 : <c:out value="${ param.name }"></c:out><br>
	입력 나이: <c:out value="${ param.age }"></c:out><br>
	성별 : <c:out value="${ param.gender == 1 ? '남' : '여' }"></c:out><br>
	생년 : <c:out value="${ param.year }"></c:out><br>
	실제 나이 : <c:out value="${ 2025 - param.year }"></c:out><br>
</body>
</html>