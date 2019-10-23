<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>
</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">

<%
     //세션값 존재할 때만 삭제/ 세션이 없을경우 로그인
     String id = (String)session.getAttribute("id");
	if(id==null){
    response.sendRedirect("../member/loginForm.jsp");
}
     
     //파라미터갑 저장 num, pageNum    
     int num=Integer.parseInt(request.getParameter("num"));
     String pageNum=request.getParameter("pageNum");
     //pageNum -> 해당 주소를 통해서 이동
     //num -> 폼태그 통해서 이동
%>
          <!-- 게시판 -->
<fieldset>
<legend>Delete</legend>
	<form action="deletePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>" method="post" name="fr">
		<input type="hidden" name="num" value="<%=num%>">
		<table id="notice">
			<tr>
				<td colspan="2"><input type="password" name="pw" class="inputbox" placeholder="비밀번호"></td>
			<tr>
				<td><input type="submit" class="button" id="subbutton" value="삭제">
					<input type="button" value="목록" class="button" id="subbutton" onclick="location.href='notice.jsp'">
				</td>
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