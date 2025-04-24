<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환율 정보</title>
<style>
	table { border-collapse : collapse; }
	table, td, th { border : 2px solid gray; }
</style>
</head>
<body>
<%
	String url = "https://www.koreaexim.go.kr/wg/HPHKWG057M01";
	String line = "";
	Document doc = null;
	
	List<List<String>> trlist = new ArrayList<>();
	List<String> title = Arrays.asList("전신환 받을 때", "전신환 보낼 때", "매매기준율",
			"장부가격", "중개 매매기준율", "중개 장부가격");
	try {
		doc = Jsoup.connect(url).get(); // url 접속 후 DOM 트리 최상위 문서
		Elements trs = doc.select("tr"); 
		for(Element tr : trs) {
			List<String> tdlist = new ArrayList<String>();
			Elements tds = tr.select("td");
			for(Element td : tds) {
				tdlist.add(td.html());
			}
			trlist.add(tdlist);
		}
	} catch(IOException e) {
		e.printStackTrace();
	}
	pageContext.setAttribute("trlist", trlist);
	pageContext.setAttribute("title", title);
%>
<table>
<c:forEach items="${trlist}" var="tdlist">
	<c:forEach items="${tdlist}" var="td" varStatus="stat">
		<c:choose>
			<c:when test="${stat.index % 8 == 0}">
				<tr><td rowspan="6">${td}</td>
			</c:when>
			<c:when test="${stat.index % 8 == 1}">
				<td rowspan="6">${td}</td>
			</c:when>
			<c:when test="${stat.index % 8 == 2}">
				<td rowspan="6">${td}</td>
			</c:when>
			<c:otherwise>
				<tr><td>${title[stat.index -2]}</td><td>${td}</td></tr>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:forEach>
</table>
</body>
</html>