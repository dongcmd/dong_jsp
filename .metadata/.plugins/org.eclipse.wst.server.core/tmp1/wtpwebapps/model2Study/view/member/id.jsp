<%@page import="model.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/member/id.jsp
	1. 파라미터 값 email, tel 저장
	2. db에서 두개의 파라미터를 이용해 id 값 리턴 함수 필요
		String MemberDao.idSearch(email, tel)
	3. id 존재 : 뒤 2자 **로 출력
							아이디 전송 버튼 누르면 opener 창에 id 입력칸에 전달
							id.jsp 닫기
			미존재 : id없다 => idForm.jsp 이동
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<table class="table"><h3>아이디 찾기 id</h3>
	<tr><th>아이디</th><td>${requestScope.id}**</td></tr>
	<tr><td colspan="2">
		<input type="button" value="아이디전송"
			onclick="idSend('${requestScope.id}')">
	</td></tr>
</table>
<script type="text/javascript">
	function idSend(id) {
		opener.document.f.id.value = id;
		self.close();	
	}
</script>
</body>
</html>