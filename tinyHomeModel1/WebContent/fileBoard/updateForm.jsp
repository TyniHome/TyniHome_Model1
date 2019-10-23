<%@page import="tinyHome.member.MemberBean"%>
<%@page import="tinyHome.member.MemberDAO"%>
<%@page import="tinyHome.fileBoard.FileBoardDAO"%>
<%@page import="tinyHome.fileBoard.FileBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>TinyHome</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<script>
	$(document).ready(function() {
		$('#summernote').summernote();
	});
</script>
<script type="text/javascript">
	function valCk() {
		if(!document.updateFr.subject.value){
			alert("제목을 입력해주세요.");
			return false;
		}
		if(!document.updateFr.content.value){
			alert("내용을 입력해주세요.");
			return false;
		}
		if(!document.updateFr.file.value){
			alert("파일을 올려주세요.");
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
<%
request.setCharacterEncoding("euc-kr");
String id = (String)session.getAttribute("id");
if(id==null){
     response.sendRedirect("../member/loginForm.jsp");
}

int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");

FileBoardDAO fbdao=new FileBoardDAO();
FileBoardBean fbb=fbdao.getFileBoard(num);

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
%>
<fieldset>
<legend>글 수정</legend>
<form action="updatePro.jsp?pageNum=<%=pageNum %>&num=<%=num%>" name="updateFr" method="post" onsubmit="return valCk();" enctype="multipart/form-data">
	<table>
	<!-- <div id="summernote"></div> -->
		<tr>
			<td>
			<input type="text" class="inputbox" name="subject" maxlength="100" value="<%=fbb.getSubject()%>">
			<input type="hidden" name="num" value="<%=num%>">
			
			<input type="hidden" name="id" value="<%=id%>">
			<input type="hidden" name="pw" value="<%=mb.getPw()%>">
			<input type="hidden" name="name" value="<%=mb.getName()%>">
			</td>
		</tr>
		<tr>
			<td><textarea id="summernote" rows="10" cols="20" name="content" style="text-align: left;"><%=fbb.getContent() %></textarea></td>
		</tr>
		
		<tr>
			<td>FILE : <%if(fbb.getFile()!=null){ %><a href="downFile.jsp?file=<%=fbb.getFile()%>"><%=fbb.getFile() %></a>"><%}else{%>NULL<%} %></td>
		</tr>
		
		<tr><td style="text-align: center;">
		<input type="file" name="file" class="inputbox">
		</td>
		</tr>
		<tr>
			<td><input type="submit" class="button" id="wbutton" value="수정">
			<input type="reset" class="button" id="wbutton" value="다시쓰기">
			<input type="button" value="목록" id="wbutton" class="button" onclick="location.href='notice.jsp'"></td>
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