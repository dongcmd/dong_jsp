<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키움 히어로즈 포수들</title>
</head>
<body>
<%
// https://heroesbaseball.co.kr/players/catcher/list.do
	String url = "https://heroesbaseball.co.kr/players/catcher/list.do";
	String preLink = "https://heroesbaseball.co.kr/";
	Document doc = null;
	List<Document> list = new ArrayList<>();
	
	try {
		doc = Jsoup.connect(url).get();
		Elements eles = doc.select("img.nail");
		for(Element el : eles) {
			el.attr("src", preLink + el.attr("src"));
			list.add(Jsoup.parse(el.outerHtml()));
		}
	} catch (IOException e) { e.printStackTrace(); }
	pageContext.setAttribute("list", list);
%>
<table>
<c:forEach items="${list}" var="imgs">
	${imgs}
</c:forEach>
</table>
</body>
</html>