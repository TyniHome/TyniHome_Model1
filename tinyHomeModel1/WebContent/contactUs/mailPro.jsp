<%@page import="tinyHome.util.SMTPAuthenticatior"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");

String from = request.getParameter("from");
String to = request.getParameter("to");
String email = request.getParameter("email");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

Properties p = new Properties(); // 정보를 담을 객체

p.put("mail.smtp.host","smtp.mailplug.co.kr"); 
p.put("mail.smtp.port", 465);
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", 465);
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");


try{
  Authenticator auth = new SMTPAuthenticatior();
  Session ses = Session.getInstance(p, auth);
    
  ses.setDebug(true);
  MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체  

  msg.setSubject(subject); //  제목 

  StringBuffer buffer = new StringBuffer();  
  buffer.append("이메일 : ");
  buffer.append(email+"<br>");    
  buffer.append("제목 : ");
  buffer.append(subject+"<br>");
  buffer.append("내용 : ");
  buffer.append(content+"<br>");
  Address fromAddr = new InternetAddress(from);
  msg.setFrom(fromAddr);  

  Address toAddr = new InternetAddress(to);
  msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람 
   
  msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // 내용
  Transport.send(msg); // 전송   

} catch(Exception e){
  e.printStackTrace();
  return;
}
%>
<script type="text/javascript">
     alert("메일 전송!")
     location.href="../index.jsp"
</script>
</body>
</html>