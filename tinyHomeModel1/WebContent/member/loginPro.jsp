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
String id = request.getParameter("id");
String pw = request.getParameter("pw");

MemberDAO mdao = new MemberDAO();
int check = mdao.idCk(id, pw);

if(check==1){
	session.setAttribute("id", id);
	%>
    <script type="text/javascript">
        alert("로그인 성공!");
        location.href="../index.jsp";
    </script>
    <%
	response.sendRedirect("../index.jsp");
}else if(check==0){
	%>
    <script type="text/javascript">
        alert("비밀번호 오류!");
        history.back();
    </script>
    <%
}else{//check==-1
	%>
    <script type="text/javascript">
        var result = confirm("아이디가 없습니다. 회원가입 하시겠습니까?");
        alert(result);
        if(result==true){
             location.href="joinForm.jsp";
        }else{
             history.back();
        }
    </script>
    <%
}
%>
</body>
</html>