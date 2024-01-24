<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link href="./css/index.css" rel="stylesheet"/>
<link href="./css/menu.css" rel="stylesheet"/>
<script type="text/javascript" src="./js/menu.js"></script>
<style type="text/css">
.login{
	margin: 0 auto;
	width: 300px;
	min-height: 300px;
	background-color: #c1c1c1;
	padding: 10px;
	box-sizing: border-box;
	text-align: center;
}

.login input{
	width: 100%;
	height: 30px;
	text-align: center;
	color: green;
	margin-bottom: 10px;
	box-sizing: border-box;
}
.login button{
	width: 45%;
	height: 30px;
	color: green;
	font-size: large;
}
</style>
</head>
<body>
	<div class="container">
		<header>
			<jsp:include page="menu.jsp"></jsp:include>
			<!-- jsp:은 출력 결과만 화면에 나옵니다. -->
		</header>
		<div class="main">
			<div class="mainStyle">
				<article>
					<h1>login</h1>
					${param.error }
					<div class="login">
						<form action="./login" method="post">
							<img alt="login" src="./img/login.png" width="200px">
							<input type="text" name="id">
							<input type="password" name="pw">
							<button type="reset">지우기</button>
							<button type="submit">로그인</button>
						</form>
					</div>
					
				</article>
			</div>
		</div>
		<footer>
		
		</footer>
	</div>
</body>
</html>