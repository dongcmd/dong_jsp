<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 사진 등록 pictureForm.jsp</title>
</head>
<body>
<table>
	<tr><td><img id="preview" src=""></td></tr>
	<tr><td>
		<form action="picture.jsp" method="post" enctype="multipart/form-data">
			<input type="file" name="picture" id="imageFile" accept="img/*">
			<input type="submit" value="사진등록">
		</form></td></tr>
</table>
<script> // 미리보기 구현
	let imageFile = document.querySelector("#imageFile");
	let preview = document.querySelector("#preview");
	imageFile.addEventListener("change", function(e) {
		let get_file = e.target.files;
		let reader = new FileReader(); // 파일을 읽기 위한 스트림 객체
		reader.onload = (
				function(Img) { // reader 객체에 파일이 로드되는 경우 이벤트 등록
					return function(e) {
						Img.src = e.target.result; // result : 선택된 파일의 value값(파일 이름)
					}
				})(preview);
		// if(get_file) { reader.readAsDataURL(get_file[0]);
		get_file && reader.readAsDataURL(get_file[0]);
	});
</script>	
</body>
</html>