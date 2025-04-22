<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fmt태그 : 인코딩</title>
</head>
<body>
<%--
<% request.setCharacterEncoding("utf-8"); %>
--%>
<fmt:requestEncoding value="utf-8" />
<form method="post" name="f">
	이름 : <input type="text" name="name" value="${ param.name }"><br>
	입사일 : <input type="text" name="hiredate" value="${ param.hiredate }">
	yyyy-MM-dd 형태로 입력<br>
	급여 : <input type="text" name="salary" value="${ param.salary }"><br>
	<%--
		paramValues.job : job 파라미터 값들을 배열로 리턴
		${ fn:join( 배열, 구분자 ) } : 배열의 요소를 구분자로 연결해 문자열로 리턴
	--%>
	<c:set var="jobs" value="${ fn:join(paramValues.job, '-') }" />
	담당업무 : <input type="checkbox" name="job" value="서무" 
	<c:if test="${ fn:contains(jobs, '서무') }"> checked="checked" </c:if>
		>서무 &nbsp;
	 <input type="checkbox" name="job" value="개발"
	 <c:if test="${ fn:contains(jobs, '개발') }"> checked="checked" </c:if>
	 >개발 &nbsp;
	  <input type="checkbox" name="job" value="비서"
	 <c:if test="${ fn:contains(jobs, '비서') }"> checked="checked" </c:if>	  
	  >비서 &nbsp;
	   <input type="checkbox" name="job" value="운용"
	 <c:if test="${ fn:contains(jobs, '운용') }"> checked="checked" </c:if>
	 >운용 &nbsp;	  
	<input type="submit" value="ㄱㄱ">
</form>

이름 : ${ param.name }<br>
입사일 : ${ param.hiredate }<br>
급여 : ${ param.salary }<br>
담당업무 : <c:forEach items="${ paramValues.job }" var="j"> ${ j } &nbsp;</c:forEach>
<br>

<h3>입사일을 yy-MM-dd E요일 형태로 출력, 급여, 연봉을 세자리마다 ,로 출력</h3>
이름 : ${ param.name }<br>
<c:catch var="formatexception">
<fmt:parseDate value="${param.hiredate}" pattern="yyyy-MM-dd" var="hiredate" />
</c:catch>
입사일 :
	<c:if test="${ formatexception == null }">
		<fmt:formatDate value="${ hiredate }" pattern="yy-MM-dd E요일" /><br>
	</c:if>
	<c:if test="${ formatexception != null }">
		입사일은 yyyy-mm-dd 형태로 입력하세요.<br>
	</c:if>
급여 : <fmt:formatNumber value="${ param.salary }" type="currency" /><br>
연봉 : <fmt:formatNumber value="${ param.salary * 12 }" type="currency" /><br>
담당업무 : <c:forEach items="${ paramValues.job }" var="j"> ${ j } &nbsp;</c:forEach>
</body>
</html>