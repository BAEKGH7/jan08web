
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qna</title>
<link href = "./css/index.css" rel="stylesheet">
<link href = "./css/menu.css" rel="stylesheet">
<script type="text/javascript" src=./js/menu.js></script>
</head>
<body>
	<div class="container"></div>
<header>

<jsp:include page="menu.jsp"></jsp:include>
<!-- jsp:은 출력 결과만 화면에 나옵니다 -->
</header>
	<div class="main">
		<div>
			<article>
				<h1>QnA</h1>
				<h2>2024-01-10</h2>
				<ul>
					<li>톺아보기</li>
					<li>각각 게시판 서블릿, jsp</li>
					<li>글쓰기</li>
					<li>삭제하기</li>
					<li>수정하기</li>
				</ul>
				
			
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

	<h1>문의게시판입니다</h1>
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