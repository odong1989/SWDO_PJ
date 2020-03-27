<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
비밀번호 재설정 페이지입니다.
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
						<input type="radio" value="미혼" >미혼
						<input type="radio" value="기혼">기혼
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
</body>
</html>