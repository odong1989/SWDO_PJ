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
	     var result = confirm("정말 회원탈퇴하시겠습니까?");//신규창으로 띄워서 예/아니오 받도록한다.
	     if(result){
	         alert("회원탈퇴를 진행합니다.");
	         location.href="/member/memberWdraw";
	     }else{
	         alert("회원탈퇴가 취소되었습니다.");
	     }
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

		<tr>
			정상변경되는지 확인을 위해 추가되었습니다.
			<td>사진 : </td>
			<td>${MemberData.member_photo}</td>
		</tr>
		<tr>
			<td>생일 : </td>
			<td>${MemberData.member_birthday}</td>
		</tr>
		<tr>
			<td>결혼여부 : </td>
			<td>${MemberData.member_married}</td>
		</tr>
		<tr>
			<td>결혼일 : </td>
			<td>${MemberData.member_weddingday}</td>
		</tr>
		<tr>
			<td>가입일(regdate): </td>
			<td>${MemberData.member_regdate}</td>
		</tr>
		<tr>
			<td>마지막로그인 : </td>
			<td>${MemberData.member_lastlogin}</td>
		</tr>
		<tr>
			<td>현회원여부 </td>
			<td>${MemberData.member_wdraw}</td>
		</tr>
	</table>	
	<a href="<c:url value='/member/mypageUpdateProfile' />">회원정보 수정</a><br>
		<input type="button" value="회원탈퇴" onclick="Withdrawal()"> 
		<a href="/document/mainDocument"><input type="button" value="메인페이지로 리턴"> 		
	</body>
</html>