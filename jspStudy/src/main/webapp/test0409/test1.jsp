<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%--/webapp/test0409/test1.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>두개의 파라미터값을 계산하기</title>
</head>
<body>
<form method="post" >
  x:<input type="text" name="x" value="${param.x}"><br>
  y:<input type="text" name="y" value="${param.y}">
   <input type="submit" value="더하기">
</form>
<c:set var="sum" value="${ param.x + param.y }" />
합계 : ${ sum }

<h3>if 태그 이용해 출력</h3>
<c:set var="check" value="은 양수입니다." />
<c:if test="${ sum < 0 }">
	<c:set var="check" value="은 음수입니다." />
</c:if>
${ sum }${ check }

<h3>choose when 태그 이용해 출력</h3>
<c:choose>
	<c:when test="${sum > 0}">
		<c:set var="check" value="은 양수입니다." />
	</c:when>
	<c:when test="${sum < 0}">
		<c:set var="check" value="은 음수입니다." />
	</c:when>
</c:choose>
${ sum }${ check }

</body>
</html>