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
	opener.document.joinFr.idDupCk.value ="Y";
	opener.document.joinFr.id.value=document.wfr.userid.value;
	window.close();
}
function noResult() {
	opener.document.joinFr.idDupCk.value ="N";
	window.close();
}
</script>
</head>
<body>
<div id="ckRound">
<div class="scroll">
<%
String id = request.getParameter("userid");

MemberDAO mdao=new MemberDAO();
int check=mdao.joinIdCheck(id);
if(check==1){//중복아이디 존재
	out.print("이미 존재하는 아이디입니다.");
	%><br><br>
	<input type="button" value="창 닫기" class="button" onclick="noResult();">
	<%
}else{//check==0 //중복아이디 존재
	out.print("사용 가능한 아이디 입니다.<br>이 아이디를 사용하시겠습니까?");
	%><br>
	<input type="button" value="네" class="button" id="subbutton" onclick="yesResult();">
	<input type="button" value="아니요" class="button" id="subbutton" onclick="noResult();">
	<%
}
%>
<hr>
<form action="joinIdCheck.jsp" name="wfr" method="post">
<input type="text" name="userid" pattern="[A-za-z0-9]{4,12}" class="inputbox" id="subbutton" maxlength="12" value="<%=id %>" autocomplete="off">
<input type="submit" class="button" id="subbutton" value="중복확인">
</form>
</div>
</div>
</body>
</html>