<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/member/deleteForm.jsp--%>
<!DOCTYPE html>
<html>
<head>  
<meta charset="UTF-8">
<title>탈퇴화면</title>
<link rel="stylesheet" href="../css/main.css" >
</head>
<body>
<form action="delete" method="post" onsubmit="return input_check(this)">
	<input type="hidden" name="id" value="${ param.id }">
	<table><h3>탈퇴화면 deleteForm?id=</h3>
		<tr><th>비밀번호</th>
		<td><input type="password" name="pass"></td></tr>
		<tr><td colspan="2"><button>탈퇴하기</button>
		</td></tr>
	</table>
</form>
<script>
 function input_check(f) {	
	 if(f.pass.value == "") {
		alert("비번입력");
		f.pass.focus();
		return false;
	 }
	 return true;
	}
 </script>
</body>
</html>
