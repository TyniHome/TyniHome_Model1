<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
if(!document.deleteFr.pw.value){
	alert("비밀번호를 입력해주세요.");
	document.deleteFr.pw.focus();
	return false;
}
</script>
</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
<%
String id = (String)session.getAttribute("id");
if (id==null) {
	response.sendRedirect("loginForm.jsp");
}
%>
<fieldset class="submitfield">
<legend>회원탈퇴</legend>
<form action="deletePro.jsp" method="post" name="deleteFr" onsubmit="return valCk();">
<table>
<tr>
<td colspan="2"><input type="text" class="inputbox" name="id"  value="<%=id %>" readonly></td>
</tr>
<tr>
<td colspan="2"><input type="password" class="inputbox" name="pw" placeholder="비밀번호"></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="탈퇴" class="button" id="subbutton"><input type="reset" value="취소" class="button" id="subbutton"></td>
</tr>
</table>
</form>
</fieldset>

	</div>
	<!-- 푸터파일 -->
	<jsp:include page="../include/bottom.jsp"/>
	<!-- 푸터파일 -->
</div>
</body>
</html>