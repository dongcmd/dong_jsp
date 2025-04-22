<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 수정 화면</title>
</head>
<body>
<form action="update" method="post" enctype="multipart/form-data" name="f">
	<input type="hidden" name="num" value="${b.num}">
	<input type="hidden" name="file2" value="${b.file1}">
	<div class="container">
		<h2 align="center">${(boardid=='1') ? "공지사항" : "자유게시판"}
		 	updateForm?num=${b.num}</h2>
		<table class="table">
			<tr><th>글쓴이</th>
					<td><input type="text" name="writer" value="${b.writer}"></td></tr>
			<tr><th>비번</th>
					<td><input type="password" name="pass"></td></tr>
			<tr><th>제목</th>
					<td><input type="text" name="title" value="${b.title}"></td></tr>
			<tr><th>내용</th>
					<td><textarea name="content" rows="10" id="content">${b.content}</textarea></tr>
			<tr><td>첨부파일</td><td style="text-laign:left">
			<c:if test="${!empty b.file1}">
				<div id="file_desc">${b.file1}
					<a href="javascript:file_delete()">[첨부파일 삭제]</a></div>
			</c:if>
				<input type="file" name="file1"></td></tr>
			<tr><td colspan="2">
			<a href="javascript:document.f.submit()">[게시물 수정]</a></td></tr>
		</table>
	</div>
</form>
<script>
	function file_delete() {
		document.f.file2.value="";
		file_desc.style.display="none";
	}
</script>
</body>
</html>