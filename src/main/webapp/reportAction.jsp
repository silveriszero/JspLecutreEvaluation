<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator" %>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="util.SHA256"%>
<%@page import="util.NaverMail"%>
<% 
	String userID = null ;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	request.setCharacterEncoding("UTF-8");
	String reportTitle = null;
	String reportContent = null;
	if(request.getParameter("reportTitle") != null ){
		reportTitle = (String) request.getParameter("reportTitle");
	}
	if(request.getParameter("reportContent") != null ){
		reportContent = (String) request.getParameter("reportContent");
	}
	if (reportTitle == null || reportContent == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	//사용자에게 보낼 메세지 기입
	String host = "http://localhost:8080/Lecture_Evaluation/";
	String from = "eunyoun0519@naver.com";
	String to = "eunyoun0519@naver.com";
	String subject = "강의 평가 사이트에서 접수된 신고 메일입니다.";
	String content = "신고자"+  userID + "<br>제목 :" + reportTitle + "<br> 내용 :" + reportContent;
	
	//smtp에 접속하기 위한 정보 기입
		Properties p = new Properties();
	p.put("mail.smtp.user", to);
	p.put("mail.smtp.host", "smtp.naver.com");
	p.put("mail.smtp.port", "587");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.ssl.enable", "false");
	p.put("mail.smtp.ssl.protocols", "TLSv1.2");
	p.put("mail.smtp.starttls.enable", "true"); 
	
	try{
		Authenticator auth = new NaverMail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF-8");
		Transport.send(msg);
	} catch(Exception e){
		e.printStackTrace();
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다..');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('정상적으로 신고되었습니다');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return ;
	
%>