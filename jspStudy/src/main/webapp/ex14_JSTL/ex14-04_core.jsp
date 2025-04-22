<%@page import="java.util.Arrays"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/ex14_JSTL/ex14-04_core.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forEach를 이용해 Collection 객체 조회하기</title>
</head>
<body>
<h3>forEach 태그를 이용해 Map 객체 출력하기</h3>
<%
	Map<String, Object> map = new HashMap<>();
	map.put("name", "홍길동");
	map.put("today", new Date());
	map.put("age", 20);
	pageContext.setAttribute("map", map);
%>
<c:forEach var="m" items="${map }" varStatus="stat">
	${stat.count } : ${m.key } = ${ m.value }<br>
</c:forEach>
<hr>
<h3>map 객체를 EL을 이용해 출력</h3>
이름   ${map.name}<br>
나이 : ${map.age}<br>
ㅇ늘날짜 : ${map.today}<br>

<h3>forEach 이용해 배열 객체 출력하기</h3>
<c:set var="arr" value="<%= new int[] {10,20,30,40,50,60} %>" />
<c:forEach var="a" items="${arr}" varStatus="stat">
	arr[${stat.index}] = ${ a }<br>
</c:forEach>

<h3>배열 객체를 EL을 이용해 출력</h3>
arr[0] : ${ arr[0] }<br>
arr[3] : ${ arr[3] }<br>

<h3>List 객체를 EL을 이용해 출력</h3>
<c:set var="list" value="<%= Arrays.asList(10, 20, 30, 40) %>" />
list[0] = ${ list[0] }<br>
list[1] = ${ list[1] }<br>
list[2] = ${ list[2] }<br>

<h3>forEach 태그를 이용해 배열 객체의 2번~3번 요소만 출력</h3>
<h4>begin, end, step 속성값 : 배열의 인덱스</h4>
<c:forEach var="a" items="${ arr }" varStatus="stat" begin="1" end="2">
	arr[${stat.index}] = ${ a }<br>	
</c:forEach>
<br>
<c:forEach var="a" items="${ arr }" varStatus="stat" step="3">
	arr[${stat.index}] = ${ a }<br>	
</c:forEach>
</body>
</html>