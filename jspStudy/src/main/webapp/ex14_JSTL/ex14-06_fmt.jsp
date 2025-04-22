<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL 형식화 태그 : fmt</title>
</head>
<body>
<h3>날짜 관련 형식 지정</h3>
<c:set var="today" value="<%= new java.util.Date() %>" />

년월일 : <fmt:formatDate value="${ today }" type="date" /><br>
시분초: <fmt:formatDate value="${ today }" type="time" /><br>
년월일시분초: <fmt:formatDate value="${ today }" type="both" /><br>
년월일시분초-short: <fmt:formatDate value="${ today }" type="both" timeStyle="short" /><br>
년월일시분초-long: <fmt:formatDate value="${ today }" type="both" timeStyle="long" /><br>
년월일시분초-full: <fmt:formatDate value="${ today }" type="both" timeStyle="full" /><br>
년월일시분초-full GMT: <fmt:formatDate value="${ today }" type="both" timeStyle="full" timeZone="GMT" /><br>
형식 지정 : <fmt:formatDate value="${today}" pattern="yyyy-MM-dd HH:mm:ss a E" /><br>
<p> pattern 속성은 SimpleDateFormat에서 사용하는 형식화 문자와 같다 </p>
<%--
	~Format 클래스
	format() : 객체 => 형식화된 문자열
	parse() : 형식화된 문자열 => 객체
--%>
</body>
</html>