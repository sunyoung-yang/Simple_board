<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="board.BbsDAO" %>
    <%@ page import="board.Board" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('먼저 로그인 하세요')");
			script.println("location.href= 'login.jsp'"); 
			script.println("</script>");
		} 
		int bID = 0;
		if(request.getParameter("bID") != null){
			bID = Integer.parseInt(request.getParameter("bID"));
		}
		if(bID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당 게시글이 존재하지 않습니다.')");
			script.println("location.href=bbs.jsp");
			script.println("</script>");
		}
		
		//내가 이글을 작성하지 않았다면
		Board board = new BbsDAO().getBoard(bID);
		if(!userID.equals(board.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href=bbs.jsp");
			script.println("</script>");
		}
		else{					
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.delete(bID);
		//글쓰기에 실패한 경우
			if(result == -1){ 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('해당 게시글 삭제에 실패하였습니다.')");
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
			
	%>	
</body>
</html>