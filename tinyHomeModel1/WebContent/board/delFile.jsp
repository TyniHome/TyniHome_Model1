<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>
</head>
<body>
<%
     request.setCharacterEncoding("euc-kr");
     //전달 받아온 파일 이름 정보 저장
     String fileName = request.getParameter("fileName");
     out.print("삭제할 파일 명 : "+fileName+"<br>");
          
     //파일 접근
     File f = new File("d:/test/"+fileName);
     //파일 삭제
     f.delete();
     out.print(fileName+" 삭제 완료!");
%>
</body>
</html>