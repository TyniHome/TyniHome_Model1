<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="tinyHome.diary.DiaryDAO"%>
<%@page import="tinyHome.diary.DiaryBean"%>
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
request.setCharacterEncoding("euc-kr");

String id = (String)session.getAttribute("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");


String realPath = request.getRealPath("./upload");
System.out.println("파일이 저장되는 실제 위치 : "+realPath);
int maxSize = 10*1024*1024;
File file;
if(!(file = new File(realPath)).isDirectory()){
    file.mkdirs();
}
MultipartRequest multi = new MultipartRequest(
		request,realPath,maxSize,"UTF-8", 
		new DefaultFileRenamePolicy());

DiaryBean dib = new DiaryBean();
dib.setId(multi.getParameter("id"));
dib.setPw(multi.getParameter("pw"));
dib.setName(multi.getParameter("name"));
dib.setSubject(multi.getParameter("subject"));
dib.setContent(multi.getParameter("content"));
dib.setFile(multi.getFilesystemName("file"));
dib.setIp(request.getRemoteAddr());

DiaryDAO bdao = new DiaryDAO();
bdao.insertDiary(dib);
response.sendRedirect("notice.jsp");
%>
<script type="text/javascript">
     alert("글쓰기 성공!")
     location.href="notice.jsp"
</script>
</body>
</html>