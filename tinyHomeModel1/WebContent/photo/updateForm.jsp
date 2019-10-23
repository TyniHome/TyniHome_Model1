<%@page import="tinyHome.member.MemberBean"%>
<%@page import="tinyHome.member.MemberDAO"%>
<%@page import="tinyHome.photo.PhotoDAO"%>
<%@page import="tinyHome.photo.PhotoBean"%>
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
request.setCharacterEncoding("euc-kr");
String id = (String)session.getAttribute("id");
if(id==null){
     response.sendRedirect("../member/loginForm.jsp");
}

int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");

PhotoDAO pdao=new PhotoDAO();
PhotoBean pb=pdao.getPhoto(num);

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
			<input type="text" class="inputbox" name="subject" maxlength="100" value="<%=pb.getSubject()%>">
			<input type="hidden" name="num" value="<%=num%>">
			
			<input type="hidden" name="id" value="<%=id%>">
			<input type="hidden" name="pw" value="<%=mb.getPw()%>">
			<input type="hidden" name="name" value="<%=mb.getName()%>">
			</td>
		</tr>
		<tr>
			<td><textarea id="summernote" rows="10" cols="20" name="content" style="text-align: left;"><%=pb.getContent() %></textarea></td>
		</tr>
		
		<tr>
			<td>FILE : <%if(pb.getFile()!=null){ %><a href="downFile.jsp?file=<%=pb.getFile()%>"><%=pb.getFile() %></a>"><%}else{%>NULL<%} %></td>
		</tr>
		
		<tr><td style="text-align: center;">
		<input type="file" name="file" class="inputbox" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'>
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