<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/member/picture.jsp
	1. request 객체로 이미지 업로드 불가 => cos.jar
	2. 이미지 업로드 폴더 : 현재폴더/picture 설정
	3. opener 화면에 이미지 볼 수 있도록 결과 전달  >> JS
	4. 현재 화면 close															>> JS
--%>
<script>
/*
	opener : 현재 창을 open 한 window 객체 =>(현재) joinForm.jsp 페이지의 window 객체
 */
	img = opener.document.getElementById("pic"); // joinForm의 <img id="pic">
	img.src = "../picture/${fname}"; // img의 src 속성값 (이미지 보임)
	// <input type="hidden" name="picture" value="">
	/*
	BOM - window : 최상위 객체
					document : 문서 객체
						form : <form name="f">
							input : <input name="picture"> 
					location : 현재 페이지 url 저장
					history  : 현재 페이지의 과거~현재 url 정보 
	*/
	opener.document.f.picture.value = "${fname}";
	// self : 현재 페이지의 window 객체
	self.close();
</script>