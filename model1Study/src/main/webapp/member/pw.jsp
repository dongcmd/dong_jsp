<%@page import="model.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/member/pw.jsp
  1. 파라미터 저장.
  2. db에서 id,email과 tel 을 이용하여 pass값을 리턴
       pass = MemberDao.pwSearch(id,email,tel)
  3. 비밀번호 검증 
     비밀번호 찾은 경우 :화면에 앞 두자리는 **로 표시하여 화면에 출력. 닫기버튼 클릭시 
                     현재 화면 닫기
     비밀번호 못찾은 경우: 정보에 맞는 비밀번호를 찾을 수 없습니다.  메세지 출력후
                     현재 페이지를 pwForm.jsp로 페이지 이동. 
--%>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	String pass = new MemberDao().pwSearch(id, email, tel);
	if(pass == null) {
%>
<script type="text/javascript">
alert("정보에 맞는 비밀번호 못찾음");
location.href="pwForm.jsp";
</script>
<% } else { %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<link rel="stylesheet" href="../css/main.css">
</head><body>
<%--
	<h3>비밀번호 :<%=pass.substring(2, pass.length()) %></h3>
 --%>
 <h3>비번 : <%= pass %></h3>
</form></body></html>
<% } %>