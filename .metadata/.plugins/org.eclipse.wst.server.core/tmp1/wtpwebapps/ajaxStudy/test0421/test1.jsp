<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nums = "";
for(int i = 0; i < 10; i++) {
	nums += (int)(Math.random()*100);
	if(i != 9) nums += ",";
}
out.print(nums);
%>