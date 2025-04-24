<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/view/board/writeForm.jsp
	1. boardid 가 1인 경우, 관리자만 접근가능하게.
			list?boardid=1 로 이동시키기
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
</head>
<body>
	<form action="write" method="post" enctype="multipart/form-data" name="f">
		<h2 class="text-center">게시판 글쓰기 writeForm</h2>
		<table class="table">
			<tr><td>글쓴이</td>
					<td><input type="text" name="writer" class="form-control"></td></tr>
			<tr><td>비밀번호</td>
					<td><input type="password" name="pass" class="form-control"></td></tr>
			<tr><td>제목</td>
					<td><input type="text" name="title" class="form-control"></td></tr>
			<tr><td>내용</td>
					<td><textarea rows="15" name="content" class="form-control" id="summernote"></textarea>
			<tr><td>첨부파일</td>
					<td><input type="file" name="file1"></td></tr>
			<tr><td colspan="2" align="center">
					<a href="javascript:inputcheck()" class="btn btn-primary">[게시물 등록]</a></td></tr>
		</table>
	</form>
<script>
	function inputcheck() {
		f = document.f;
		if(f.writer.value=="") {
			alert("글쓴이 입력하세요");
			f.writer.focus();
			return;
		}
		if(f.pass.value=="") {
			alert("비번 입력하세요");
			f.pass.focus();
			return;
		}
		if(f.title.value=="") {
			alert("제목 입력하세요");
			f.title.focus();
			return;
		}
		f.submit(); // submit 발생 => form의 action 페이지로 요청
	}
</script>
<%-- summernote 관련 구현 --%>
<script>
	$(function() {
		$("#summernote").summernote({
			height : 300,
			callbacks : {
				// onImageUpload : 이미지 업로드 이벤트 발생
				// files : 배열. 다수의 이미지 업로드 가능
				onImageUpload : function(files) {
					for(let i = 0; i < files.length; i++) {
						sendFile(files[i]);
					}
				}
			}
		})
	})
	function sendFile(file) {
		let data = new FormData();
		// 폼 데이터를 수집하고, 전송 가능한 객체. 파일업로드에 사용.
		data.append("file", file);
		$.ajax({
			url : "${path}/uploadImage",
			type : "post",
			data : data,
			processData : false,
			contentType : false,
			success : function(url) {
				$("#summernote").summernote("insertImage", url);
			}, error : function(e) { alert("이미지 업로드 실패 " + e.status) }
		})
	}
</script>
</body>
</html>