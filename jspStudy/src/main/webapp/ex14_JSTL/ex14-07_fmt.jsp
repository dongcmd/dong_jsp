<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL 형식화 태그 : parse 관련 태그</title>
</head>
<body>
<h3>Format 된 숫자를 숫자로 변경</h3>
<fmt:parseNumber value="10,000" var="n1" pattern="##,###" />
<fmt:parseNumber value="20,000" var="n2" pattern="##,###" />
합 : ${ n1 } + ${ n2 } = ${ n1 + n2 }<br>
<%-- van 속성 없으면 화면에 출력 --%>
<fmt:parseNumber value="10,000" pattern="##,###" /><br>
<fmt:parseNumber value="20,000" pattern="##,###" /><br>
문제 : n1, n2 이용해서 20,000 + 10,000 = 30,000 출력하기<br>
<fmt:formatNumber var="f1" value="${n1}" pattern="##,###" />
<fmt:formatNumber var="f2" value="${n2}" pattern="##,###" />
<fmt:formatNumber var="f3" value="${n1 + n2}" pattern="##,###" />
답 : ${ f1 } + ${ f2 } = ${ f3 }

<h3>Format 된 날짜를 날짜형으로 변경하기</h3>
<fmt:parseDate value="25-12-25 12:00:00" pattern="yy-MM-dd HH:mm:ss" var="day"/>
${ day }
<p> 25 12 25 요일 출력하기<br>
<fmt:formatDate value="${day}" pattern="E" />
</p>
</body>
</html>