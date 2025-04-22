<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/ex14_JSTL/ex14-03_core.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL core 태그 : forEach</title>
</head>
<body>
<h3>반복 관련 태그 :forEach</h3>
<h4>1에서 10까지 숫자 출력하기</h4>
<c:forEach var="i" begin="1" end="10">
	${i}&nbsp;&nbsp;
</c:forEach>
<h4>1에서 10까지 홀수만 출력</h4>
<c:forEach var="i" begin="1" end="10" step="2">
	${i}&nbsp;&nbsp;
</c:forEach><br>
<c:forEach var="i" begin="1" end="10">
	<c:if test="${i%2 == 1 }">
		${i}&nbsp;&nbsp;
	</c:if>
</c:forEach><br>

<h4>1에서 10까지 숫자 합 출력</h4>
<c:forEach var="i" begin="1" end="10">
	<c:set var="sum" value="${sum + i}" />
</c:forEach>
1~10 합 : ${sum}<br>
<c:set var="sum" value="${0}" />

<h4>1에서 10까지 짝수 합 출력</h4>
<c:forEach var="i" begin="2" end="10" step="2">
	<c:set var="sum" value="${sum + i}" />
</c:forEach>
1~10 짝수 합 : ${sum}<br>

<h3>forEach 태그 이용해 구구단 출력</h3>
<c:forEach var="i" begin="2" end="9">
	<h4>${i}단</h4>
	<c:forEach var="j" begin="2" end="9">
		${i} * ${j} = ${i * j}<br>
	</c:forEach>
</c:forEach>

<h3>forEach 태그를 이용해 List 객체의 요소 출력</h3>
<%
	List<Integer> list = new ArrayList<>();
	for(int i = 1; i <= 10; i++) {
		list.add(i*10);
	}
	pageContext.setAttribute("list", list);
%>
<c:forEach var="a" items="${list}" varStatus="s">
	${s.count} : ${a} &nbsp;&nbsp;&nbsp;
	<c:if test="${s.index == 4  }"> <br></c:if>
</c:forEach>
<%-- list를 두 줄로 출력 --%>
</body>
</html>