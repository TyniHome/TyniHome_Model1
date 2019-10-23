<%@page import="tinyHome.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>

<style type="text/css">
body{background-color:#fff3e1; text-align: center;}
input#subbutton{float: left; width: 50%;}
input{border: none; vertical-align: middle;}
.inputbox {width:100%; height: 50px;}
input.button {height: 50px; color:#fff3e1; background-color: #66615a; width: 100%;
text-align: center; margin: 0px; float: right;}
input.button:HOVER{background-color: #45423E;}
</style>

<script type="text/javascript">
function yesResult() {
	opener.document.joinFr.nickDupCk.value ="Y";
	opener.document.joinFr.nick.value=document.wfr.usernick.value;
	window.close();
}
function noResult() {
	opener.document.joinFr.nickDupCk.value ="N";
	window.close();
}
</script>
</head>
<body>


<%
String nick = request.getParameter("usernick");

MemberDAO mdao = new MemberDAO();
int check=mdao.joinNickCheck(nick);
if(check==1){
	out.print("이미 존재하는 닉네임입니다.");
	%><br><br>
	<input type="button" value="창 닫기" class="button" onclick="noResult();"><%
	
}else{//check==0 //중복닉네임 존재
	out.print("사용 가능한 닉네임 입니다.<br>이 닉네임을 사용하시겠습니까?");
	%><br>
	<input type="button" value="네" class="button" id="subbutton" onclick="yesResult();">
	<input type="button" value="아니요" class="button" id="subbutton" onclick="noResult();">
	<%
}
%>
<hr>

<form action="joinNickCheck.jsp" name="wfr" method="post">

<input type="text" name="usernick" pattern="[A-za-z0-9가-힣]{4,20}" class="inputbox" id="subbutton" maxlength="20" value="<%=nick %>" autocomplete="off">
<input type="submit"class="button" id="subbutton" value="중복확인">

</form>
</div></div>
</body>
</html>