<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my페이지입니다.</title>
	<script src="http://code.jquery.com/jquery-3.4.1.js "> </script>
<script type="text/javascript">
     function Withdrawal(){
		alert("정말 회원탈퇴하시겠습니까?");//신규창으로 띄워서 예/아니오 받도록한다.
	}
</script>
</head>
<body>
<!-- 
INFO : net.softsociety.binder.dao.MemberDAO - BoardDAO.java - memberSelectOne 
리턴 member값 : Member(member_id=jsh4646, member_pw=123123, member_name=정수환, 
member_mail=jsh4646@naver.com, member_photo=/dahyun.png, member_phone=null, 
member_birthday=1991-11-22, member_married=0, member_weddingday=null, member_regdate=2020-03-22, member_lastlogin=2020-03-20, member_wdraw=0)
 -->
	<table>
		<tr>
			<td>아이디 : </td>
			<td>${MemberData.member_id}</td>
		</tr>
		<tr>
			<td>이름 : </td>
			<td>${MemberData.member_name}</td>
		</tr>

		<tr>
			<td>이메일 : </td>
			<td>${MemberData.member_mail}</td>
		</tr>
	</table>	
		<a href="/member/mypageUpdateProfile">회원정보 수정</a><br>
		<input type="button" value="회원탈퇴" onclick="Withdrawal();"> 
	</body>
</html>