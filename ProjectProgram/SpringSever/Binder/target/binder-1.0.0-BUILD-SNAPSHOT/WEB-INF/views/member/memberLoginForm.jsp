<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<h1>
memberLoginForm
</h1>
<!-- 로그인 에러시 에러 메시지 출력--->
<c:if test="${errMsg != null }">
${errMsg}
</c:if>

<!-- 로그인폼--->
<form action="memberLoginExe" method="post">
<table>
	<tr>
		<td>ID : </td>
		<td><input type="text" name="member_id" ></td>
	</tr>
	<tr>
		<td>PW : </td>
		<td><input type="password" name="member_pw"></td>
	</tr>	
	<tr>
		<td><input type="checkbox" name="remember" value="1">아이디 기억하기</td>
		<td><input type="submit" value="로그인 하기"></td>
	</tr>
</table>
</form>
	</div>
</body>
</html>