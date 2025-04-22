<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL 형식화 태그</title>
</head>
<body>
<h3>숫자 관련 형식 지정하기</h3>
<fmt:formatNumber value="500000" type="currency" currencySymbol="₩" /><br>
<fmt:formatNumber value=".15" type="percent" /><br>
<fmt:formatNumber value="50000.345" pattern="###,###.00"/><br>

<h3>지역 설정하기</h3>
<fmt:setLocale value="en_US" />
<fmt:formatNumber value="500000" type="currency" /><br>
<fmt:setLocale value="ko_KR" />
<fmt:formatNumber value="500000" type="currency" /><br>
</body>
</html>