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
function valCk() {
	if(!document.loginFr.id.value){
		alert("아이디를 입력하세요.");
		document.loginFr.id.focus();
		return false;
	}
	if(!document.loginFr.pw.value){
		alert("비밀번호를 입력해주세요.");
		document.loginFr.pw.focus();
		return false;
	}
}
</script>
</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
<fieldset>
<legend>로그인</legend>
<form action="loginPro.jsp" method="post" name="loginFr" onsubmit="return valCk();">
<table>
<tr><!-- pattern="[A-za-z0-9]{4,12}" -->
<td colspan="2"><input type="text" class="inputbox" name="id" placeholder="아이디"  autofocus autocomplete="off"></td>
</tr>
<tr>
<td colspan="2"><input type="password" name="pw" class="inputbox" placeholder="비밀번호"></td>
</tr>
<!-- <tr><td style="text-align: center;"><a href="#">아이디 찾기</a><td style="text-align: center;"><a href="#">비밀번호 찾기</a></td>
</tr> -->
<tr>
<td colspan="2"><input type="submit" value="로그인" class="button" id="subbutton" ><input type="reset" value="취소" class="button" id="subbutton"></td>
</tr>
<tr>
<td colspan="2"><input type="button" value="회원가입" class="button" onclick="location.href='joinForm.jsp'"></td>
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