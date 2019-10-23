<%@page import="java.net.URLEncoder"%>
<%@page import="javax.swing.text.StyledEditorKit.BoldAction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
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
String fileName= request.getParameter("file");
String filePath="/upload";
ServletContext context = getServletContext();
String sDownloadPath = context.getRealPath(filePath);
String sFilePath = sDownloadPath + "\\" + fileName;
byte[] b = new byte[4096];
FileInputStream in = new FileInputStream(sFilePath);
String sMimeType = getServletContext().getMimeType(sFilePath);
System.out.println("sMimeType >>> " + sMimeType);

if(sMimeType == null)
	sMimeType = "application/octet-stream";

response.setContentType(sMimeType);
String agent = request.getHeader("User-Agent");
Boolean ieBrowser=(agent.indexOf("MSIE")>-1) ||(agent.indexOf("Trident")>-1);

if(ieBrowser){
	fileName = URLEncoder.encode(fileName,"UTF-8").
			replaceAll("\\+","%20");
}else{
	fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
}

response.setHeader("Content-Disposition", "attachment; filename="+fileName);

ServletOutputStream out2 = response.getOutputStream();
int numRead;

while((numRead = in.read(b, 0, b.length)) != -1) {
	out2.write(b, 0, numRead);
}
out2.flush();
out2.close();
in.close();
%>
</body>
</html>