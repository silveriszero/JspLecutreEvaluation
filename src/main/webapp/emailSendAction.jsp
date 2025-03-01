<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.mail.Transport" %>
<%@page import="javax.mail.Message" %>
<%@page import="javax.mail.Address" %>
<%@page import="javax.mail.internet.InternetAddress" %>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="util.SHA256"%>
<%@page import="util.NaverMail"%>
<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<Script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</Script>");
		script.close();
		return;
	}
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked == true){
		PrintWriter script = response.getWriter();
		script.println("<Script>");
		script.println("alert('이미 인증된 회원입니다');");
		script.println("location.href = 'index.jsp'");
		script.println("</Script>");
		script.close();
		return;
	}
	
	// 사용자에게 보낼 메세지
	
	String host = "http://localhost:8080/Lecture_Evaluation/";
	String from = "eunyoun0519@naver.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "강의평가를 위한 이메일 인증 메일 입니다!";
	String content = "다음 링크에 접속하여 이메일 확인을 진행하세요." +
	"<a href ='"+ host + "emailCheckAction.jsp?code="+ new SHA256().getSHA256(to)+"'>이메일인증하기</a>";
	
	//smtp에 접속하기 위한 정보를 기입	
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.naver.com");
	p.put("mail.smtp.port", "587");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.ssl.enable", "false");
	p.put("mail.smtp.ssl.protocols", "TLSv1.2");
	p.put("mail.smtp.starttls.enable", "true"); // 필요하지 않지만 추가 가능
	//p.put("mail.smtp.socketFactory.port", "587");
	//p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	//p.put("mail.smtp.socketFactory.fallback", "false");
	

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
%>

<!doctype html>
<html>
	<head>
	<title>강의평가 웹 사이트</title>
	<meta charset="UTF-8">
	<meta name="viewprot" content="width=device-width,initial-scale=1,shrink-to-fit=no"> <!-- 반응형 웹 (뷰포트설정하기) -->
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
	</head>
	<body>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbar">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="index.jsp">메인	</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dromdown-toggle" id="dropdown" data-toggle="dropdown">
						회원관리
						</a>
						<div class="dropdown-menu" aria-labelledby="dropdown">
							<%
								if(userID == null){
							%>
							<a class="dropdown-item" href="./userLogin.jsp">로그인</a>
							<a class="dropdown-item" href="./userRegister.jsp">회원가입</a>
							<%
								}else{
							%>
							<a class="dropdown-item" href="./userLogout.jsp">로그아웃</a>
							<%
								}
							%>
						</div>
					</li>		
				</ul>
				<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
					<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-label="Search">
					<button class="btn btn-outline-success my-2-sm-0" type="submit" >검색</button>
				</form>
			</div>
		</nav>
		<section class="container mt-3" style="max-width:560px;">
			<div class="alert alert-success mt-4" role="alert">
				이메일 주소 인증 메일이 전송되었습니다. 회원가입 시 입력했던 이메일에 들어가서 인증해주세요.
			</div>
		</section>
		<footer class="bg-dark mt-4 p-5 text-center" style="color:#ffffff;">
		Copyright 2025 이은영 All Rights Reseverd.
		</footer>
		<!-- 제이쿼리 자바스크립트 추가하기 -->
		<script src="./js/jquery.js"></script>
		<!-- poper 자바스크립트 추가하기 -->
		<script src="./js/poper.js"></script>
		<!-- 부트스트랩 자바스크립트 추가하기 -->
		<script src="./js/bootstrap.min.js"></script>
	</body>
</html>

