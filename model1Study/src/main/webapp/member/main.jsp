<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/member/main.jsp
  1. 로그인 여부 검증 => main.jsp 페이지는 로그인상태에서만 조회가 되어야 함.
     현재 로그인 상태 : 현재 화면 출력
     로그아웃 상태 : 로그인이 필요한 화면입니다. 메세지 출력 후 loginForm.jsp 페이지로 이동
--%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<body>
<% String login = (String)session.getAttribute("login");
   if (login != null) {
 %>
<h3><%=login %>님이 로그인 하셨습니다.</h3>
<h3><a href="logout.jsp">로그아웃</a></h3>
<h3><a href="info.jsp?id=<%=login%>">회원정보보기</a></h3>
<%-- 관리자로 로그인 된경우 : 회원 목록 조회 --%>
<% if(login.equals("admin")) {%>
 <h3><a href="list.jsp">회원목록보기</a></h3>
<% } %>
<% }  else { //로그 아웃상태. session 에 login 속성값이 없는 경우 %>
<script type="text/javascript">
   alert("로그인이 필요한 화면입니다.");
   location.href="loginForm.jsp";
</script> 
<% } %>
</body>
</html>