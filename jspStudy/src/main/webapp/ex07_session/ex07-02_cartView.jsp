<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/ex07_session/ex07-02_cartView.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 보기</title>
</head>
<body>
	<%
		List<String> cart = (List<String>)session.getAttribute("cart");
		if(cart == null || cart.size() == 0) {
	%>
	<h3>장바구니에 상품이 없다</h3>
	<% } else { %>
	<h3>장바구니 상품</h3>
	<% for(String p : cart) { %>
		<h4><%= p %></h4>
		<% } 
		}
		session.removeAttribute("cart");  
		%>
</body>
</html>