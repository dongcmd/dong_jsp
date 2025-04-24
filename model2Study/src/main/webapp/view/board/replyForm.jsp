<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>replyForm</title>
</head>
<body>
<form action="reply" method="post" name="f">
	<input type="hidden" name="num" value="${b.num}">
	<input type="hidden" name="grp" value="${b.grp}">
	<input type="hidden" name="grplevel" value="${b.grplevel}">
	<input type="hidden" name="grpstep" value="${b.grpstep}">
	<input type="hidden" name="boardid" value="${b.boardid}">
	<div class="container">
		<h2 align="center">${(b.boardid=='1') ? "공지사항" : "자유게시판"}
		replyForm?num=${b.num}</h2>
		<table class="table">
			<tr><th>글쓴이</th>
					<td><input type="text" name="writer"></td></tr>
			<tr><th>비번</th>
					<td><input type="password" name="pass"></td></tr>
			<tr><th>제목</th>
					<td><input type="text" name="title" value="RE:${b.title}"></td></tr>
			<tr><th>내용</th>
					<td><textarea name="content" rows="10" id="summernote"></textarea></tr>
			<tr><td colspan="2" align="center">
				<a href="javascript:document.f.submit()">[답변글 등록]</a></td></tr>
		</table>
	</div>
</form>
<script>
	$(function() {
		$("#summernote").summernote({
			height : 300,
			callbacks : {
					onImageUpload : function(files) {
						for(let i = 0;i < files.length; i++) {
							sendFile(files[i]);
					}
			}
			}
		})
	})
	function sendFile(file) {
		let data = new FormData();
		data.append("file", file);
		$.ajax({
			url : "${path}/uploadImage",
			type : "post",
			data : data,
			processData : false,
			contentType : false,
			success : function(url) {
				$("#summernote").summernote("insertImage", url);
			}, error : function(e) { alert("이미지업로드 실패 " + e.status); }
		})
	}
</script>
</body>
</html>