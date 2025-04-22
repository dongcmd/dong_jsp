<%@page import="model.member.MemberDao"%>
<%@page import="model.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	1. 파라미터 저장 pass, chgpass
	2. 로그인한 사용자의 비밀번호 변경만 가능 => 로그인 검증
		로그아웃상태 : 로그인해라
		 => opener 창을 loginForm.jsp, 현재 창 닫기
	3. 비번 검증 : 현재 비번과 비교
			현재 비번과 다름 : 비번 오류 메세지
			 => 현재 페이지 passwordForm.jsp
	4. db에 비번 수정 boolean MemberDao.updatePass(id, chgpass)
		- 수정 성공 : (로그아웃, 재로그인해)
				=> opener 페이지는 info.jsp로 이동. 현재 닫기
		- 수정 실패 : 메세지 => 현재 닫기 
--%>
<%/*
boolean opener = true, selfclose = true;
String msg = null, url = null;
*/
	// 1. 파라미터 저장
	String pass = request.getParameter("pass");
	String chgpass = request.getParameter("chgpass");
	// 2. 로그인 검증
	String login = (String)session.getAttribute("login");
	MemberDao dao = new MemberDao(); 
	Member mem = dao.selectOne(login);
	if(login == null) {
%>
<script>
	alert("로그인 필요");
	opener.location.href="loginForm.jsp";
	self.close();
</script>
<% } else if(!pass.equals(mem.getPass())) {
%>
<script>
alert("비번 다름");
location.href = "passwordForm.jsp";
</script>
<% } else	if(dao.updatePass(login, chgpass)) {
%>
<script>
alert("비번 변경 완료");
opener.location.href="info.jsp?id=<%= login %>";
self.close();
</script>
<% } else {%>
<script>
alert("비번 변경 실패");
self.close();
</script>
<% } %>