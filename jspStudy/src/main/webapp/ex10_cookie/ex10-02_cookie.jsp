<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex10-02_cookie.jsp</title>
</head>
<body>
<%
	String name = "";
	String value = "";
	Cookie[] cookies = request.getCookies();
	for(Cookie c : cookies) {
		if(c.getName().equals("name")) {
			name = c.getName();
			value = c.getValue();
		}
	}
%>
<h2>ex10-02_cookie.jsp<br><br>
		쿠키 이름 : <%= name %><br>
		쿠키 값 : <%= value %><br>
</h2>
</body>
</html>