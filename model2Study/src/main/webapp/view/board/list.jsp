<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- webapp/view/board/list.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
	1. 첨부파일이 있으면 제목 앞에 표시하기
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
</head>
<body>
<h2>${boardName} list?boardid=${boardid}</h2>
<form action="list?boardid=${boaredid}" method="post" name="sf">
	<input type="hidden" name="pageNum" value="1">
	<input type="hidden" name="boardid" value="${param.boardid}">
	<select name="column">
		<option value="">선택하세요</option>
		<option value="title">제목</option>
		<option value="writer">작성자</option>
		<option value="content">내용</option>
		<option value="title,writer">제목+작성자</option>
		<option value="title,content">제목+내용</option>
		<option value="writer,content">작성자+내용</option>
		<option value="title,writer,content">제목+작성자+내용</option>
	</select>
		<script>document.sf.column.value='${param.column}'</script>
		<input placeholder="Search" name="find" value="${param.find}">
		<button class="btn btn-primary" type="submit">Search</button>
</form>
<table class="table">
	<c:if test="${boardcount == 0}">
		<tr><td colspan="5">등록된 게시글이 없다.</td></tr>
	</c:if>
	<c:if test="${boardcount > 0}">
		<tr><td colspan="5" style="text-align:right">글 개수 : ${boardcount}</td></tr>
		<tr><td width="8%">번호</td><th width="50%">제목</th>
				<td width="14%">작성자</td><th width="17%">등록일</th>
				<td width="11%">조회수</td></tr>
		<c:forEach var="b" items="${list}">
			<tr><td>${boardnum}</td> <%-- 번호 --%>
			<c:set var="boardnum" value="${boardnum-1}"/>
					<td style="text-align: left">
						<c:if test="${!empty b.file1}"> <%-- 첨부파일 표시 --%>
							<a style="color:red" href="../upload/board/${b.file1}">♥</a>
						</c:if>
						<c:if test="${empty b.file1}"><a>♡</a></c:if>
					<%-- 답글인 경우 level 만큼 공백 --%>
					<c:if test="${b.grplevel > 0}">
						<c:forEach var="i" begin="2" end="${b.grplevel}">
							&ensp;&ensp;
						</c:forEach>┗
					</c:if>
					<a href="info?num=${b.num}">${b.title}</a></td>
					<td>${b.writer}</td>
					<%-- 오늘 등록 HH:mm:ss
					 		 이외 등록 : yyyy-MM-dd HH:mm:ss 변경 --%>
					<fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd" var="rdate"/>
					<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="tdate"/>
					<td>
							<c:if test="${rdate == tdate }">
								<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss" /></td>
							</c:if>
							<c:if test="${rdate != tdate }">
								<fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd" /></td>
							</c:if>
					<td>${b.readcnt}</td></tr>
		</c:forEach>
	<%-- 페이지 처리하기 --%>
		<tr><td colspan="5" align="center">
				<c:if test="${pageNum <= 1}">[이전]</c:if>
				<c:if test="${pageNum > 1}">
					<a href="javascript:listsubmit(${pageNum-1})">[이전]</a>
				</c:if>
				<c:forEach var="a" begin="${startpage}" end="${endpage}">
					<c:if test="${a == pageNum}">[${a}]</c:if>
					<c:if test="${a != pageNum}">
						<a href="javascript:listsubmit(${a})">[${a}]</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum >= maxpage}">[다음]</c:if>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:listsubmit(${pageNum+1})">[다음]</a>
				</c:if>
		</td></tr>
	</c:if>
	<c:if test="${boardid != 1 || sessionScope.login == 'admin'}">
	<tr><td colspan="5" style="text-align:right">
			<p align="right"><a href="writeForm">[글쓰기]</a></p>
	</td></tr>
	</c:if>
</table>
<script>
	function listsubmit(page) {
		f = document.sf;
		f.pageNum.value= page;
		f.submit();
	}
</script>
</body>
</html>