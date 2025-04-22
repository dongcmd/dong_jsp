<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<h3>${ sessionScope.login }님이 로그인 하셨습니다. main</h3>
<h3><a href="logout">로그아웃</a></h3>
<h3><a href="info?id=${sessionScope.login}">회원정보보기</a></h3>
<%-- 관리자로 로그인 된경우 : 회원 목록 조회 --%>
<c:if test="${ sessionScope.login.equals('admin') }">
 <h3><a href="list">회원목록보기</a></h3>
</c:if>
</body>
</html>