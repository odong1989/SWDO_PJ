<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>회원가입페이지입니다</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script>
function idCheck(){//id중복확인 버튼클릭시 생성되는 ID중복 확인팝업창.
	 window.open("memberidCheckForm","newWin","left=300, top=300, width=500, height=300, resizeable=no");
	 }


//날짜 yyyy-mm-dd형식으로 검사하는 조건문.
function isDateFormCheck(date)
{
    var formYYYYMMDD = /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])/;
    //                     yyyy -       MM      -       dd     
    return formYYYYMMDD.test(date);
}

//이메일 체크
function checkEmail(str) {
    var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (regExp.test(str)) return true;
    else return false;
}



출처: https://sesok808.tistory.com/553 [살아가는 그 이유]

function formCheck(){//id및 입력사항 유효성 검사체크
	var member_id = document.getElementById("member_id");
    var member_pw = document.getElementById("member_pw");
    var member_name = document.getElementById("member_name");
    var member_birthday = document.getElementById("member_birthday");
    var member_mail = document.getElementById("member_mail");
    var mailCheckValue = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    
	if(member_id.value.length<4 || member_id.value.length>10){
	//	alert("ID는 4~10글자 이상이어야 합니다.");
		alert("ID 중복체크를 해야 회원가입이 가능합니다!");
		return false;
	}
	if(member_pw.value.length<4 || member_pw.value.length>10){
		alert("비밀번호는4~10자리로 해주세요");
		return false;
	}
	if(member_name.value =="" || member_name.length==0){
		alert("이름을 입력해주세요!");
		return false;
	}

	if(!(isDateFormCheck(member_birthday.value))){
		alert("YYYY-MM-DD형식으로 입력해주세요! (예 : 2000-01-01)");
		return false;
	}

	if(member_name.value =="" || member_name.length==0){
		alert("이름을 입력해주세요!");
		return false;
	}

    if(member_mail.value=="") {
      alert("이메일을 입력해 주세요");
      return false;
   }

    alert(checkEmail(member_mail.value));
   if(!(checkEmail(member_mail.value))) {
	   alert("이메일을 올바르게 입력해 주세요");
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
	<div>
		<table style="margin:50px 50px;">
	<!-- 	<form action="memberJoin" method="post" enctype="multipart/form-data" onsubmit="return formCheck();" > -->
			<form action="memberJoin" method="post" onsubmit="return formCheck();" >
				<tr>
					<td>
						<div class="memberJoin" style="background-image:url(/img/MemberJoin/MemberJoin_login.jpg);height:80px;">
							<div class="image"></div>
							<input class="box" type="text" id="member_id" name="member_id" readonly="readonly" placeholder="아이디 중복검사를 해주세요">	
							<input type="button" value="ID중복체크" onclick="idCheck()">	
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="memberJoin"	style="background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
							<div class="image"></div>
							<input type="password" id="member_pw" name="member_pw" placeholder="비밀번호 입력해 주세요">		
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="memberJoin"	style="background-image:url(/img/MemberJoin/MemberJoin_name.jpg);">
							<div class="image"></div>
							<input type="text" id="member_name" name="member_name" placeholder="이름을 입력해 주세요 ">	
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="memberJoin">
							<div class="image"></div>
							<input type="file" name=member_photo placeholder="프로필 사진을 넣어주세요" >	
										 		  	 <!-- name="upload"-->
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="memberJoin"	style="background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
							<div class="image"></div>
							<input type="text" id="member_birthday" name="member_birthday" placeholder="생년월일 입력해 주세요" >	
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="memberJoin"	style="background-image:url(/img/MemberJoin/MemberJoin_email.jpg);">
							<div class="image"></div>
							<input type="text" id="member_mail" name="member_mail" placeholder="이메일 입력해주세요" >					
						</div>
					</td>
				</tr>
	
				<tr> 
					<td>
						<div style="width:220px; height:60px; padding:15px; border:1px solid black;">
							<input type="radio" name="member_married" value="0" >미혼<br><br>
							<input type="radio" name="member_married" value="1">기혼
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="memberJoin" style="background-image:url(/img/MemberJoin/MemberJoin_password.jpg);">
							<div class="image"></div>
							<input type="text" id="weddingday" name="member_weddingday" placeholder="결혼기념일 입력해 주세요">	
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="회원가입"> 
						<a href="/"><input type="button" value="취소(메인화면으로)"></a>
					</td>
				<tr>
			</form>
		</table>
	</div>
</body>
</html>