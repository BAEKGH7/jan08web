<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>톺아보기</title>
<link href="./css/index.css" rel="stylesheet" />
<link href="./css/menu.css" rel="stylesheet" />
<link href="./css/detail.css" rel="stylesheet" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="./js/menu.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
$(document).ready(function(){
	//alert("준비되었습니다");
	
	$(".commentEdit").click(function(){
		if(confirm('수정하시겠습니까?')) {
			//필요한 값 cno잡기 
			let cno = $(this).siblings(".cno").val();
			//comment로 가려면
			let comment = $(this).parents(".chead").next().text();
			alert(cno + " : " + comment);
			
			// 수정한 내용 + 로그인 === 서블릿에서 정리
			
			
			
		}
	});
	
	
	
	
	
	
	
	
	$(".commentDelete").click(function(){
		//alert("삭제버튼을 눌렀습니다.");
		//부모객체 찾아가기 = this
		//$(this).parent(".cname").css('color', 'green'); //댓글삭제 누르면 부모->cname(닉네임)색변경됨
		//$(this).parent(".cname").text("변경가능");
		//let text = $(this).parent(".cname").val(); //value 지정은 div에서 안됨. 
		
		
		if(confirm("삭제 하시겠습니까?")) {
			
		let text = $(this).parent(".cname").text(); //html(); 쓰면 내용이 다 나옴..
		//alert(text);
		//부모요소 아래 자식 요소 찾기 children()
		//let cno = $(this).parent(".cname").children(".cno").val();
		//let cno = $(this).parent().children(".cno").val(); //부모에 parameter 없는 버전.. 이것도 됨..
		//형제요소 찾기 .siblings()  .prev()  바로 이전  .next() 바로 다음
		//let cno = $(this).siblings(".cno").val();
		let cno = $(this).prev().val(); //value가 되는 이유는 input 창이기 때문에..?
		//alert(cno);
		//가상 form만들어서 post로 전송하겠습니다.
		//..가 아니라 ajax 사용
		let point = $(this).closest(".comment");
		$.ajax({ //이름이 정해져있어서 밑에 순서는 상관 없음
			url : './commentDel',	// 주소
			type : 'post',			// get, post
			dataType : 'text',		// 수신타입 json
			data: {no:cno},			// 보낼 값
			success: function(result){ //0, 또는 1을 받아옴(commentDel에서)
				//alert("서버에서 온 값 : " + result);
				if(result ==1) {
					//정상삭제 : this의 부모를 찾아서 remove하겠습니다.
					//$(this).closest(".comment").hide(); //숨기기
					//$(this).closest(".comment").remove(); //실제 삭제
					//alert(e);
					point.remove();
				} else {
					alert("삭제할 수 없습니다. 관리자에게 문의하세요");
				}
				
			},
			error: function(request, status, error){ //통신 오류
				alert("문제가 발생했습니다.");
			}
		}); //end ajax
		}
		
		
	});
	
	
	//댓글쓰기 버튼을 누르면 댓글 창 나오게 하기 2024-01-24
	$(".comment-write").hide(); //댓글창 숨김
	//$()".comment-write").show(5000);
	
	$(".xi-comment-o").click(function() { //댓글쓰기 버튼을 눌렀을때 f
		$("xi-comment-o").hide(); //댓글쓰기 창 숨기기
		//$(".comment-write").show; //댓글 창이 보여짐
		$(".comment-write").slideToggle('slow'); //댓글창이 천천히 보여짐
	});
	
	+
	
	
	$("#comment-btn").click(function(){
		let content = $("#commentcontent").val();
		let bno = ${detail.no }; //여기는 글번호
		//alert("content : " + content + " no : " + no);
		//가상 form 만들기 = 동적생성
		//전송 ---> content가 5글자 이상인 경우 실행하겠습니다.
		if(content.length < 5){
			alert("댓글은 다섯글자 이상으로 적어주세요.");
			$("#commentcontent").focus();
			//return false;
		} else {
			let form = $('<form></form>');
			form.attr('name', 'form');
			form.attr('method', 'post');
			form.attr('action', './comment');
			
			form.append($('<input/>', {type:'hidden', name:'commentcontent', value:content}));//json
			form.append($('<input/>', {type:'hidden', name:'bno', value:bno}));
			
			form.appendTo("body");
			form.submit();
			
			/* let form = document.createElement('form');
			form.name='form';
			form.method='post';
			form.action='./comment';
			//붙이기
			let text = document.createElement('input');
			text.setAttribute("type", "hidden");
			text.setAttribute("name", "commentcontent");
			text.setAttribute("value", content);
			//붙이기
			let no = document.createElement('input');
			no.setAttribute("type", "hidden");
			no.setAttribute("name", "bno");
			no.setAttribute("value", ${detail.no});
			//form에다가 붙이기
			form.appendChild(text);
			form.appendChild(no);
			//전송하기
			document.body.appendChild(form);
			form.submit(); */
		}
	});
});


