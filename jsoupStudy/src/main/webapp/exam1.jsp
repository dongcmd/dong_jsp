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
<title>환율 정보</title>
<style>
	table { border-collapse : collapse; }
	table, td, th { border : 2px solid gray; }
</style>
</head>
<body>
<%
// EUR, JPY(100), CNH, USD 통화만 형태로 출력
	String url = "https://www.koreaexim.go.kr/wg/HPHKWG057M01";
	String line = "";
	Document doc = null;
	List<String> chk = Arrays.asList("EUR", "JPY(100)", "CNH", "USD");
	
	List<List<String>> trlist = new ArrayList<>();
	List<String> title = Arrays.asList("전신환 받을 때", "전신환 보낼 때", "매매기준율",
			"장부가격", "중개 매매기준율", "중개 장부가격");
	try {
		doc = Jsoup.connect(url).get(); // url 접속 후 DOM 트리 최상위 문서
		Elements trs = doc.select("tr");
		
			for(Element tr : trs) {
				Elements tds = tr.select("td");
			if(tds.size() > 0 && chk.contains(tds.get(0).text().trim())) {
				List<String> tdlist = new ArrayList<String>();
				for(Element td : tds) {
					boolean is = false;
					for(String c : chk) {
						if(td.text().equals(c)) is = true; 
					}
					tdlist.add(td.html());
				}
				trlist.add(tdlist);
			}
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