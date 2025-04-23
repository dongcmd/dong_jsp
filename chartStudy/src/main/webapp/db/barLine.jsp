<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성자별 건수 그래프</title>
</head>
<body>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/gdjdb" user="gduser" password="1234" />
<sql:query var="rs" dataSource="${conn }">
	select writer, count(*) cnt from board
		group by writer
		order by 2 desc
</sql:query>
<div style="width:75%"><canvas id="canvas"></canvas></div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
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
	labels :
		[
			<c:forEach items="${rs.rows}" var="m">"${m.writer}", </c:forEach>
		],
		datasets : [
			{
				type : "line",
				borderWidth : 2,
				borderColor : //randomColor(1),
					[
						<c:forEach items="${rs.rows}" var="m">randomColor(), </c:forEach>
					],
					label : "건수",
					fill : false,
					data :
						[
							<c:forEach items="${rs.rows}" var="m">Math.random(), </c:forEach>
						]
			},
			{
				type : "bar",
				label : "건수",
				backgroundColor :
					[
						<c:forEach items="${rs.rows}" var="m">randomColor(), </c:forEach>
					],
				data :
					[
						<c:forEach items="${rs.rows}" var="m">Math.random(), </c:forEach>
					]
			}
		]
}
window.onload = function() {
	let ctx = document.querySelector("#canvas");
	new Chart(ctx, {
		type : "bar",
		data : chartData,
		options : {
			responsive : true,
			title : { display: true, text : "작성자별 게시판 등록 건수"},
			legend : {display : false},
			scales : {
				xAxes : [
					{
						display : true,
						scaleLabel : {
							display : true,
							labelString : "작성자"
						}
					}],
				yAxes : [
					{
						display : true,
						scaleLabel : {
							display : true,
							labelString : "게시물 수"
						}
					}]
			}
		}
	})
}
</script>
</body>
</html>