<%@page import="java.io.File"%>
<%@page import="tinyHome.fileBoard.FileBoardDAO"%>
<%@page import="tinyHome.fileBoard.FileBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");

String realPath = request.getServletContext().getRealPath("./upload");
System.out.println("파일이 저장되는 실제 위치 : "+realPath);
int maxSize = 10*1024*1024;
File file;
if(!(file = new File(realPath)).isDirectory()){
    file.mkdirs();
}
MultipartRequest multi = new MultipartRequest(
		request,realPath,maxSize,"UTF-8", 
		new DefaultFileRenamePolicy());

FileBoardBean fbb = new FileBoardBean();
fbb.setNum(num);
fbb.setId(multi.getParameter("id"));
fbb.setPw(multi.getParameter("pw"));
fbb.setName(multi.getParameter("name"));
fbb.setSubject(multi.getParameter("subject"));
fbb.setContent(multi.getParameter("content"));
fbb.setFile(multi.getFilesystemName("file"));
fbb.setIp(request.getRemoteAddr());

FileBoardDAO fbdao = new FileBoardDAO();
int check=fbdao.updateFileBoard(fbb);
if(check==1){
%>
	<script type="text/javascript">
		alert("글 수정 성공!");
		location.href="notice.jsp?pageNum=<%=pageNum%>";
    </script>
<%
}else if(check==0){
%>
	<script type="text/javascript">
		alert("비밀번호 오류!");
		location.href="notice.jsp?pageNum=<%=pageNum%>";
	</script>
<%
}else{
	%>
	<script type="text/javascript">
		alert("글 번호 오류!");
		location.href="notice.jsp?pageNum=<%=pageNum%>";
	</script>
<%	
}
%>
</body>
</html>