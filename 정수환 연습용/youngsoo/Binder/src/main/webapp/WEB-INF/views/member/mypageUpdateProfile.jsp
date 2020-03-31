<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>회원정보 수정 페이지입니다</title>
<script src="/js/jquery-3.4.1.js "> </script>
	<script>
function idCheck(){//id중복확인 버튼클릭시 생성되는 ID중복 확인팝업창.
/*
	window.open("memberidCheckForm","newWin","left=300, top=300, width=500, height=300, resizeable=no");
	 }
function memberThrow(){//id및 입력사항 유효성 검사체크
	var member_id = document.getElementById("member_id");
    var member_pw = document.getElementById("member_pw");
    var member_nm = document.getElementById("member_nm");
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
	*/
    return true;
}
function memberThrawal(){//id및 입력사항 유효성 검사체크
	if(confirm("이동하시려면 예를 누르시고 이동을 하지 않으시려면 아니오를 눌러주세요"))
	 {
		 alert('회원탈퇴가 진행됩니다.');
		return true;
//	  location.href="http://cdmanii.tistory.com";
	 }
	 else
	 {
		 alert('아니오를 누르셨습니다');
		return false;
		 }
	}
}
</script>
<style>
	input[type=text], input[type=password] {
		width: 200px;
		height: 2em;
		padding: 20px 0 20px 10px;
		border-radius: 4%;
	}
	div.memberJoin{
		width  	   : 250px; 
		height	   : 45px;
		text-align : right; 
		border 	   : 1px solid black;
		background-size: 250px, 250px;
		background-repeat: no-repeat;
	}
	
	div.memberJoin.image{
		width:40px; 
		height:40px; 
		float:left;
	}
	input.box{
		width:200px;
		height:50px;
		font-size:13px;
	}
</style>
</head>
<body>
회원정보 수정
<!-- memberJoin -->
<div>
	<table style="margin:50px 50px;">
		<form action="memberUpdate" method="post" onsubmit="return formCheck();">
			<tr>
				<td>
					<div class="memberUpdate" style=background-image:url(/img/MemberJoin/MemberJoin_login.jpg);">
						<div class="image"></div>
						<input class="box" type="text" id="id" name="member_id" placeholder=${MemberData.member_id} readonly="readonly"}>		
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="memberUpdate" style="background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
						<div class="image"></div>
						<input type="password" id="pwd" name="member_pw" placeholder="신규 비밀번호를 입력해 주세요">		
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="memberUpdate"	style="background-image:url(/img/MemberJoin/MemberJoin_name.jpg);">
						<div class="image"></div>
						<input type="text" id="name" name="member_name" placeholder="이름을 입력해 주세요 ">	
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="memberUpdate"	style="background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
						<div class="image"></div>
						<input type="text" id="birthday" name="member_birthday" placeholder="생년월일 입력해 주세요" >	
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="memberUpdate"	style="background-image:url(/img/MemberJoin/MemberJoin_email.jpg);">
						<div class="image"></div>
						<input type="text" id="mail" name="member_mail" placeholder="이메일 입력해주세요" >					
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="memberUpdate" style="background-image:url(/img/MemberJoin/MemberJoin_phone.jpg);">
						<div class="image"></div>
						<input type="text" id="phone" name=member_phone placeholder="연락처를 입력해 주세요" >	
					</div>
				</td>
			</tr>
			<tr> 
				<td>
					<div style="width:220px; height:60px; padding:15px; border:1px solid black;">
						<input type="radio" name="member_married" value="0" >미혼
						<input type="radio" name="member_married" value="1">기혼
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="memberUpdate" style="background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
						<div class="image"></div>
						<input type="text" id="weddingday" name="member_weddingday" placeholder="결혼기념일 입력해 주세요">	
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="수정하기"> 
					<a href="/"><input type="button" value="수정취소" ></a>
					<!-- <a href="/"><input type="button" value="회원탈퇴" onclick="memberThrawal()"></a>  -->
				</td>
			<tr>
		</form>
	</table>
</div>
</body>
</html>