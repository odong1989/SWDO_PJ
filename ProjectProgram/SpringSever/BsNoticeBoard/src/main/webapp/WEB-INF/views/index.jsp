<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>index페이지입니다</title>
	<link rel="stylesheet" href="/resources/css/style_ver3.css">		
	<script src="<c:url value='/resources/js/jquery-3.4.1.js' /> "> </script>
	<script>
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


<div class="noticeTalkType">
<h4>[채팅창형 게시판 안내(구현미완)]</h4>
 	<div class="TalkBox byBoard">게시판 최신글1</div>
	
 	<div class="TalkBox byBoard">게시판 최신글2</div>

 	<div class="TalkBox byMe">최신글2에 대한 나의 댓글</div>

	 <div class="TalkBox byBoard">게시판 최신글3</div>

</div>

</body>
</html>