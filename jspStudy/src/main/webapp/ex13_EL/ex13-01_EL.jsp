<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String tel = "010-1111-2222";
	pageContext.setAttribute("tel", tel);
	//pageContext.setAttribute("test", "pageContext의 test");
	//request.setAttribute("test", "request의 test");
	//session.setAttribute("test", "session의 test");
	//application.setAttribute("test", "application의 test");
	
	//session.removeAttribute("test");
	application.removeAttribute("test");
	String name = "홍길동";
%>
<h3>JSP의 스크립트를 이용하여 파라미터와 속성값 출력하기</h3>
pageContext.getAttribute("tel") : <%= pageContext.getAttribute("tel") %><br>

pageContext.getAttribute("test") : <%= pageContext.getAttribute("test") %><br>
request.getAttribute("test") : <%= request.getAttribute("test") %><br>
session.getAttribute("test") : <%= session.getAttribute("test") %><br>
application.getAttribute("test") : <%= application.getAttribute("test") %><br>
name 변수값 : <%=name %><br>
id 파라미터 : <%= request.getParameter("id") %><br>
없는 속성 : <%= request.getAttribute("noattr") %><br>
없는 파라미터 : <%= request.getParameter("noparam") %><br>

<h3>JSP의 EL을 이용하여 파라미터와 속성값 출력하기</h3>
\${ pageScope.tel } : ${ pageScope.tel }<br>

\${ pageScope.test } : ${ pageScope.test }<br>
\${ requestScope.test } : ${ requestScope.test }<br>
\${ sessionScope.test } : ${ sessionScope.test }<br>
\${ applicationScope.test } : ${ applicationScope.test }<br>
name 변수값 : 출력 방법 없음<br> 
id 파라미터 : ${ param.id }<br>
없는 속성 : ${ requestScope.noattr }<br>
없는 파라미터 : ${ param.noparam }<br>

<h3>영역을 표시하여 속성 출력</h3>
\${ test } : ${ test }<br>
\${ pageScope.test } : ${ pageScope.test }<br>
\${ requestScope.test } : ${ requestScope.test }<br>
\${ sessionScope.test } : ${ sessionScope.test }<br>
\${ applicationScope.test } : ${ applicationScope.test }<br>
<%--
	EL에선 null을 ""(공란)으로 표현

	${ test } : 영역 담당 객체의 test 속성값 출력
		우선 순위 (상위 순위가 없으면 다음 순위)
			1. page 영역의 pageScope.test 속성값
			2. request 영역의 requestScope.test 속성값
			3. session 영역의 sessionScope.test 속성값
			4. application 영역의 applicationScope.test 속성값
			5. "" (공란)
			
	${ 영역객체.test } : 영역 객체의 test 속성값
--%>
</body>
</html>