<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>회원가입페이지입니다</title>
<script src="/js/jquery-3.4.1.js "> </script>
	<script>
function idCheck(){//id중복확인 버튼클릭시 생성되는 ID중복 확인팝업창.
	 window.open("memberidCheckForm","newWin","left=300, top=300, width=500, height=300, resizeable=no");
	 }
function formCheck(){//id및 입력사항 유효성 검사체크
	var member_id = document.getElementById("member_id");
    var member_pw = document.getElementById("member_pw");
    var member_nm = document.getElementById("member_nm");
    var member_addr = document.getElementById("member_addr");
	if(member_id.value.length==0 ){
		alert("ID 중복체크를 해야 회원가입이 가능합니다!");
		return false;
	}
	if(member_pw.value.length<3 || member_pw.value.length>=11){
		alert("비밀번호는4~10자리로 해주세요");
		return false;
	}
	if(member_nm.value =="" || member_nm.length==0){
		alert("이름을 입력해주세요!");
		return false;
	}
	if(member_addr.value ==""){
		alert("주소를 입력해주세요!");
		return false;
	}
    return true;
}
</script>
<style>
	input[type=text], input[type=password] {
		width: 200px;
		height: 2em;
		padding: 20px 0 20px 10px;
		border-radius: 4%;
	}
</style>
</head>
<body>
<div>
	<h1>Binder</h1>
	<h1>memberJoinForm</h1>
	<table style="margin:0 auto;">
		<form action="memberJoin" method="post" onsubmit="return formCheck();">
		<tr>
			<td>
				<div style="width:500px; height:100px; text-align:right; border:1px solid black;
							background-image:url(/img/MemberJoin/MemberJoin_login.jpg);">
					<div style="width:100px; height:100px; float:left;"></div>
					<input type="text" id="id" name="member_id" placeholder="아이디 입력해주세요" style="width:390px;height:90px;font-size:30px;">		
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:500px; height:100px; text-align:right; border:1px solid black;
						background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
					<div style="width:100px; height:100px; float:left;"></div>
					<input type="password" id="pwd" name="member_pw" placeholder="비밀번호 입력해 주세요"style="width:390px;height:90px;font-size:30px;">		
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:500px; height:100px; text-align:right; border:1px solid black;
						background-image:url(/img/MemberJoin/MemberJoin_name.jpg);">
					<div style="width:100px; height:100px; float:left;"></div>
						<input type="text" id="name" name="member_name" placeholder="이름을 입력해 주세요 " style="width:390px;height:90px;font-size:30px;">	
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:500px; height:100px; text-align:right; border:1px solid black;
						background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
					<div style="width:100px; height:100px; float:left;"></div>
					<input type="text" id="birthday" name="member_birthday" placeholder="생년월일 입력해 주세요" style="width:390px;height:90px;font-size:30px;">	
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:500px; height:100px; text-align:right; border:1px solid black;
						background-image:url(/img/MemberJoin/MemberJoin_email.jpg);">
					<div style="width:100px; height:100px; float:left;"></div>
					<input type="text" id="mail" name="member_mail" placeholder="이메일 입력해주세요" style="width:390px;height:90px;font-size:30px;">					
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:500px; height:100px; text-align:right; border:1px solid black;
						background-image:url(/img/MemberJoin/MemberJoin_phone.jpg);">
					<div style="width:100px; height:100px; float:left;"></div>
					<input type="text" id="phone" name=member_phone placeholder="생년월일 입력해 주세요" style="width:390px;height:90px;font-size:30px;">	
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:450px; height:80px; padding:25px; border:1px solid black;">
				<input type="radio" value="미혼" ><br><br>
				<input type="radio" value="기혼">
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:500px; height:100px; text-align:right; border:1px solid black;
						background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
					<div style="width:100px; height:100px; float:left;"></div>
					<input type="text" id="weddingday" name="member_weddingday" placeholder="결혼기념일 입력해 주세요" style="width:390px;height:90px;font-size:30px;">	
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="회원가입"> <input type="button" value="취소(메인화면으로)">
				<br>
				<a href="">아이디/비밀번호 찾기</a>
			</td>
		<tr>
	</form>
	</table>
</div>
</body>
</html>