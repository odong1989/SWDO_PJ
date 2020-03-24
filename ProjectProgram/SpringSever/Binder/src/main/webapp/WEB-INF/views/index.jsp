<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value='/css/suggest_Page_Basic.css' />">
	<script src="http://code.jquery.com/jquery-3.4.1.js "> </script>
	<script type="text/javascript">
		$(function() {
			var err = $("#errMsg").val();
			if (err.length != 0) {
				alert(err);
			}
		})
	</script>
	<style>
	body, html {
		height: 100%;
	}
	#loginWrap {
		height: 100%;
		display: table;
		width: 100%;
	}
	#loginDiv{
		display: table-cell;
		vertical-align: middle;
		text-align: center;
	}
	
	.loginForm {
		text-align:center;
		margin: 0 auto;
		background-color: rgba(255, 255, 255, 0.5);
		padding: 25px 25px 10px 25px;
		display: -webkit-inline-box;
	}
	.loginForm tr {
		height:1.5em;
	}
	.loginForm p {
		font-size:12px;
		margin-top: 5px;
	}
	input[type=button], input[type=submit] {
		background-color:white;
		color:black;
		margin: 10px;
		border:1px solid #AAA;
	}
	input[type=text] {
		margin:10px 0;
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
		height: 100%;
	}
	#loginForm1{
		padding-top: 5px;
	}
	#loginForm2{
		
	}
	#loginForm3{
		padding: 0 5px 5px 5px;
	}
	</style>
</head>
<body>
	<div id="loginWrap">	
		<div id="loginDiv">
		<!-- 로그인폼--->
			<form action="<c:url value='/member/memberLoginExe' />" method="post">
			<table class="loginForm">
				<tr>
					<td id="loginForm1">ID</td>
					<td id="loginForm2"><input type="text" name="member_id" ></td>
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
					<td colspan="2"  id="loginForm3"><p><a href="<c:url value='/member/memberFindMyIDorPW' />">아이디/비밀번호 찾기</a></p></td>
				</tr>
			</table>
			</form>
			<input type="hidden" id="errMsg" value="${errMsg }">
		</div>
	</div>
</body>
</html>