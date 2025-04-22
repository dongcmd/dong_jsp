<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int max = Integer.parseInt(request.getParameter("num"));
int result = 0;
for(int i = 1; i <= max; i++) {
	switch(request.getParameter("test")) {
	case "0" :
		result += i; break;
	case "1" :
		if(i%2==0) result += i; break;
	case "2" :
		if(i%2==1) result += i; break;
	}
}
out.print(result);
%>