<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>게시글 삭제 deleteForm?num=${param.num}</h2>
<form action="delete" method="post">
	<input type="hidden" name="num" value="${param.num}">
	<label for="pw">Password : </label>
	<input type="password" name="pass" id="pw">
	<button type="submit" class="btn btn-danger">게시물 삭제</button>
</form>
</body>
</html>