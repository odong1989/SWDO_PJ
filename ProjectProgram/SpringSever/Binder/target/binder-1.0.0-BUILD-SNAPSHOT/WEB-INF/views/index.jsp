<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value='/css/suggest_Page_Basic.css' />">
	<script src="http://code.jquery.com/jquery-3.4.1.js "> </script>
	<style>
	#loginDiv {
		height:100%;
	}
	#loginForm {
		text-align:center;
		margin: auto;
	}
	#loginForm tr {
		height:1.5em;
	}
	p {
		font-size:12px;
	}
	input[type=button], input[type=submit] {
		background-color:white;
		color:black;
		margin: 10px;
	}
	a:link{
    color:inherit;
    text-decoration: none;
	}
	a:active{
	    color:inherit;
	    text-decoration: none;
	}
	a:hover{
	    text-decoration: none;
	}
	a:visited{
	    text-decoration: none;
	    color:inherit;
	}
	body{
		background-color:#D9E5FF; 
		background-image: url("<c:url value='/img/couple-1822585_1920.jpg' />");
		background-size: cover;
		background-repeat: no-repeat;
	}
	</style>
</head>
<body>


	<!-- 로그인 에러시 에러 메시지 출력--->
	<c:if test="${errMsg != null }">
	${errMsg}
	</c:if>
	
	<!-- 로그인폼--->
	<div id="loginDiv">
		<form action="<c:url value='/member/memberLoginExe' />" method="post">
		<table id="loginForm">
			<tr>
				<td>ID</td>
				<td><input type="text" name="member_id" ></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" name="member_pw"></td>
			</tr>	
			<tr>
				<td colspan="2">
					<input type="submit" value="로그인">
					<a href="<c:url value='/member/memberJoinForm' />"><input type="button" value="회원가입하기"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2"><p><a href="<c:url value='/member/memberFindMyIDorPW' />">아이디/비밀번호 찾기</a></p></td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>