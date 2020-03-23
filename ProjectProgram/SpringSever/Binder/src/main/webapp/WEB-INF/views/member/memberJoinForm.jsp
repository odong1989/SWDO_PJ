<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/resources/css/style_ver3.css">	
	<script src="<c:url value='/resources/js/jquery-3.4.1.js' /> "> </script>
	<script>
function idCheck(){//id중복확인 버튼클릭시 생성되는 ID중복 확인팝업창.
	 window.open("memberidCheckForm","newWin","left=300, top=300, width=500, height=300, resizeable=no");
	 }
	 
function formCheck(){//id및 입력사항 유효성 검사체크
	var member_id = document.getElementById("member_id");
    var member_pw = document.getElementById("member_pw");
    var member_nm = document.getElementById("member_nm");
    var member_addr = document.getElementById("member_addr");
    /*
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

</script>
</head>
<body>
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

<h1>memberJoinForm</h1>
	<form action="memberJoin" method="post" onsubmit="return formCheck();">
		<table>
			<tr>
				<td>ID :</td>
				<td><input type="text" name="member_id" id="member_id" readonly="readonly" ></td>
				<td><input type="button" value="중복체크" onclick="idCheck()">	</td>
			</tr>
			<tr>
				<td>PW :</td>
				<td colspan="2"><input type="password" id="member_pw" name="member_pw" placeholder="비밀번호는4~10글자로 해주세요"></td>
			</tr>
			<tr>
				<td>이름 : </td>
				<td colspan="2"> <input type="text" id="member_name" name="member_name" placeholder="" >  </td>
			</tr>
			<tr>
				<td>e메일 : </td>
				<td colspan="2"> <input type="text" id="member_mail" name="member_mail" placeholder="집주소 또는 근무지주소">  </td>
			</tr>
			<tr>
				<td>생일 :  </td>
				<td colspan="2"> <input type="text" id="member_birthday" name="member_birthday" placeholder="집주소 또는 근무지주소">  </td>
			</tr>			
			
			
			<tr id="buttonAlign">
			<td colspan="3"> <input type="submit" value="회원가입"> <input type="button" value="취소(메인화면으로)"></td>
			</tr>	
		</table>
	</form>
	</div>
</body>
</html>