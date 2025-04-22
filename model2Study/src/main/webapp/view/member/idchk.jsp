<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
	.able { color:green; font-size : 15px;}
	.disable { color:red; font-size : 20px;}
</style>
</head>
<body><div class="container">
<table class="table"><h3>중복검사 idchk?id=</h3>
	<tr><td>아이디</td><td>${param.id}</td></tr>
	<tr><td colspan="2"><div id="msg">${msg}</div></td></tr>
	<tr><td colspan="2"><button onclick="self.close()" class="btn btn-primary">닫기</button>
	</td></tr>
</table></div>
<script>
	if(${able}) {
		document.querySelector("#msg").className="able";
	} else {
		opener.document.f.id.value=""
		document.querySelector("#msg").setAttribute("class", "disable");
	}
</script></body></html>