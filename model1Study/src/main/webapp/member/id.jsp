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
<% // 1
	String email = request.getParameter("email");
	String tel= request.getParameter("tel");
	// 2
	String id = new MemberDao().idSearch(email, tel);
	if(id == null) {
%>
<script>
	alert("찾는 id가 없습니다");
	location.href="idForm.jsp";
</script>
<% } else { %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 id.jsp</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<table>
	<tr><th>아이디</th><td><%= id.substring(0, id.length()-2) + "**" %></td></tr>
	<tr><td colspan="2">
		<input type="button" value="아이디전송"
			onclick="idSend('<%= id.substring(0, id.length()-2) %>')">
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
<% } %>