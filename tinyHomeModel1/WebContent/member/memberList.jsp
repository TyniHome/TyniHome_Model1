<%@page import="tinyHome.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tinyHome.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
<%
String id=(String)session.getAttribute("id");
if(id==null || !id.equals("admin")){
	response.sendRedirect("../index.jsp");
}
MemberDAO mdao = new MemberDAO();
ArrayList<MemberBean> memberList=mdao.getMemberList();
%>
<legend>Member list</legend>
	<table>
  <thead>
    <tr>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>age</th>
      <th>phone</th>
      <th>mail</th>
      <th>post</th>
      <th>addr</th>
      <th>date</th>
    </tr>
  </thead>
 
  <tbody>
  <%for(int i=0;i<memberList.size();i++){
	MemberBean mb=memberList.get(i);%>
    <tr>
      <td><%=mb.getId() %></td>
      <td><%=mb.getName() %></td>
      <td><%=mb.getGender() %></td>
      <td><%=mb.getAge() %></td>
      <td><%=mb.getPhone()%></td>
      <td><%=mb.getMail() %></td>
      <td><%=mb.getPost()%></td>
      <td><%=mb.getAddr()%></td>
      <td><%=mb.getReg_date() %></td>
    </tr>
         <%} %>
  </tbody>

  <tfoot>
    <tr>
      <th>id</th>
      <th>name</th>
      <th>gender</th>
      <th>age</th>
      <th>phone</th>
      <th>mail</th>
      <th>post</th>
      <th>addr</th>
      <th>date</th>
    </tr>
  </tfoot>
</table>
</article>

	</div>
	<!-- 푸터파일 -->
	<jsp:include page="../include/bottom.jsp"/>
	<!-- 푸터파일 -->
</div>
</body>
</html>