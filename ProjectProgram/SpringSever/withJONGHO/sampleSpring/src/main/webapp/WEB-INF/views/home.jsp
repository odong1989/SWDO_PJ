<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sample Project</title>
</head>
<body>
<h1>[ Spring과 Mybatis를 이용한 Web Application 예제]</h1>
<a href="iftest">iftest</a>
<ul>
<c:choose>
	<c:when test="${sessionScope.loginId == null }">
		<li><a href="/member/memberJoinForm">회원가입폼 이동</a></li>
		<li><a href="/member/memberLoginForm">로긴</a></li>
	</c:when>
	<c:otherwise>
		로그인 전용메뉴
		<li><a href="/board/boardList">게시판 가즈아</a></li>
		<li><a href="/member/memberLogout">록앗</a></li>	
	</c:otherwise>
</c:choose>
</ul>
</body>
</html>