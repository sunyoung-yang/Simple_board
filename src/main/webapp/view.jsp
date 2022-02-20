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
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크(내정보)
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		//선택 게시글 보기
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
		
		Board board = new BbsDAO().getBoard(bID); //bID가 있는 글의 정보를 board 객체에 담아
		

		
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
			<%
				if(userID == null){
			%>
				<ul class="nav navbar-nav navbar-right">
         		<li class="dropdown">
           			<a href="#" class="dropdown-toggle" 
                                data-toggle="dropdown" role="button" aria-haspopup="true" 
            			aria-expanded="false">접속하기 <span class="caret"></span></a>
        			<ul class="dropdown-menu">
              			<li><a href="login.jsp">로그인</a></li>
              			<li><a href="join.jsp">회원가입</a></li>
            		</ul>    
         		</li>
       			</ul>
			
			<% 
				} else{
					
			%>
				<ul class="nav navbar-nav navbar-right">
         		<li class="dropdown">
           			<a href="#" class="dropdown-toggle" 
                                data-toggle="dropdown" role="button" aria-haspopup="true" 
            			aria-expanded="false"> 회원관리 <span class="caret"></span></a>
        			<ul class="dropdown-menu">
              			<li><a href="logoutAction.jsp">로그아웃</a></li>
            		</ul>    
         		</li>
       			</ul>
			
			<% 
				}
			%>							
		</div>
	</nav>
	
<!-- 게시판 글쓰기 양식 -->
	<div class="container">
	<div class="box">
			<h3><br><br><br></h3>
		</div>
		<div class="row">
				<p> send a letter!</p>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">sena에게 편지 쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">제목</td>
							<td colspan="2"><%= board.getbTitle() %></td>
						</tr>	
						<tr>
<!-- 글쓴이 정보 -->	
						<td >작성자</td>
							<td colspan="2"><%= board.getUserID() %></td> 
						</tr>
						<tr>
							<td >작성일</td>
							<td colspan="2"><%= board.getbDate().substring(0,11)+ board.getbDate().substring(11,13) + "시 "+ board.getbDate().substring(14, 16)+"분 " %></td>
						</tr>	
						<tr>
							<td >내용</td>
							<td colspan="2" style="min-height:200px; text-align: left;"><%= board.getbContent()
							.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>				
					</tbody>
				</table>
				<a href="bbs.jsp" class="home__contact_view">목록</a>
				<%
					if(userID != null && userID.equals(board.getUserID())){
				%>	
					<a href="update.jsp?bID=<%=bID %>" class="home__contact_view">수정</a>	
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bID=<%=bID %>" class="home__contact_view">Delete</a>	
					
				<%
					}
				%>		
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>