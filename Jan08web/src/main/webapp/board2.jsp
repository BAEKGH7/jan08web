<!-- board2는 24-01-08 수업내용임. 9일에 내용 수정하여서 파일 백업해둠 -->
<%@page import="com.poseidon.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.poseidon.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href = "./css/menu.css" rel="stylesheet">
<script type="text/javascript" src=./js/menu.js></script>


</head>
<body>
	<%
	List<BoardDTO> lists = (List<BoardDTO>) request.getAttribute("list");
	%>
	
	<div class = "container">
		<header>
			<%@ include file="menu.jsp" %>
		
		</header>
		<div class="main">
			<div>
				<article>
					<table>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>글쓴이</th>
							<th>날짜</th>
							<th>읽음</th>						
						</tr>
						<%
						for(BoardDTO e : lists){
						%>
						<tr>
							<td><%=e.getNo() %></td>
							<td><%=e.getTitle() %></td>
							<td><%=e.getWrite() %></td>
							<td><%=e.getDate() %></td>
							<td><%=e.getCount() %></td>
						</tr>
						<%
						} 
						%>
					</table>
				</article>
			</div>
		</div>
		<footer>
		
		</footer>
	</div>

</body>
</html>