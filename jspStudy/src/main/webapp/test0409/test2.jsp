<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- /jspstudy2/src/main/webapp/test/test2.jsp --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입력된 수까지의 합 구하기</title>
</head>
<body>
<form method="post">
  숫자:<input type="text" name="num" value="${param.num}">
   <input type="submit" value="1 ~ x까지의 합 구하기">  
</form>
<c:set var="sum" value="${ 0 }" />
<c:forEach var="i" begin="1" end="${ param.num }">
	<c:set var="sum" value="${ sum + i }" />
</c:forEach>
합계 : ${ sum }
<h3>if 태그 이용해 짝수 홀수 출력</h3>
<c:if test="${ sum % 2 == 0 }">
	${ sum }은 짝수입니다.
</c:if>
<c:if test="${ sum % 2 == 1 }">
	${ sum }은 홀수입니다.
</c:if>
<h3>choose when 태그 이용해 짝/홀 출력</h3>
<c:choose>
	<c:when test="${ sum%2 == 0 }">
	${ sum }은 짝수입니다.
	</c:when>
	<c:otherwise>
	${ sum }은 홀수입니다.
	</c:otherwise>
</c:choose>
</body>
</html>