<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/member/pwForm.jsp
	1. 비번찾기 버튼 클릭시
			3개의 값을 모두 입력해야 pw.jsp로 넘어가도록 Js 추가
--%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<link rel="stylesheet" href="../css/main.css">
</head><body><h3>비밀번호찾기</h3>
<form action="pw.jsp" method="post" onsubmit="return input_check(this)">
  <table>
     <tr><th>아이디</th><td><input type="text" name="id"></td></tr>
     <tr><th>이메일<br>example@a.b</th><td><input type="text" name="email"></td></tr>
     <tr><th>전화번호</th><td><input type="text" name="tel"></td></tr>
     <tr><td colspan="2"><input type="submit" value="비밀번호찾기"></td></tr>
  </table>

<script>
	function input_check(f) {
		if(f.id.value.trim() == "") {
			alert("아이디 입력하셈");
			f.id.focus();
			return false;
		}
		if(!isValidEmail(f.email.value.trim())) {
			alert("이메일 형식 아님");
			f.email.focus();
			return false;
		}
		if(!isValidTel(f.tel.value.trim())) {
			alert("전번 형식 아님");
			f.tel.focus();
			return false;
		}
	}
	// 정규식을 이용한 이메일, 전번 형식 검증
	function isValidEmail(email) {
		const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-z0-9.-]+\.[a-zA-z]+$/;
		return regex.test(email);
	}
	function isValidTel(tel) {
		const regex = /^(02|01[016789])-?\d{3,4}-?\d{4}$/;
		return regex.test(tel);
	}
</script>
</form></body></html>