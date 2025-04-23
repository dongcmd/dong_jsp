<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/gdjdb" user="gduser" password="1234" />
<sql:query var="rs" dataSource="${conn }">
select num, title, readcnt from board
	group by num
	order by 3 desc
</sql:query>
<div style="width:85%"><canvas id="canvas"></canvas></div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
<script>
let randomColorFactor = function() {
	return Math.round(Math.random() * 255)
}
let randomColor = function(opacity) {
	let c = "rgba(";
	for(i = 0; i < 3; i++)
		c += randomColorFactor() + ","
	c += (opacity || 1 ) + ")"
	return c
}

let config = {
	type : "doughnut", //doughnut
	data : {
		datasets : [{
			data : [<c:forEach items="${rs.rows}" var="m">
								"${m.readcnt}", </c:forEach>
			],
			backgroundColor : [<c:forEach items="${rs.rows}" var="m">
							randomColor(), </c:forEach>
			]
		}],
		labels : [<c:forEach items="${rs.rows}" var="m">
					"${m.title}",</c:forEach>
		]	
	},
	options : {
		responsive : true,
		legend : {position : "right"},
		title : {
			display : true,
			text : "Dd",
			position : "bottom"
		},
		animation : {animateScale:true, animateRotate:true}
	}
}

window.onload = function() {
	const ctx = document.querySelector("#canvas");
	new Chart(ctx, config);
}
</script>
</body>
</html>