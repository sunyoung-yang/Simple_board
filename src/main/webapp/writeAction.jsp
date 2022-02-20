<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="board.BbsDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="board" class="board.Board" scope="page"/>
    <jsp:setProperty name="board" property="bTitle"/>
    <jsp:setProperty name="board" property="bContent"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
<link rel="icon" type="image/png" href="images/favicons.png" />
</head>
<body>
	<%
		String userID = null;
		//session 넣어줘서 로그인 유지
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID"); 
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('먼저 로그인 하세요')");
			script.println("location.href= 'login.jsp'"); 
			script.println("</script>");
		} else{
			if(board.getbTitle() == null || board.getbContent() == null){
						//개인 정보 모두 입력 안햇을 때
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('제목과 내용을 모두 입력해 주세요 :)')");
						script.println("history.back()"); //이전 페이지로 리턴
						script.println("</script>");
					} else {
						BbsDAO bbsDAO = new BbsDAO();
						int result = bbsDAO.getWrite(board.getbTitle(), userID, board.getbContent()); //board.getUserID() 요거랑 userID는 객체가 달라
				//글쓰기에 실패한 경우
						if(result == -1){ 
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('오류가 발생하였습니다.')");
							script.println("history.back()"); 
							script.println("</script>");
						} 
						else {
				//글쓰기 성공!(result==0)
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'bbs.jsp'");
							script.println("</script>");
						} 
					}
		}	
	%>	
</body>
</html>