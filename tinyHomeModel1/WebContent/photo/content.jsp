<%@page import="tinyHome.photo.PhotoBean"%>
<%@page import="tinyHome.photo.PhotoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>TinyHome</title>

</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
<%
//파라미터값 글번호,페이지번호 정보를 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

//PhotoDAO 객체 생성 
PhotoDAO pdao = new PhotoDAO();

//글 조회수를 수정(1증가)
pdao.updateReadCount(num);

//글 번호에 해당하는 글의 정보를 가져오기 (PhotoBean)
// getPhoto(글번호)	
PhotoBean pb=pdao.getPhoto(num);

//표를 사용해서 출력 
String content = pb.getContent();
if (content != null) {
	// 본문의 데이터 중에서 줄바꿈 처리 
	content = pb.getContent().replace("\r\n", "<br>");
}
%>
<legend>Photo</legend>
<table style="width: 800px;">
	<tr>
		<th class="tdhead">No</th>
		<td><%=pb.getNum() %></td>
		<th class="tdhead">views</th>
		<td><%=pb.getReadcount()%></td>
		<th class="tdhead">name</th>
		<td><%=pb.getName() %></td>
		<th class="tdhead">Date</th>
		<td><%=pb.getDate() %></td>
	</tr>
	<tr>
		<th class="tdhead">Title</th>
		<td colspan="7"><%=pb.getSubject()%></td>
	</tr>
	<tr>
		<th class="tdhead">Content</th>
		<td colspan="7"><%=content%></td>
	</tr>
	
	<tr>
		<th>Photo</th>
		<td colspan="3"  class="left">
		<%if(pb.getFile()!=null){ %>
		<a href="downFile.jsp?file=<%=pb.getFile()%>"><img src="../upload/<%=pb.getFile()%>" width="300px;"></a>
		<%}else{ %>
		 NULL
		<%} %>
		</td>
	</tr>
	
	
	
	<tr><td colspan="8">
	<%
	String id =(String)session.getAttribute("id");
	if(id.equals(pb.getId())){
	%>
	<input type="button" value="수정" class="button" id="subbutton" onclick="location.href='updateForm.jsp?num=<%=pb.getNum()%>&pageNum=<%=pageNum%>'">
	<input type="button" value="삭제" class="button" id="subbutton" onclick="location.href='deleteForm.jsp?num=<%=pb.getNum()%>&pageNum=<%=pageNum%>'">
	<%}%>
	</td></tr>
	<tr><td colspan="8">
	<%if(id != null){%>
	<input type="button" value="답글" class="button" id="subbutton" onclick="location.href='reWriteForm.jsp?num=<%=pb.getNum()%>&re_ref=<%=pb.getRe_ref()%>&re_lev=<%=pb.getRe_lev()%>&re_seq=<%=pb.getRe_seq()%>'">
	<%}%>
	<input type="button" value="글 목록" class="button" id="subbutton" onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
	</td></tr>
</table>
	</div>
	<!-- 푸터파일 -->
	<jsp:include page="../include/bottom.jsp"/>
	<!-- 푸터파일 -->
</div>
</body>
</html>