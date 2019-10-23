<%@page import="tinyHome.photo.PhotoBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tinyHome.photo.PhotoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>
</head>
<body>
	<div class="box_round">
		<!-- 헤더파일 -->
		<jsp:include page="../include/top.jsp" />
		<!-- 헤더파일 -->
	<div class="scroll">
<%
PhotoDAO pdao = new PhotoDAO();
int count = pdao.getPhotoCount();

//페이징
int pageSize = 3;
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}
				
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1)*pageSize + 1;
int endRow = currentPage*pageSize;
//페이징

List PhotoList = null;
if (count != 0) {
	PhotoList = pdao.getPhotoList(startRow, pageSize);
}
%>

<legend>Photo</legend>
<table>
	<tr>
		<th colspan="5"><h4 style="text-align: right;">Total :<%=count%></h4></th>
	</tr>
	<tr>
		<th style="text-align: center;width: 50px;">No</th>
		<th style="width: 200px;">Photo</th>
		<th style="width: 350px;">Title</th>
		<th style="width: 100px; text-align: center;">name</th>
		<th style="width: 100px; text-align: center;">Date</th>
		<th style="width: 50px; text-align: center;">views</th>
	</tr>
<%
if (count != 0) {
	for(int i=0;i<PhotoList.size();i++){
		PhotoBean pb = (PhotoBean) PhotoList.get(i);
%>
	<tr>
		<td style="text-align: center;"><%=pb.getNum()%></td>
		<td style="text-align: center;"><img src="../upload/<%=pb.getFile()%>" width="100px;"></td>
		<td style="text-align: left;">
			<%
				int wid = 0;
				if (pb.getRe_lev() > 0) { // 답글이 존재할때 
					wid = pb.getRe_lev() * 10;
			%>
				<img src="../image/level.gif" height="15" width="<%=wid%>"> 
				<img src="../image/re.gif">
			<%}%>
			<a href="content.jsp?num=<%=pb.getNum()%>&pageNum=<%=pageNum%>"><%=pb.getSubject()%></a>
		</td>
		<td style="text-align: right;"><%=pb.getName()%></td>
		<td style="text-align: right;"><%=pb.getDate()%></td>
		<td style="text-align: right;"><%=pb.getReadcount()%></td>
	</tr>

			<%}}%>

<tr><td colspan="6" style="text-align: center;">
<%
	if (count != 0) {
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int pageBlock = 10;
		int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
					
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		if (startPage > pageBlock) {
			%>
			<a href="notice.jsp?pageNum=<%=startPage - pageBlock%>">Prev</a>
			<%
		}
		for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="notice.jsp?pageNum=<%=i%>"><%=i%></a>
			<%
		}
			if (endPage < pageCount) {
			%>
			<a href="notice.jsp?pageNum=<%=startPage + pageBlock%>">Next</a>
	<%}}%>
</td>
</tr>
<tr>
<td colspan="6">
<div>
			<!-- 글쓰기 -->
			<%
	 			String id = (String) session.getAttribute("id");
	 			if (id != null) {
			%>
			<input type="button" value="글쓰기" class="button" id="wbutton" onclick="location.href='writeForm.jsp'"> 
			<%}%>

		<!-- 검색 -->
		<form action="noticeSearch.jsp" class="inputbox" method="get">
			<input type="text" name="search" id="wbutton" class="inputbox" id="subbutton">
			<input type="submit" value="search" id="wbutton" class="button" id="subbutton"></form>
</div>
</td>
</tr>
</table>
</div>
		<!-- 푸터파일 -->
		<jsp:include page="../include/bottom.jsp" />
		<!-- 푸터파일 -->
</div>
</body>
</html>