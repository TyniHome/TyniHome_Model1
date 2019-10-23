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
if (id==null) {
	response.sendRedirect("loginForm.jsp");
	%>
	<script type="text/javascript">
		location.href="loginForm.jsp"
	</script>
	<%
}
String pw=request.getParameter("pw");
MemberDAO mdao = new MemberDAO();

int check = mdao.deleteMember(id,pw);

if(check==1){
	session.invalidate();
	 %>
     <script type="text/javascript">
         alert("회원탈퇴완료!");
         location.href="../index.jsp";
     </script>
     <%
}else if(check==0){
	%>
    <script type="text/javascript">
        alert("비밀번호 오류!");
        history.back();
    </script>
    <%
}else{
	%>
    <script type="text/javascript">
        alert("아이디 오류!");
        history.back();
    </script>
    <%
}
%>
</body>
</html>