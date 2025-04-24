<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 환율 정보
https://www.koreaexim.go.kr/wg/HPHKWG057M01
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수출입은행 환율 정보 조회</title>
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
	try {
		doc = Jsoup.connect(url).get(); // url 접속 후 DOM 트리 최상위 문서
		Elements e1 = doc.select("table"); // doc의 하위 태그 중 table 태그들 선택
		for(Element ele : e1) {
			String temp = ele.html();
			line += temp;
		}
	} catch(IOException e) {
		e.printStackTrace();
	}
%>
<table><%= line %></table>
</body>
</html>