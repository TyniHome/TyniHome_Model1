<%@page import="tinyHome.member.MemberBean"%>
<%@page import="tinyHome.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("loginForm.jsp");
	}
	
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.getMember(id);
%>
	<fieldset>
		<legend>INFO.</legend>
		<table>
			<tr>
				<td>아이디</td>
				<td style="text-align: right;"><%=mb.getId()%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td style="text-align: right;"><%=mb.getName()%></td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td style="text-align: right;"><%=mb.getNick()%></td>
			</tr>
			<tr>
				<td>성별</td>
				<td style="text-align: right;"><%=mb.getGender()%></td>
			</tr>
			<tr>
				<td>폰번호</td>
				<td style="text-align: right;"><%=mb.getPhone()%></td>
			</tr>
			<tr>
				<td>메일</td>
				<td style="text-align: right;"><%=mb.getMail()%></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td style="text-align: right;"><%=mb.getPost()%></td>
			</tr>
			<tr>
				<td>주소</td>
				<td style="text-align: right;"><%=mb.getAddr() %></td>
			</tr>
			<tr>
				<td>가입일</td>
				<td style="text-align: right;"><%=mb.getReg_date() %></td>
			</tr>
	
		<td colspan="2"><input type="button" value="수정" class="button" id="subbutton" onclick="location.href='updateForm.jsp'"><input type="button" value="탈퇴" class="button" id="subbutton" onclick="location.href='deleteForm.jsp'"></td>
		</table>
		<%if(id.equals("admin")){ %>
		<h1><a href="memberList.jsp" style="font-size: 2em;">회원 전체 정보 열람</a></h1><%} %>
		
		
	</fieldset>
</div>
	<!-- 푸터파일 -->
	<jsp:include page="../include/bottom.jsp"/>
	<!-- 푸터파일 -->
</div>
</body>
</html>