<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- webapp/member/ex13_EL/ex13-02_EL.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL에서 연산자 사용하기</title>
</head>
<body>
<h3>
	\${5+7} = ${5+7}<br>
	\${5-7} = ${5-7}<br>
	\${5*7} = ${5*7}<br>
	\${5/7} = ${5/7}<br>
	\${5 div 7} = ${5 div 7}<br>
	\${5%7} = ${5%7}<br>
	\${5 mod 7} = ${5 mod 7}<br>
	\${5 == 7} = ${5 == 7}<br>
	\${5 eq 7} = ${5 eq 7}<br>
	\${5 != 7} = ${5 != 7}<br>
	\${5 ne 7} = ${5 ne 7}<br>
	\${5 >= 7} = ${5 >= 7}<br>
	\${5 ge 7} = ${5 ge 7}<br>
	\${5 < 7} = ${5 < 7}<br>
	\${5 lt 7} = ${5 lt 7}<br>
	\${"상수"} = ${"상수"}<br>
</h3>
</body>
</html>