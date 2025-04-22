<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex12-01_uploadForm.jsp 파일업로드</title>
</head>
<body>
<div>
<%--
	enctype="multipart/form-data" : 파일 업로드시 선택된 파일의 내용도 함께 서버로 전송하도록 설정
							method="post" 꼭 post 방식으로 설정해야 함.
	=> 파일 업로드시 <form enctype="multipart/form-data" method="post" ...>
	=> 서버에서는 request를 이용해 파라미터값을 가져올 수 없다. 
--%>
<%--
	ex12-01_upload.jsp 요청시 enctype="multipart/form-data"인 경우,
		request 객체는 파라미터 처리 못함
--%>
	<form id="frm_upload" action="ex12-01_upload.jsp"
				method="post" enctype="multipart/form-data">
		<div>
			<label for="uploader">작성자</label>
			<input type="text" id="uploader" name="uploader">
		</div>
		<div>
			<label for="filename">파일첨부</label>
			<input type="file" id="filename" name="filename">
		</div>
		<div>
			<button>첨부하기</button> 
			<input type="reset" value="다시작성">
		</div>
		<%-- 버튼의 타입은 submit, button, reset 3가지 --%>
	</form></div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		$("#filename").on("change", function() {
			let filename = $(this).val();
			let extname = filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
			let acceptList = ["jpg", "jpeg", "png", "gif", "tif"];
			if($.inArray(extname, acceptList) == -1) {
				alert("이미지만 첨부 가능");
				$(this).val("");
				return;
				}
		})
	</script>
</body>
</html>