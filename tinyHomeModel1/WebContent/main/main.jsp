<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>

</head>
<body>
	<div class="box_round">
		<!-- 헤더파일 -->
		<jsp:include page="../include/top.jsp" />
		<!-- 헤더파일 -->
		<div class="container clearfix">
			<div class="pa mackbook hover"
				onclick="location.href='../board/notice.jsp'">
				<div class="screen">
					<div class="user_pic"></div>
					<div class="password"></div>
					<div class="icons clearfix">
						<div class="icon"></div>
						<div class="icon"></div>
						<div class="icon"></div>
					</div>
				</div>
				<div class="base pr">
					<div class="connector"></div>
					<div class="keypad">
						<div class="clearfix">
							<div class="ftl key key2"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key2"></div>
						</div>
						<div class="clearfix pad-lr-10">
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
						</div>
						<div class="clearfix">
							<div class="ftl key key2"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key2"></div>
						</div>
						<div class="clearfix pad-lr-10">
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key3"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
							<div class="ftl key key1"></div>
						</div>
					</div>
					<div class="touchpad"></div>
					<div class="pa shadow"></div>
				</div>
			</div>

			<div class="pa mouse hover"
				onclick="location.href='../board/notice.jsp'">
				<div class="pa scroller"></div>
			</div>

			<div class="pa phone hover"
				onclick="location.href='../contactUs/notice.jsp'">
				<div class="speaker"></div>
				<div class="screen">
					<div class="screen_data"></div>
				</div>
				<div class="button"></div>
				<div class="pa volume_rockers"></div>
			</div>


			<div class="pa notes hover"
				onclick="location.href='../fileBoard/notice.jsp'">
				<div class="note pr"></div>
			</div>

			<div class="pa camera hover"
				onclick="location.href='../photo/notice.jsp'">
				<img src="../image/photograph.png" style="width: 160px;">
			</div>

			<div class="pa diary hover"
				onclick="location.href='../diary/notice.jsp'">
				<div class="main">
					<div class="cover">
						<div class="pa less"></div>
					</div>
				</div>
			</div>


			<%
    String id = (String)session.getAttribute("id");
  	if (id == null) {
  		%>

			<%
  	}else{
  	%>
			<div class="pa pencil hover"
				onclick="location.href='../diary/writeForm.jsp'">
				<div class="pa pencil-bottom"></div>
				<div class="pencil-nip">
					<div class="pencil-tip"></div>
				</div>
			</div>
			<%} %>

			<%
  	if (id == null) {
  		%>
			<div class="pa lock hover"
				onclick="location.href='../member/loginForm.jsp'">
				<div class="clear"></div>
				<div class="handle"></div>
				<div class="pr locker">
					<div class="pa key_hole"></div>
				</div>
			</div>
		</div>
		<%
  	}else{
  	%>
		<div class="pa key hover"
			onclick="location.href='../member/logout.jsp'">
			<img src="../image/key-icon-4.png" style="width: 70px;">
		</div>
		<%} %>

	</div>
</body>
</html>