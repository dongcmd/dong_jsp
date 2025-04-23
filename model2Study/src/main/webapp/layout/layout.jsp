<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property="title" /></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style>
	.fakeimg {
	  height: 200px;
	  background: #aaa;
	}
	 .footer{
	          display:flex;
	          flex-direction:column;
	      }
	.footer_link{height:15%; display:flex; align-items:center;}
	.footer_link a{text-decoration:none; color:black; font-weight:bold; margin:15px;}
	.footer_company{height:70%;}
	.footer_company>ul{list-style:"- "; padding-left:15px;}
	.footer_copyright{height:15%; text-align:center}
	.footer>div{border-top:1px solid gray}
  </style>
	<sitemesh:write property="head" />
</head>
<body>

<div class="jumbotron text-center" style="margin-bottom:0">
  <h1>JSP model2Study</h1>
  <p></p> 
</div>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
   <div class="container-fluid">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="${path}/member/main" style="color:white">메인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${path}/board/list?boardid=1">공지사항</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${path}/board/list?boardid=2">자유게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${path}/member/info?id=${sessionScope.login}">회원정보</a>
      </li>
      <c:if test="${sessionScope.login == 'admin' }">
      <li class="nav-item">
        <a class="nav-link" href="${path}/member/list">회원목록</a>
      </li>
      </c:if>
	</ul>
  <!-- 오른쪽으로 보내고 싶은 영역 시작 -->
  <ul class="navbar-nav ms-auto">
      <li class="nav-item">
        <a class="nav-link" href="${path}/book/bookList">방명록</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${path}/book/bookForm">방명록 쓰기</a>
      </li>
      <c:if test="${sessionScope.login == null}">
      <li class="nav-item">
        <a class="nav-link" href="${path}/member/loginForm">로그인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${path}/member/joinForm">회원가입</a>
      </li>
      </c:if>
		  <c:if test="${sessionScope.login != null}">
		    <li class="nav-item ms-auto">
		      <a class="list-group-item list-group-item-success">${sessionScope.login}님 ㅎㅇ</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="${path}/member/logout">로그아웃</a>
		    </li>
		  </c:if>
	</ul>
  </div>
</nav>

<div class="container" style="margin-top:30px">
<div class="row">
	<div class="col" style="border:1px black solid">
		<canvas id="canvas1" style="width:100%"></canvas>
	</div>
	<div class="col" style="border:1px black solid">
		<canvas id="canvas2" style="width:100%"></canvas>
	</div>
</div>
	<sitemesh:write property="body" />
</div>

<footer class="footer">
<div>
<span id="si">
	<select name="si" onchange="getText('si')">
		<option value="">시/도 선택</option>
	</select></span>
<span id="gu">
	<select name="gu" onchange="getText('gu')">
		<option value="">구/군 선택</option>
	</select></span>
<span id="dong">
	<select name="dong">
		<option value="">동/리 선택</option>
	</select></span>
</div>

	<div class="footer_link">
	  <a href="">이용약관</a> |
	  <a href="">개인정보취급방침</a> |
	  <a href="">인재채용</a> |
	  <a href="">고객센터</a>
	</div>
  <div class="footer_company">
		<ul>
		    <li>상호명 : GooDee Academy</li>
		    <li>대표자 : 이승엽</li>
		    <li>전화 : 02-818-7950</li>
		    <li>개인정보책임자 : 주승재 / jsj@goodee.co.kr</li>
		    <li>(08505) 서울특별시 금천구 가산디지털2로 95
		        (가산동, km타워) 2층, 3층</li>
		</ul>
	</div>
	<div class="footer_copyright">
	    Copyright ⓒ GooDee Academy. All rights reserved.
	</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
function pieGraph() {
	$.ajax("${path}/ajax/graph1", {
		success : function(data) { pieGraphPrint(data); }
		, error : function(e) { alert("서버오류 " + e.status);
		}
	});
}
function pieGraphPrint(data) {
	let rows = JSON.parse(data);
	let writers = [];
	let datas = [];
	let colors = [];
	$.each(rows, function(i, item) {
		writers[i] = item.writer;
		datas[i] = item.cnt;
		colors[i] = randomColor();
	})
	let config = {
		type : "pie",
		data : {
			datasets : [{
				data : datas,
				backgroundColor : colors
			}],
			labels : writers
		},
		options : {
			 responsive : true,
			 legend : { position : "right" },
			 title : {
			 	display : true,
			 	text : "작성자별 게시물 수(최대 5명)",
			 	position : "bottom"
			 }
		}
	}
	let ctx = document.querySelector("#canvas1");
	new Chart(ctx,config);
}
function barGraph() {
	$.ajax("${path}/ajax/graph2", {
		success : function(data) { barGraphPrint(data); }
		, error : function(e) { alert("서버오류 " + e.status);
		}
	});
}
function barGraphPrint(data) {
	let rows = JSON.parse(data);
	let dates = [];
	let cnts = [];
	let colors = [];
	$.each(rows, function(i, item) {
		console.log(item)
		dates[i] = item.fmtdate;
		cnts[i] = item.cnt;
		colors[i]= randomColor();
	});
	let config = {
		type : "bar",
		data : {
			datasets : [{
				label : cnts,
				data : cnts,
				backgroundColor : colors
			}],
			labels : dates
		},
		options : {
			responsive : true,
			legend : { position : "right" },
			title : {
				display : true,
				text : "최근 7일간 게시물 수",
				position : "bottom"
			}
		}
	}
	let ctx = document.querySelector("#canvas2");
	new Chart(ctx, config);
}
function randomColorFactor() {
	return Math.round(Math.random() * 255)
}
function randomColor(opacity) {
	let c = "rgba(";
	for(i = 0; i < 3; i++)
		c += randomColorFactor() + ","
	c += (opacity || 1 ) + ")"
	return c
}
<%-- 캔버스1 : 작성자별 게시물 등록 건수 pie 그래프 가장 많이 작성한 작성자 5명
		 캔버스2 : 최근 작성일자별 게시물 등록 건수 막대그래프 : 최근 7일 --%>
</script>
<script>
	$(function() {
		pieGraph(); // 캔버스1 : 작성자별 게시물 등록 건수 pie 그래프 가장 많이 작성한 작성자 5명
		barGraph(); // 캔버스2 : 최근 작성일자별 게시물 등록 건수 막대그래프 : 최근 7일
		let divid;
		let si;
		$.ajax({
			url : "${path}/ajax/select",
			success : function(data) {
				let arr = JSON.parse(data);
				$.each(arr, function(i, item) {
					$("select[name=si]").append(function() {
						return "<option>" + item + "</option>"
					})
				})
			}, error : function(e) {
				alert("서버 오류 - " + e.status)
			}
		})
	})
</script>
<script>
	function getText(sigu) {
		const next = sigu=="si" ? "gu" : "dong";
		$("select[name=" + next + "]").empty();
		
		$.ajax( {
			url : "${path}/ajax/select",
			type : "post",
			data : {"sigu" : sigu,
"selected" : document.querySelector("select[name=" + sigu + "]").value},
			success : function(data) {
				let arr = JSON.parse(data);
				$("select[name=" + next + "]").append("<option>" + (next=="gu" ? "구를" : "동을") + " 고르세요</option>");
				$.each(arr, function(i, item) {
					$("select[name=" + next + "]").append(function() {
						return "<option>" + item + "</option>";
					})
				})
			}, error : function(e) {
				alert("서버 오류 ? " + e.status)
			}
		})
	}
</script>
</body>
</html>
