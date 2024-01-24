
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link href = "./css/index.css" rel="stylesheet">
<link href = "./css/menu.css" rel="stylesheet">
<script type="text/javascript" src=./js/menu.js></script>
</head>
<body>
	<div class="container"></div>
<header>
<%@ include file="menu.jsp"%>
<%-- <jsp:include page="menu.jsp"></jsp:include> --%> <!-- menu.jsp가 다 나오면 붙여라 라는 뜻? -->
<!-- jsp:은 출력 결과만 화면에 나옵니다 -->
</header>
	<div class="main">
		<article>
			<h1>
			<c:forEach begin='1' end='5' var='h'>
			${h }
			</c:forEach>
			
				서버에서 보내준 map: ${map } <br>
				
				<c:forEach items="${map }" var="i">
					이름 : ${i.name }<br>
					나이 : ${i.age }<br>
					주소 : ${i.addr }<br>
				</c:forEach>
				
				<c:set value="${map }" var="m" scope="page"></c:set>
				<c:out value="${m }"></c:out> <br>
				<c:out value="${m[1]['addr'] }"></c:out>
				<br><br><br><br>
				${sessionScope.m }
				
				session -> jwt
				
				<c:if test="">
				</c:if>
				
				if(){
					참일때 실행
				}
				
				<c:choose>
					<c:when test=""></c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
				
				
				
			</h1>
		</article>
	
	
		<div>
			<article>
			
				<c:set var="number" value="105"/>
				
				<c:out value="${number }"/><br>
				
				<c:forEach begin="1" end="9" var="row" step="1">
				2 x	${row } = ${row * 2}<br>
				</c:forEach>
				
				<c:if test="${number eq 105 }">
					number는 105입니다.<br>
					<!-- 
					eq == 같다 
					ne != 같지 않다 
					lt < 작다
					gt > 크다
					le <= 작거나 같다
					ge >= 크거나 같다  
					
					결과값은 boolean으로 나옴
					
					&&
					||
					empty
					not empty
					
					-->
				</c:if>
				
				<hr>
				1~45까지 짝수만 출력하세요 foreach, if 써서
				<br>
				
				<c:forEach begin="1" end="45" var="asdf">
				 <c:if test="${asdf % 2 eq 0 }">
					${asdf }<!-- <br> -->
				 </c:if>
				</c:forEach>
				
				
			
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