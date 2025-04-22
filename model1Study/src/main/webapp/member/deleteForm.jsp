<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/member/deleteForm.jsp
	1. id 파라미터 저장
	2. 로그인 정보 검증
			- 로그아웃 상태 : 로그인하셈. loginForm.jsp 이동
			- 본인 탈퇴 여부 검증 : 관리자 제외하고 본인만 탈퇴 가능 메세지
				본인이 아닌 경우, 메세지 출력 후 main.jsp로 페이지 이동
--%>
<%
	String id = request.getParameter("id");
	String login = (String)session.getAttribute("login");
	if(login == null) { %>
		<script>
			alert("로그인 하셈");
			location.href="loginForm.jsp"
		</script>
<%
	} else if(!id.equals(login) && !login.equals("admin") ) { %>
		<script>
			alert("본인만 탈퇴 가능");
			location.href="main.jsp"
		</script>
<% } else { %>
<!DOCTYPE html>
<html>
<head>  
<meta charset="UTF-8">
<title>탈퇴화면</title>
<link rel="stylesheet" href="../css/main.css" >
</head>
<body>
<form action="delete.jsp" method="post" onsubmit="return input_check(this)">
	<input type="hidden" name="id" value="<%=id%>">
	<table><caption>회원 비번 입력</caption>
		<tr><th>비밀번호</th>
		<td><input type="password" name="pass"></td></tr>
		<tr><td colspan="2"><button>탈퇴하기</button>
		</td></tr>
	</table>
</form>
</body>
</html>
<% } %>