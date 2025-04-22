<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4>ex06-03_include2.jsp 페이지이다!</h4>
<p>
	ex06-03_include.jsp 페이지에 포함되어 있다.
	include 지시어와 다른 점은 하나의 서블릿에 생성되지 않아 변수 공유 불가<br>
	<% 
		// System.out.println(msg);
	%>
	<%--
	http://localhost:8080/jspStudy/ex06_pageContext/
	ex06-03_include.jsp?test=includetest
	 --%>
	<br>
	<%=
		request.getParameter("test")
	%>
</p>