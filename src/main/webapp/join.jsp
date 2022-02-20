<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <li><a href="bbs.jsp">게시판</a></li>			
            </ul>
		           <ul class="nav navbar-nav navbar-right">
         		<li class="dropdown">
           			<a href="#" class="dropdown-toggle" 
                                data-toggle="dropdown" role="button" aria-haspopup="true" 
            			aria-expanded="false">접속하기 <span class="caret"></span></a>
        			<ul class="dropdown-menu">
              			<li><a href="login.jsp">로그인</a></li>
                        <li class="active"><a href="join.jsp">회원가입</a></li>             		
                    </ul>    
         		</li>
       			</ul>			
		</div>
	</nav>
    
    <div class="container">
    <div class="box">
			<h3><br><br><br></h3>
	</div>
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class ="jumbtron" style="padding-top:20px;">
            
                <form method = "post" action="joinAction.jsp">
                    <h3 style="text-align:center;">회원가입 하기</h3>
                    <p> just one step left to get close to Sena!</p>
                    <div class ="form-group">
                        <input type ="text" class="form-control" placeholder="아이디" name ="userID" maxlength='20'>
                    </div>
                    <div class ="form-group">
                        <input type ="password" class="form-control" placeholder="비밀번호" name ="userPassword" maxlength='20'>
                    </div>
                    <div class ="form-group">
                        <input type ="text" class="form-control" placeholder="이름" name ="userName" maxlength='20'>
                    </div>
                    <div class ="form-group" style="text-align: center;">
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary active">
                                <input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
                            </label>
                            <label class="btn btn-primary">
                                <input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
                            </label>
                            </div>    
                    </div>
                    <div class ="form-group">
                        <input type ="email" class="form-control" placeholder="이메일" name ="userEmail" maxlength='20'>
                    </div>                   
                    <input type="submit" class="home__contact_join" value="회원가입">
                </form>
            </div> 
        </div> 
        <div class="col-lg-4"></div>
    </div> 
   
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</body>
</html>