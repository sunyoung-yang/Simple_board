<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="user" class="user.User" scope="page"/>
    <jsp:setProperty name="user" property="userID"/>
    <jsp:setProperty name="user" property="userPassword"/>
    <jsp:setProperty name="user" property="userName"/>
    <jsp:setProperty name="user" property="userGender"/>
    <jsp:setProperty name="user" property="userEmail"/>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SUNYOUNG'S WORLD</title>
<link rel="icon" type="image/png" href="images/favicons.png" />
</head>
<body>
	<%
		String userID = null;
		//session 넣어줘서 로그인 유지
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID"); 
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어 있습니다.')");
			script.println("location.href= 'main.jsp'"); 
			script.println("</script>");
		}
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || 
		user.getUserGender() == null || user.getUserEmail() == null){
			//개인 정보 모두 입력 안햇을 때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('개인 정보를 모두 입력해 주세요 :)')");
			script.println("history.back()"); //이전 페이지로 리턴
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
			//primary key로 선정된id가 겹칠 때	
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 ID 입니다.')");
				script.println("history.back()"); 
				script.println("</script>");
			} 
			else {
				//회원가입 성공!(result==0)
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			} 
		}
	%>	
</body>
</html>