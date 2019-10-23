<%@page import="tinyHome.member.MemberDAO"%>
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

String id = (String)session.getAttribute("id");
if(id==null){
	response.sendRedirect("loginForm.jsp");
}
String addr=request.getParameter("addr");
String daddr=request.getParameter("daddr");
String newpw=request.getParameter("newpw");
%>
<jsp:useBean id="mb" class="tinyHome.member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<%
mb.setAddr(addr+" "+daddr);
mb.setPw(newpw);
MemberDAO mdao = new MemberDAO();
int check = mdao.updateMember(mb);
if(check==1){
	%>
    <script type="text/javascript">
        alert("회원정보수정완료!");
        location.href="main.jsp";
    </script>
    <%
}else if(check==0){
	%>
    <script type="text/javascript">
        alert("비밀번호 오류");
        history.back();
    </script>
    <%
}else{//check==-1
	%>
    <script type="text/javascript">
        alert("아이디 없음");
        history.back();
    </script>
    <%
}
%>
</body>
</html>