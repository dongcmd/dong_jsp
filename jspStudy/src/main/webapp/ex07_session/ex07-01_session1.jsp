<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session 객체 예제</title>
</head>
<body>
	<%
	// session 유지 시간 설정 : 10초. 톰캣의 기본 sessoin 유지시간은 30분
	// session이 최종 사용 후 10초가 지나면 기존 session 만료
		session.setMaxInactiveInterval(10);
	%>
	<h3>session 정보 : 브라우저별로 session이 할당됨.<br>
		주요기능 : 클라이언트의 정보 저장</h3>
		isNew() : <%= session.isNew() %><br> <%-- session이 새 객체인지 확인 --%>
		생성시간 : : <%= session.getCreationTime() %><br>
		최종접속시간 : <%= session.getLastAccessedTime() %><br>
		<%-- session의 고유 ID값. session 객체 마다 ID값이 다르다. --%>
		session id : <%= session.getId() %><br>
</body>
</html>