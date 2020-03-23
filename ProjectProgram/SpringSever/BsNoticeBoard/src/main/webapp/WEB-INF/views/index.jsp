<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="/css/style_ver3.css">
	<script src="/js/jquery-3.4.1.js "> </script>
	<style>
	body{
		background-color:#D9E5FF; 
		background-image: url("../img/couple-1822585_1920.jpg");
		background-size: 50%;
		background-repeat: no-repeat;
	}
	.join{
		padding:20px;
	}
	</style>
</head>
<body>


<div class="bgimg">
	<div class="header">
			<div class="Logo">
				<a href="/">
				<img src="/img/logo.jpg" width="100">
				</a>
			</div>
		
	<!-- 로그인 에러시 에러 메시지 출력--->
	<c:if test="${errMsg != null }">
	${errMsg}
	</c:if>
	
		<!-- 로그인폼--->
		<div class="join">
			<form action="/member/memberLoginExe" method="post">
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
				<tr>
					<td><a href="/member/memberJoinForm"><input type="button" value="회원가입하기"></a></td>
					<td><a href="/member/memberFindMyIDorPW"><input type="button" value="아이디/비밀번호 찾기"></a></td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</div><!-- <div class="bgimg"> -->
</body>
</html>