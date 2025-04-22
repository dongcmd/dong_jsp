<%@page import="model.member.Member"%>
<%@page import="model.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	1. 2개의 파라미터 정보 변수 저장
	2. 로그인 정보 검증
		- 로그아웃상태 : 로그인 해라 => loginForm.jsp
		- 본인만 탈퇴가능(관리자는 제외) => main.jsp
		- 관리자 탈퇴 불가. 탈퇴 불가 메세지 => list.jsp
	3. 로그인 정보로 비번 검증
		- 비번 불일치 : 비번오류 => deleteForm.jsp
	4. 비번 일치시 db에서 id에 해당하는 회원정보 삭제
		boolean MemberDao.delete(id)
		탈퇴 성공 : 메세지 후 
			- 일반 : 로그아웃 => loginForm.jsp
			- 관리자는 : list.jsp
		탈퇴 실패 : 메세지 후
			일반 : main.jsp
			관리자 : list.jsp
--%>
<% // 1 파라미터 정보 변수 저장
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	// 2 로그인 정보 검증
	String login = (String)session.getAttribute("login");
	String msg = null;
	String url = null;
	if(login == null) { // 로그아웃
		msg = "로그인하셈";
		url = "loginForm.jsp";
	} else if(!login.equals("admin") && !id.equals(login)) {
		// 관리자도 아니고, 탈퇴 시도하는 계정 본인 아님
		msg = "본인만 탈퇴 가능";
		url = "main.jsp";
	} else if(id.equals("admin")) { // 관리자
		msg = "관리자 탈퇴 불가";
		url = "list.jsp";
	} else { // 정상접근
		MemberDao dao = new MemberDao();
		Member dbMem = dao.selectOne(login);
		if(pass.equals(dbMem.getPass())) { // 비번 맞음
			if(dao.delete(id)) { // 탈퇴 성공
				msg = id + "님 탈퇴 완료";
				if(login.equals("admin")) { // 관리자 로그인
					url = "list.jsp";
				} else { // 일반 로그인
						session.invalidate();
						url = "loginForm.jsp";
				}
			} else { // 탈퇴 실패
				msg = id + "님 탈퇴 실패";
				if(login.equals("admin")) { // 관리자 로그인
					url = "list.jsp";
				} else { // 일반 로그인
						url = "main.jsp";
				}
			}
		} else {
			// 비번 다름
			msg = "비번 틀림";
			url = "deleteForm.jsp?id=" + id;
		}
	}
	/*
	3. 로그인 정보로 비번 검증
		- 비번 불일치 : 비번오류 => deleteForm.jsp
	4. 비번 일치시 db에서 id에 해당하는 회원정보 삭제
		boolean MemberDao.delete(id)
		탈퇴 성공 : 메세지 후 
			- 일반 : 로그아웃 => loginForm.jsp
			- 관리자는 : list.jsp
		탈퇴 실패 : 메세지 후
			일반 : main.jsp
			관리자 : list.jsp
	*/
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>