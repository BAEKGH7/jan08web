
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>info</title>
<link href = "./css/index.css" rel="stylesheet">
<link href = "./css/menu.css" rel="stylesheet">
<script type="text/javascript" src=./js/menu.js></script>
</head>
<body>
	<div class="container"></div>
<header>
<%@ include file="menu.jsp"%>
<%-- <jsp:include page="menu.jsp"></jsp:include> --%>
<!-- jsp:은 출력 결과만 화면에 나옵니다 -->
</header>
	<div class="main">
		<div class="mainStyle">>
			<article>
				<h1>info</h1>
				
				<div class="work">
					<div class="left">
						<h2>남은 것</h2>
						<ul>
							<li>xml / json</li>
							<li>관리자페이지</li>
							<li>파일 업로드</li>
							<li>MVC패턴</li>
							<li>스프링-레거시</li>
							<li>lombok</li>
							<li>mybatis</li>
							<li>스프링-부트</li>
							<li>thymeleaf</li>
							<li>jpa</li>
							<li>리눅스</li>
							<li>aws</li>
							<li>vue</li>
						</ul>	
					</div>
				
				</div>
				<div>
				<ul>
					<li>myinfo에 읽은 글 띄우기</li>
					<li> >, < 태그 막기</li>
					<li>게시판으로 버튼</li>
					<li>ip넣기</li>
					<li>ip바꾸기</li>
				</ul>
				</div>
				
				<div class="did">
				
				
				<h2>2024-01-17</h2>
				<ul>
					<li>페이징</li>
					<li>bootstrap</li>
					<li>Jquery</li>
					<li>회원가입</li>
					<li>AJAX</li>
					<li>관리자모드-회원관리</li>
					<li>관리자모드-글관리</li>
				</ul>
				
				
				<h2>2024-01-16</h2>
				<ul>
					<li>세션 사용해서 수정, 삭제 막기</li>
					<li>내 정보 보기</li>
					<li>페이징</li>
				</ul>
				
				<h2>2024-01-15</h2>
				<ul>
					<li>세션으로 로그인 만들기</li>
					<li>board 테이블 변경</li>
					<li>내 정보 보기</li>
				</ul>
				
				<h2>2024-01-10</h2>
		
				<ul>
					<li>톺아보기</li>
					<li>각각 게시판 서블릿, jsp</li>
					<li>글쓰기</li>
					<li>삭제하기</li>
					<li>수정하기</li>
				</ul>
						
					
				</div>
			
			</article>
			<article>
				<c:import url="menu.jsp"/>
				<br>
				<c:forEach begin="1" end="10" var="row" varStatus="s">
				<%-- ${s.index } <br> --%>
				<%-- ${s.count } <br> --%>
				${s.begin } / ${s.end } <br>
				
				</c:forEach>
				
			</article>
			<article>
				article
			</article>
			<article>
				article
			</article>
			
		
		</div>
	
	
	
	</div>

	<h1>index입니다</h1>
<%-- 	<%
	DBConnection db = DBConnection.getInstance();
	Connection conn = db.getConnection();
	
	Connection conn2 = DBConnection.getInstance().getConnection();
	
	%> --%>

	<a href = "./board">board</a>
	<footer>
	<c:import url="footer.jsp"/>
	</footer>

</body>
</html>