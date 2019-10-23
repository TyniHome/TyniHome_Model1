<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!-- 헤더역할 -->
<header>
<%
	String id = (String)session.getAttribute("id");
	//세션값 있는지 판단
	if(id!=null) {
		//아이디가 있을 때	
		%>
		<div id="login">
		<a href="../member/info.jsp"><%=id %>님 환영합니다!</a> | <a href="../member/logout.jsp">LOGOUT</a>
		</div>
		<div class="clear"></div>
		<section>

		<%
	}else{
		//아이디가 없을 때
		%>
		<div id="login">
		<a href="../member/loginForm.jsp">LOGIN</a> | <a href="../member/joinForm.jsp">JOIN US</a>
		</div>
		<%
	}
%>
<div class="clear"></div>
	<!-- 로고들어가는 곳 -->
	<div id="logo">
		<a href="../index.jsp">
		<img src="../image/bannerLogo.png" alt="Tiny Home"></a>
	</div>
	<!-- 로고들어가는 곳 -->
	<%if(id!=null) {%>
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../diary/notice.jsp">DIARY</a></li>
	<li><a href="../board/notice.jsp">COMMUNITY</a></li>
	<li><a href="../fileBoard/notice.jsp">FILE</a></li>
	<li><a href="../photo/notice.jsp">PHOTO</a></li>
	<li><a href="../member/info.jsp">INFO</a></li>
	<li><a href="../contactUs/notice.jsp">CONTACT US</a></li>
</ul>
</nav>
</section>
<%
	}
%>
<div class="clear"></div>
</header>
