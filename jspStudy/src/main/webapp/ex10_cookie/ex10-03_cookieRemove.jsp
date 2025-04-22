<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex10-03_cookieRemove.jsp</title>
</head>
<body>
<h2>ex10-03_cookieRemove.jsp<br><br>
</h2>
<%
	Cookie cookie = new Cookie("name", ""); // 삭제할 쿠키의 이름으로 쿠키 생성
	cookie.setMaxAge(0); // 해당 쿠키의 유효 시간을 0으로 설정
	response.addCookie(cookie); // 클라이언트 전송
	/*
		유효기간이 종료된 쿠키를 받은 클라이언트는 쿠키 저장소에서 해당 쿠키를 제거
	*/
%>
<h2>쿠키가 삭제되었슴다--;</h2>
<a href="ex10-02_cookie.jsp">쿠키 조회하기</a>
</body>
</html>