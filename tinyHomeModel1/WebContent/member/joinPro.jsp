<%@page import="tinyHome.member.MemberDAO"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Member"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

int age = Integer.parseInt(request.getParameter("age"));
String ju1=request.getParameter("ju1");
String ju2=request.getParameter("ju2");
String addr=request.getParameter("addr");
String daddr=request.getParameter("daddr");
%>
<jsp:useBean id="mb" class="tinyHome.member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<%
mb.setReg_date(new Timestamp(System.currentTimeMillis()));
mb.setAge(age);
mb.setJumin(ju1+"-"+ju2);
mb.setAddr(addr+" "+daddr);
MemberDAO mdao=new MemberDAO();
mdao.insertMember(mb);
%>
<script type="text/javascript">
	alert(" 회원 가입 성공 ");
	location.href="../index.jsp";
</script>
</body>
</html>