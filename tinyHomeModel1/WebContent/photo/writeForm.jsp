<%@page import="tinyHome.member.MemberBean"%>
<%@page import="tinyHome.member.MemberDAO"%>
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
		if(!document.writeFr.subject.value){
			alert("제목을 입력해주세요.");
			return false;
		}
		if(!document.writeFr.content.value){
			alert("내용을 입력해주세요.");
			return false;
		}
		if(!document.writeFr.file.value){
			alert("사진을 올려주세요.");
			return false;
		}
	}
</script>
<script type="text/javascript">
function chk_file_type(obj) {
	 var file_kind = obj.value.lastIndexOf('.');
	 var file_name = obj.value.substring(file_kind+1,obj.length);
	 var file_type = file_name.toLowerCase();



	 var check_file_type=new Array();​

	 check_file_type=['jpg','gif','png','jpeg','bmp'];



	 if(check_file_type.indexOf(file_type)==-1){
	  alert('이미지 파일만 선택할 수 있습니다.');
	  var parent_Obj=obj.parentNode
	  var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);
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
String id = (String)session.getAttribute("id");
if(id==null){
	response.sendRedirect("../member/loginForm.jsp");
}
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
%>

<fieldset class="writeField">
<div class="clear"></div>
<legend>글쓰기</legend>
<form action="writePro.jsp" name="writeFr" method="post" onsubmit="return valCk();" enctype="multipart/form-data">
	<div class="writeFrTb">
	<div class="clear"></div>
	<table>
	<!-- <div id="summernote"></div> -->
		<tr>
			<td>
			<input type="text" name="subject" class="inputbox" placeholder="제목" maxlength="100">
			<input type="hidden" name="id" value="<%=id%>">
			<input type="hidden" name="pw" value="<%=mb.getPw()%>">
			<input type="hidden" name="name" value="<%=mb.getName()%>">
			</td>
		</tr>
		<tr>
			<td><textarea id="summernote" name="content" style="text-align: left;" placeholder="내용을 입력하세요."></textarea></td>
		</tr>

		<tr><td style="text-align: center;">
		<input type="file" name="file" class="inputbox" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'>
		</td>
		</tr>
		<tr>
			<td><input type="submit" class="button" id="wbutton" value="쓰기">
			<input type="reset" class="button" id="wbutton" value="다시쓰기">
			<input type="button" value="목록" id="wbutton" class="button" onclick="location.href='notice.jsp'"></td>
		</tr>
	</table>
	</div>
</form>
</fieldset>
	</div>
	<!-- 푸터파일 -->
	<jsp:include page="../include/bottom.jsp"/>
	<!-- 푸터파일 -->
</div>
</body>
</html>