<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%--
최근 7일간 게시물 작성 건수 출력
선 막대 그래프 출력
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
</head>
<body>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/gdjdb" user="gduser" password="1234" />
<sql:query var="rs" dataSource="${conn }">
	select date_format(regdate, "%Y-%m-%d") date, count(*) cnt from board
		group by date
		order by 1 desc
		limit 0, 7
</sql:query>
<div style="width:75%"><canvas id="canvas"></canvas></div>
<script>
let randomColorFactor = function() {
	return Math.round(Math.random() * 255)
}
let randomColor = function(opacity) {
	let c = "rgba(";
	for(i = 0; i < 3; i++)
		c += randomColorFactor() + ","
	c += (opacity || Math.random() ) + ")"
	return c
}
let chartData = {
	labels : // 등록날짜
}
</script>

</body>
</html>