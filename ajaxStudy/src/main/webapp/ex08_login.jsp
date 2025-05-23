<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- db 접근 --%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%-- db Connection 객체 --%>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/gdjdb"
	user="gduser" password="1234" />
<sql:query var="rs" dataSource="${conn}">
	select * from member where id = ? and pass = ?
	<sql:param>${param.id}</sql:param>
	<sql:param>${param.pass}</sql:param>
</sql:query>
<c:if test="${!empty rs.rows}">
	<h1>반갑. ${rs.rows[0].name}님</h1>
</c:if>
<c:if test="${empty rs.rows}">
	<h1><font color="red">아이디 또는 비번 틀렸다</font></h1>
</c:if>