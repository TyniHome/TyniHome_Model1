<%@page import="tinyHome.member.MemberBean"%>
<%@page import="tinyHome.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<html>
<head>
<title>TinyHome</title>
<style>
	table{
		width : 450px;
		margin : auto;
	}
	h1{
		text-align: center;
	}
</style>
</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
<%
String id = (String)session.getAttribute("id");
if(id==null){
	response.sendRedirect("../member/loginForm.jsp");
}
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
%>
<form action="mailSend.jsp" method="post">
<input type="hidden" name="sender" value="<%=mb.getMail()%>">
<input type="hidden" name="receiver" value="tinyhomead@gmail.com">
<legend>MAIL</legend>
<table>
	<!-- <tr><td>보내는 사람 메일 : </td><td><input type="text" name="sender"></td></tr> -->
	<!-- <tr><td>받는 사람 메일 : </td><td><input type="text" name="receiver" value=""></td></tr> -->
	
	<tr><td><input type="text" name="subject" placeholder="제목" class="inputbox"></td></tr>
	<tr>
		<td><textarea name="content" cols=40 rows=20 placeholder="내용" class="inputbox"></textarea></td>
	</tr>
	<tr><td align=center><input type="submit" class="button" value="SEND"></td></tr>
</table>
</form>




	</div>
	<!-- 푸터파일 -->
	<jsp:include page="../include/bottom.jsp"/>
	<!-- 푸터파일 -->
</div>
</body>
</html>
