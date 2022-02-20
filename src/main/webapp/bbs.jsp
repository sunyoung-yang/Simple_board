<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BbsDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>SUNYOUNG'S WORLD</title>
<link rel="icon" type="image/png" href="images/favicons.png" />
<style type="text/css">
	a, a:hover {
		color: black;
		text-decoration: none;
	}
</style>
<script
      src="https://kit.fontawesome.com/9eb162ac0d.js"
      crossorigin="anonymous"
    ></script>
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap"
      rel="stylesheet"
    />
</head>
<body>
	<%
	//세션 처리
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	//페이징 처리
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); //정수로 변환
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
	
	<div class="container">
	<div class="box">
			<h3><br><br><br><br></h3>
		</div>
		<div class="row">
		<p> send a letter!</p>
			<table class="table table-striped" style="text-align: center; border: 1px sold #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align:center;">번호</th>
						<th style="background-color: #eeeeee; text-align:center;">제목</th>
						<th style="background-color: #eeeeee; text-align:center;">작성자</th>
						<th style="background-color: #eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO(); //BbsDAO클래스의 인스턴스를 사용하기위해 객체 생성
						ArrayList<Board> list = bbsDAO.getList(pageNumber); //bbsDAO의 getlist()를 끌고오기 위해 list객체 생성이 아닌 명시 한 후 return값 끌고와
						for(int i=0; i<list.size(); i++){
					%>					
						<tr>
							<td><%= list.get(i).getbID() %></td>
							<td><a href="view.jsp?bID=<%= list.get(i).getbID()%>"><%= list.get(i).getbTitle() %></a></td>
							<td><%= list.get(i).getUserID() %></td>
							<td><%= list.get(i).getbDate().substring(0,11)+ list.get(i).getbDate().substring(11,13) + "시 "+ list.get(i).getbDate().substring(14, 16)+"분 " %></td>
						</tr>
					<% 
						}
					%>	
				</tbody>
			</table>
			<%
			//이전 페이지로 돌아가도록 페이징
				if(pageNumber != 1){
			%>	
				<a href="bbs.jsp?pageNumber=<%=pageNumber -1 %>" class="home__contact">Pre</a>
			
			<% 
				} if(bbsDAO.nextPage(pageNumber+1)){
			%>		
				<a href="bbs.jsp?pageNumber=<%=pageNumber +1 %>" class="home__contact">Next</a>
			<% 
				}	
			%>
	
			<a href="write.jsp" class="home__contact_back">글 작성</a>
		</div>
	</div>
	
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>