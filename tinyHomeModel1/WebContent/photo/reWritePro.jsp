<%@page import="tinyHome.photo.PhotoDAO"%>
<%@page import="tinyHome.photo.PhotoBean"%>
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

PhotoBean pb = new PhotoBean();
pb.setRe_ref(Integer.parseInt(multi.getParameter("re_ref")));
pb.setRe_lev(Integer.parseInt(multi.getParameter("re_lev")));
pb.setRe_seq(Integer.parseInt(multi.getParameter("re_seq")));

pb.setId(multi.getParameter("id"));
pb.setPw(multi.getParameter("pw"));
pb.setName(multi.getParameter("name"));
pb.setSubject(multi.getParameter("subject"));
pb.setContent(multi.getParameter("content"));
pb.setFile(multi.getFilesystemName("file"));
pb.setIp(request.getRemoteAddr());

PhotoDAO pdao = new PhotoDAO();
pdao.reInsertPhoto(pb);
response.sendRedirect("notice.jsp");
%>
<script type="text/javascript">
     alert("답글쓰기 성공!")
     location.href="notice.jsp"
</script>
</body>
</html>