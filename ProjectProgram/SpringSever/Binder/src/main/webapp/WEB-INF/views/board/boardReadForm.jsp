<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 첨부파일을 조건부처리 하기 위해 사용합니다. -->    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글읽기(boardReadForm)</title>
	<link rel="stylesheet" href="/resources/css/style_ver3.css">	
<script src="<c:url value='/resources/js/jquery-3.4.1.js' /> "> </script>
	<script>
	function writeReply(){
	 window.open("boardReplyForm","newWin","left=300, top=300, width=500, height=300, resizeable=no");
	 }
	function fileDownLoad(board_no){
		location.href = "download?board_no="+board_no;
	}

	function boardDelete(board_no){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href = "boardDelete?board_no="+board_no;	
			}
	}

	function boardUpdateForm(board_no){
		location.href ="boardUpdateForm?board_no="+board_no;	
	}

	function replyDelete(reply_no,board_no){
		if(confirm("정말 삭제하시겠습니까?")){		
		location.href ="replyDelete?reply_no="+reply_no+"&board_no="+board_no;
		}
	}
	function replyUpdateForm(reply_no, board_no, reply_content){
		console.log("reply_no :" + reply_no, 
					"board_no :" + board_no,
					"reply_content :" + reply_content); 

		//스텝1. 리플번호를 받습니다.
		var updateForm = document.getElementById("updateForm"+reply_no);

		//id는 복붙이 낫다. 어제 에러이유보니 updateForm이 아니라 UpdateForm이라서 대문자하나달라서 인식못했음...
		console.log(updateForm); 
		//온 클릭하면 실행할 폼내용을 넣습니다
		var str = ''; 
		    str += '<form action="replyUpdate" method="post">';								//console.log(str); 
			str += '<input type="hidden" name="reply_no" value="'+reply_no+'">';			//console.log(str);//20.2.13 추가/해당 리플만 삭제위해 필요
			str += '<input type="hidden" name="board_no" value="'+board_no+'">';			//console.log(str);//20.2.13추가/삭제후 본 페이지로 리턴위해 필요/
			str += '<input type="text" name="reply_content" value="'+reply_content+'">';	//console.log(str);
			str += '<input type="submit", value="수정">';										//console.log(str);
			str += '<input type="button", value="취소", onclick="updateCancel(\''+reply_no+'\')">';
			str += '</form>';																//console.log(str);
			updateForm.innerHTML = str;

	}


	function updateCancel(reply_no){
	var updateForm = document.getElementById("updateForm"+reply_no);
	if(confirm("리플 수정을 취소합니까?")){		
		updateForm.innerHTML = '';	
		}

	}	
</script>
</head>

<body>
	<div class="header">
		<div class="Logo">
		<a href="/"><img src="/resources/img/logo.jpg" width="100" ></a>
		</div>
		<div class="Menubar">
		<table>
			<c:choose>
			<c:when test="${sessionScope.loginId == null}">
				<tr>
					<td><a href="/member/memberLoginForm">로그인하기</a></td>
					<td><a href="/member/memberJoinForm">회원가입하기</a></td>
				</tr>
			</c:when>
			<c:otherwise> 
				<tr>
					<td>${sessionScope.loginId}님 환영합니다!</td>		
					<td><a href= "/member/memberMypage">MyPage</a></td>		
					<td><a href="/board/boardList">게시판 이동</a></td>
					<td><a href="/member/memberLogout">로그아웃</a></td>
				</tr>
				</c:otherwise>
			</c:choose>
		</table>
		</div>
	</div>
<br><br><br>
<hr>
<h1>글 읽기</h1>
<hr>
	<table>		
		<tr>
			<td>글 제목 : </td>
			<td>${board.BOARD_TITLE } </td>
		</tr>
		<tr>
			<td>글 내용 : </td>
			<td> ${board.BOARD_CONTENT }</td>
		</tr>
		<tr>
			<td>글쓴이  : </td>
			<td>${board.MEMBER_NM }</td>
		</tr>
		<tr>
			<td>조회수  : </td>
			<td>${board.BOARD_HITS }</td>
		</tr>
		<tr>
			<td>작성일  : </td>
			<td>${board.BOARD_INDATE } </td>		
		</tr>
		<tr>
			<td>첨부파일 : </td>
			<td><c:if test="${board.BOARD_SAVEDFILE !=null}">
					<a href="javascript:fileDownLoad(${board.BOARD_NO})">
					${board.BOARD_ORIGINFILE } </a>
				</c:if>			
			</td>
		</tr>
		<c:if test="${board.MEMBER_ID==sessionScope.loginId}">
		<tr>
			<td><input type="button" value="글 수정하기" onclick="boardUpdateForm('${board.BOARD_NO}')"> </td>
			<td><input type="button" value="글 삭제하기" onclick="boardDelete('${board.BOARD_NO}')"></td>		
		</tr>
		</c:if>		
	</table>

	<br>
	<table>
			<tr>
				<th>리플번호</th>
				<th>작성자</th>
				<th>리플내용</th>
				<th>작성일</th>
				<th>댓글수정</th>				
				<th>댓글삭제</th>
			</tr>
		<c:forEach items="${replyList}" var="reply">
			<tr>
				<td>${reply.reply_no }</td>
				<td>${reply.member_id }</td>
				<td>${reply.reply_content }</td>
				<td>${reply.reply_indate }</td>
				<td>
						<c:if test="${reply.member_id == sessionScope.loginId }">
						
							<input type="button", value="수정", onclick="replyUpdateForm('${reply.reply_no}','${reply.board_no}','${reply.reply_content}')">
						</c:if>
					</td>
					<td>
						<c:if test="${reply.member_id == sessionScope.loginId }">
							<input type="button", value="삭제", onclick="replyDelete('${reply.reply_no}','${reply.board_no}')">
						</c:if>	
					</td>
				</tr>	
				<tr>
					<td id="updateForm${reply.reply_no}" colspan="6">
					</td>
				</tr>	
			</c:forEach>
			<tr>		
			<form action="replyInsert" method="post" >
				<td colspan="4"><input type="hidden" name="board_no" value="${board.BOARD_NO }">
								<input type="text" name="reply_content" placeholder="댓글을 달아 주세요!!"></td>
				<td colspan="2"><input type="submit" value="댓글등록" ></td>
			</form>			
			</tr>
		</table>		
</body>
</html>