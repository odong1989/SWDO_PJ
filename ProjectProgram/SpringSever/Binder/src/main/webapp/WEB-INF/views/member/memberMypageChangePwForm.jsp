<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my페이지입니다.</title>
	<link rel="stylesheet" href="/resources/css/style_ver3.css">	
	<script src="<c:url value='/resources/js/jquery-3.4.1.js' /> "> </script>
<script>
function formCheck(){//id및 입력사항 유효성 검사체크
    var member_pw = document.getElementById("member_pw");
	if(member_pw.value.length<3 || member_pw.value.length>=11){
		alert("비밀번호는4~10자리로 해주세요");
		return false;
	}
    return true;
}
</script>
</head>
<body>
<div>
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
<table>	
	<form action="memberMypageChangePassword" method="post" onsubmit="return formCheck();">
<!-- <tr>
		<td>현재 비밀번호</td>
		<td><input type="password" id="member_pw" name="member_pw" placeholder="현재의 비밀번호입니다."></td>
	</tr> -->
	<tr>
		<td>변경하실 비밀번호</td>
		<td><input type="password" id="member_pw" name="member_pw" placeholder="비밀번호는4~10글자로 해주세요"></td>
	</tr>
	<tr>
		<td colspan="2"> <input type="submit" value="비밀번호 변경"></td>
	</tr>
	</form>
</table>
</body>
</html>