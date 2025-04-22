<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>out 내장 객체</title>
</head>
<body>
<h3>out 객체는 response 객체의 출력버퍼에 데이터를 출력할 수 있는 출력 스트림 객체임</h3>
<%
	int sum = 0;
	for(int i = 1; i <= 10; i++) {
		sum += i;
%>
1 ~ <%= i %> 까지의 부분합 : <%= sum %><br>
<% } %>
1 ~ 10 까지의 합 : <%= sum %>
<hr>
<%
	sum = 0;
	for(int i = 1; i <= 10; i++) {
		sum += i;
		out.println(String.format("1 ~ %d 까지의 부분합 : %d<br>", i, sum));
	}
	out.println("1 ~ 10까지의 합 : " + sum);
%>

</body>
</html>