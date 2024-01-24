
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="./css/index.css" rel="stylesheet">
<link href="./css/menu.css" rel="stylesheet">
<link href="./css/board.css" rel="stylesheet">

<script type="text/javascript" src=./js/menu.js></script>


</head>
<body>


	<div class="container">
		<header>
			<%@ include file="menu.jsp"%>
			<!-- https://m.blog.naver.com/halowd/221686425368 -->
		</header>
		<div class="main">
			<!-- <div style="width: 500px; margin: 0 auto; padding-tor: 10px"> -->
			<div class="mainStyle">
				<%-- <article>
					for문 연습해보기 <br>
					<c:forEach items="${list }" var="e" varStatus="s">
						${e.no } / ${s.first } / ${s.last } / ${s.index } <br>
					</c:forEach>
				
				
				</article> --%>


				<article>
					<c:choose>
						<c:when test="${fn:length(list) gt 0 }">
							
					<table>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>날짜</th>
									<th>읽음</th>
								</tr>

								<c:forEach items="${list }" var="row">
									<!-- row라고 썼지만 dto라고 함 -->
									<!-- BoardList에서 list 호출이 BoardDTO 변수라서 -->
									<tr>
										<td class="w1">${row.no }</td>
										<td class="title">
										<a href="./detail?page=${page}&no=${row.no}"> ${row.title } 
										<span>
											<c:if test="${row.comment ne 0 }">
												[${row.comment}]
											</c:if>
										</span>
									</a></td>
										<td class="w2">${row.write }</td>
										<td class="w1">${row.date }</td>
										<td class="tw1">${row.count }</td>
									</tr>
								</c:forEach>
							</table>
							전체 글 : ${totalCount } / <br>
							페이지 수 : <c:set var="totalPage" value="${totalCount / 10 }"/>
							<fmt:parseNumber integerOnly="true" value="${totalPage }" var="totalPage"/> <!-- 여기까지만 쓰면 나머지 게시글 페이지가 부족해짐 -->
							<c:if test="${totalCount % 10 gt 0 }"> 
								<c:set var="totalPage" value="${totalPage + 1 }"/>
							</c:if>
							<c:out value="${totalPage }"/>
							
							/ startPage : <c:set var="startPage" value="1"/> 
							<c:if test="${page gt 5 }">
								<c:set var="startPage" value="${page - 5 }"/>
							</c:if>
							${startPage }
							/ endPage : <c:set var="endPage" value="${startPage + 9 }"/> ${endPage }
							<c:if test="${endPage gt totalPage }">
							
								<c:set var="endPage" value="${totalPage }"/>
							</c:if>
							/ page : ${page } <!-- boardlist.java에서 doGet에 request 적어서 param.page 대신 page로 수정.. -->
							
							<div class = "paging">
							<button onclick="paging(1)">🦕</button>
							<button <c:if test="${page - 10 lt 1 }">disabled="disabled"</c:if> onclick="paging(${page - 10 })">🦖</button>
							
								<c:forEach begin="${startPage }" end="${endPage }" var="p">
									<button  <c:if test="${page eq p }"> class="currentBtn" </c:if> onclick="paging(${p })">${p }</button>
									<!-- 버튼을 클릭할 때 마다 el태그로 찍은 p 숫자를 사용할 수 있도록 -->
								</c:forEach>
								<button 
								<c:if test="${page + 10 gt totalPage }" > disabled="disabled"</c:if> onclick="paging(${page + 10 })">🛩️</button>
								<button onclick="paging(${totalPage })">🚀</button>
								
							</div>
							
							
						</c:when>
						<c:otherwise>
							<h1>출력할 값이 없습니다.</h1>
						</c:otherwise>
					</c:choose>

					<c:if test="${sessionScope.mname ne null }">
					<button onclick="url('./write')">글쓰기</button>
					</c:if>

					${sessionScope.mname }님 반갑습니다.
				</article>

				<article>
					<fmt:requestEncoding value="UTF-8" />
					<fmt:setLocale value="ko_kr" />
					<fmt:formatNumber value="3.14" type="number" />
					<fmt:parseNumber value="3.14" integerOnly="true" />

					<c:set var="nowDate" value="<%=new Date()%>" />
					${nowDate } <br>
					<fmt:formatDate type="time" value="${nowDate }" />
					<br>
					<fmt:formatDate type="date" value="${nowDate }" />
					<br>
					<fmt:formatDate type="both" value="${nowDate }" />
					<br>
					<fmt:formatDate type="both" dateStyle="short" timeStyle="short"
						value="${nowDate }" />
					<br>
					<fmt:formatDate type="both" dateStyle="medium" timeStyle="medium"
						value="${nowDate }" />
					<br>
					<fmt:formatDate type="both" dateStyle="long" timeStyle="long"
						value="${nowDate }" />
					<br>
					<fmt:formatDate pattern="yyyy-MM-dd" value="${nowDate }" />
					<br>
				</article>
				<%-- <article>
					fn이용해서 자료형 데이터 길이 뽑아내기
					${fn:length(list) }<br>
					<c:choose>
						<c:when test="${fn:length(list) gt 0 }">
							참일 때
						</c:when>
						<c:otherwise>
							<h1>출력할 값이 없습니다.</h1>
						</c:otherwise>
					</c:choose>
					
				</article> --%>


			</div>
		</div>
	<footer>
		<c:import url="footer.jsp"/>
	</footer>
	</div>
	<script type="text/javascript">
		function paging(no) {
			location.href="board?page="+no;
		}
	</script>

</body>
</html>