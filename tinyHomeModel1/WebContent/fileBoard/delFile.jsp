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
     //���� �޾ƿ� ���� �̸� ���� ����
     String fileName = request.getParameter("fileName");
     out.print("������ ���� �� : "+fileName+"<br>");
          
     //���� ����
     File f = new File("d:/test/"+fileName);
     //���� ����
     f.delete();
     out.print(fileName+" ���� �Ϸ�!");
%>
</body>
</html>