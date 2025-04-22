3<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 작성</title>
<script type="text/javascript">
function input_check(f) {
	       if (f.googleid.value.trim() == "") {
        alert("구글 아이디를 입력하세요.");
        f.googleid.focus();
        return false;
    }
    if (f.googlepw.value.trim() == "") {
        alert("내용을 입력하세요");
        f.googlepw.focus();
        return false;
    }
    return true;
}
</script>
</head>
<body>
<div class="container">
    <h2>메일 작성 mailForm</h2>
    <form name="form1" method="post" action="mailSend" onsubmit="return inputchk(this)">
        <table class ="table">
            <tr>
                <th>보내는 사람</th>
                <td><input type="text" name="googleid" class="form-control" value="ddiscom1"></td>
            </tr>
            <tr>
                <th>구글 비밀번호</th>
                <td><input type="password" name="googlepw" class="form-control" value="kgdy lxkn mhsw onxp"></td>
            </tr>
            <tr>
                <th>받는사람</th>
                <td><input type="text" name="recipient" class="form-control"
	                value=
	                "<c:forEach items="${list}" var="m" >${m.name} &lt;${m.email}&gt;,</c:forEach>"></td>
	                <%-- 이름1 <이메일1>, 이름2 <이메일2>, --%>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" class="form-control"> </td>
            </tr>
            <tr>
                <th>메세지 형식</th>
                <td><select name ="mtype" class="form-control">
                    <option value="text/html;charset=UTF-8">HTML</option>
                    <option value="text/plain;charset=UTF-8">TEXT</option>
                </select></td></tr>
            <tr>
                <td colspan="2">
                <textarea id="summernote" name="content" class="form-control" cols="40" rows="10"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="text-right">
                    <button type="reset" class="btn btn-primary"> 초기화</button>
                    <button type="submit" class="btn btn-dark">전송</button>
                </td>
        </table>
    </form>
</body>
</html>