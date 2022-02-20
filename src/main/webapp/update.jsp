<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BbsDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>SUNYOUNG'S WORLD</title>
<link rel="icon" type="image/png" href="images/favicons.png" />
</head>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
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
	%>
		<nav id="navbar">
		<div class="navbar">
			<button type="button" class="navbar-toggle collapsed" 
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar__logo" href="main.jsp">SUNYOUNG'S WORLD </a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>			
			</ul>
				<ul class="nav navbar-nav navbar-right">
         		<li class="dropdown">
           			<a href="#" class="dropdown-toggle" 
                                data-toggle="dropdown" role="button" aria-haspopup="true" 
            			aria-expanded="false">회원관리 <span class="caret"></span></a>
        			<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li>            		
					</ul>    
         		</li>
       			</ul>						
		</div>
	</nav>
	
<!-- 게시판 글쓰기 양식 -->
	<div class="container">
	<div class="box">
			<h3><br><br><br></h3>
	</div>
		<div class="row">
			<form method="post" action="updateAction.jsp?bID=<%= bID %>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">sena에게 편지 쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="제목" name="bTitle" maxlength="50" value="<%= board.getbTitle() %>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="내용" name="bContent" maxlength="2048" style="height: 320px;"><%=board.getbContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="home__contact_revise" value="수정">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>