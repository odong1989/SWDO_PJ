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
$(function(){
	$("#btnChangeName").click(function(){
		$.ajax({
			url  : "MypageChangeName",
			type : "post",
			data : {"member_nm":$("#member_nm").val()},
			success : function(result){
				var output = "";
				output +="<tr><td>성명</td>"
				output +="<td><b>"+ result +" </b></td>"
				output +="<td><input type='text' id='member_nm' name='member_nm' value='변경할 이름 입력'></td>"
				output +="<td><input type='button' id='btnChangeName' value='이름 변경하기'></td></tr>"

				output +="<td>주소</td>"
				output +="<td><b> ${MemberData.member_addr}</b></td>"
				output +="<td><input type='text' id='member_addr' name='member_addr' placeholder='변경할 주소 입력'</td>"
				output +="<td><input type='button'  id='btnChangeAddress' value='주소 변경하기'></td>"
					
				$("#changeTable").html(output);
				alert("이름변경이 완료되었습니다.");
			},
			error : function() {alert("이름변경이 실패하였습니다.");}
		});
	});
	
	$("#btnChangeAddress").click(function(){
		 $.ajax({
			url  : "MypageChangeAddress",
			type : "post",
			data : {"member_addr":$("#member_addr").val()},
			success : function(result){		
				var output = "";
				output +="<tr><td>성명</td>"
					output +="<td><b> ${MemberData.member_nm} </b></td>"
					output +="<td><input type='text' id='member_nm' name='member_nm' value='변경할 이름 입력'></td>"
					output +="<td><input type='button' id='btnChangeName' value='이름 변경하기'></td></tr>"

					output +="<td>주소</td>"
					output +="<td><b>" +result+ "</b></td>"
					output +="<td><input type='text' id='member_addr' name='member_addr' placeholder='변경할 주소 입력'</td>"
					output +="<td><input type='button'  id='btnChangeAddress' value='주소 변경하기'></td>"
				$("#changeTable").html(output);
				alert("주소 변경이 완료되었습니다.");
			},
			error : function() {alert("주소변경이 실패하였습니다.");}
		});
	});	
});

function memberMypageChangePwForm(){
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
<br><br>
<h2>${sessionScope.loginId}님의 개인정보(myPage)입니다</h2>
<hr>
	<div>
	<table>
		<tr>
			<td>아이디 : </td>
			<td>${MemberData.member_id}</td>
			<td>가입일 : </td>
			<td>${MemberData.member_indate}</td>
			<td><a href= "/member/memberMypageChangePwForm">비밀번호 변경하기</a></td>
		<!--  <td><input type="button"  onsubmit="memberMypageChangePwForm()" value="비밀번호 변경하기"></td>-->	

		</tr>

	</table>	
	<br>
	
	<table id="changeTable">
		<tr>
				<td>성명</td>
				<td><b> ${MemberData.member_nm} </b></td>
				<td><input type="text" id="member_nm" name="member_nm" placeholder="변경할 이름 입력"></td>
				<td><input type="button" id="btnChangeName" value="이름 변경하기"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><b> ${MemberData.member_addr}</b></td>
				<td><input type="text" id="member_addr" name="member_addr" placeholder="변경할 주소 입력"></td>
				<td><input type="button"  id="btnChangeAddress" value="주소 변경하기"></td>
			</tr>					
		</table>
	</div>
</div>
</body>
</html>