<%@page import="tinyHome.fileBoard.FileBoardDAO"%>
<%@page import="tinyHome.fileBoard.FileBoardBean"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
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

FileBoardBean fbb = new FileBoardBean();
fbb.setRe_ref(Integer.parseInt(multi.getParameter("re_ref")));
fbb.setRe_lev(Integer.parseInt(multi.getParameter("re_lev")));
fbb.setRe_seq(Integer.parseInt(multi.getParameter("re_seq")));

fbb.setId(multi.getParameter("id"));
fbb.setPw(multi.getParameter("pw"));
fbb.setName(multi.getParameter("name"));
fbb.setSubject(multi.getParameter("subject"));
fbb.setContent(multi.getParameter("content"));
fbb.setFile(multi.getFilesystemName("file"));
fbb.setIp(request.getRemoteAddr());

FileBoardDAO fbdao = new FileBoardDAO();
fbdao.reInsertFileBoard(fbb);
response.sendRedirect("notice.jsp");
%>
<script type="text/javascript">
     alert("답글쓰기 성공!")
     location.href="notice.jsp"
</script>
</body>
</html>