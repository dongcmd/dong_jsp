<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--/webapp/member/loginForm.jsp --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<form action="login.jsp" method="post" name="f" onsubmit="return input_check(this)">
  <table><caption>로그인</caption>
    <tr><th>아이디</th><td><input type="text" name="id"></td></tr>
    <tr><th>비밀번호</th><td><input type="password" name="pass"></td></tr>
    <tr><td colspan="2"><button>로그인</button>
      <button type="button" onclick="location.href='joinForm.jsp'">회원가입</button>
      <button type="button" onclick="win_open('idForm')">아이디찾기</button>
      <button type="button" onclick="win_open('pwForm')">비밀번호찾기</button>
    </td></tr>
  </table></form>
  <%--
     문제
     1. input_check 함수
        - id, pass 파라미터값을 반드시 입력 받도록 추가
     2. win_open 함수
        idForm 파라미터 : 새로운 창에  idForm.jsp 페이지 열기
        pwForm 파라미터 : 새로운 창에  pwForm.jsp 페이지 열기
   --%>
   <script type="text/javascript">
      function input_check(a) {
    	  if(a.id.value.trim() == "") {
    		  alert("아이디를 입력하세요")
    		  a.id.focus();
    		  return false;
    	  }
    	  if(a.pass.value.trim() == "") {
    		  alert("비밀번호를 입력하세요")
    		  a.pass.focus();
    		  return false;
    	  }
    	  return true;
      }
      function win_open(page) {
    	  open(page+".jsp","","width=500,height=350,left=1350,top=250");
      }
   </script>
 </body></html>