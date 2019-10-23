<%@page import="tinyHome.diary.DiaryDAO"%>
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
request.setCharacterEncoding("UTF-8");
String pageNum=request.getParameter("pageNum");
int num=Integer.parseInt(request.getParameter("num"));
String pw=request.getParameter("pw");

DiaryDAO didao = new DiaryDAO();
int check=didao.deleteDiary(num, pw);
if(check==1){
	%>
     <script type="text/javascript">
         alert("글 삭제 완료!");
          location.href="notice.jsp?pageNum=<%=pageNum%>";
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
        alert("글 정보 없음!");
        history.back();
    </script>
    <%
}
%>
</body>
</html>