</script>
<script>
function back() {
	  history.back();
}
</script>
</head>
<body>
	<div class="container">
		<header>
			<%@ include file="menu.jsp"%>
		</header>
		<div class="main">
			<div class="mainStyle">
				<article>
					<div class="detailDIV">
						<div class="detailTITLE">
							${detail.title }
						</div>
						<div class="detailWRITECOUNT">
							<div class="detailWRITE">
							${detail.write }
							
							
							
							<c:if test="${sessionScope.mname ne null && detail.mid eq sessionScope.mid }">
								<img alt="삭제" src="./img/delete.png" onclick="del()">
								<img alt="수정" src="./img/edit.png" onclick="update()">
							</c:if>
							
							</div>
							<div class="detailCOUNT">${detail.ip } / ${detail.count }</div>
						</div>
						<div class="detailCONTENT">
							${detail.content }
						</div>
					</div>
					<c:if test="${sessionScope.mid ne null }">
					<button class="xi-comment-o">댓글쓰기</button>
					<!-- 댓글쓰는 창을 여기다가 만들어주겠습니다. 댓글내용, 누가, 어느, 2024-01-22 -->
					<div class="comment-write">
						<div class="comment-form">
							<textarea id="commentcontent" name="commentcontent"></textarea>
							<button id="comment-btn">댓글쓰기</button>
						</div>
					</div>
					</c:if>
					<!-- 댓글 출력창 -->
					<div class="comments">
						<c:forEach items="${commentList }" var="co">
							<div class="comment">
								<div class="chead">
									<div class="cname">${co.mname }님 
										<c:if test="${sessionScope.mname ne null && co.mid eq sessionScope.mid }">
											<input type="hidden" class="cno" value="${co.cno }">
											<img alt="삭제" src="./img/delete.png" class="commentDelete">
											<img alt="수정" src="./img/edit.png" class="commentEdit)">
										</c:if>
									</div>
									<div class="cdate">${co.ip } / ${co.cdate }</div>
								</div>
								<div class="ccomment">${co.ccomment }</div>
							</div>
						</c:forEach>
					
					</div>
					<article>
						하단 foot때문에 안 보인다면 추가 <br><br>
					</article>
					<button onclick="url('./board')">게시판 1페이지로</button>
					<button onclick="url('./board?page=${param.page}')">게시판으로</button>
				</article>
			</div>
		</div>
		<footer>
		<c:import url="footer.jsp"/>
		</footer>
	</div>
	
	<script type="text/javascript">
		function del(){
			//alert("삭제를 눌렀습니다");
			var ch = confirm("글을 삭제하시겠습니까?"); 
			if(ch){				
				location.href="./delete?no=${detail.no }";
			}
		}
		function update(){
			if(confirm("수정하시겠습니까?")){
				location.href="./update?no=${detail.no }";
			}
		}
	/* 	function commentDel(cno){
			if(confirm("댓글을 삭제하시겠습니까?")){
				location.href='./commentDel?no=${detail.no}&cno='+cno;
			}
			
		} */
	</script>
</body>
</html>