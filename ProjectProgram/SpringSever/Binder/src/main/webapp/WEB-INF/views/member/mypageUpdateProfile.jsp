<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

<script src="http://code.jquery.com/jquery-3.4.1.js"></script>
<script>
//참/거짓 값. 각 텍스트 입력창에서 입력받은 값이 참이 아닌 경우 전송버튼의 유효성검사에서 걸리도록실시.
	var pwbool = false;
	var mailbool = false;

	$(function()
	{
		$("#pw1").keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				if (inputVal.length < 4) {
				$("#pw_div")
					.html(
					"<font color='red'>사용 불가능한 비밀번호입니다.</font>");
					pwbool = false;
					} else {
					$("#pw_div")
					.html(
						"<font color='blue'>사용 가능한 비밀번호입니다.</font>");
						pwbool = true;
					}
					if ($("#pwchk").val().length != 0) {
						if (inputVal != $("#pwchk").val()) {
						$("#pw2_div")
						.html(
						"<font color='red'>비밀번호가 일치하지 않습니다.</font>");
						pwbool = false;
					} else {
						$("#pw2_div")
						.html(
						"<font color='blue'>비밀번호가 일치합니다.</font>");
						pwbool = true;
						}
					} else {
						$("#pw2_div")
						.html(
						"<font color='red'>입력되지 않았습니다.</font>");
						pwbool = false;
						}
					}
		});

		$("#pwchk").keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				if (inputVal.length != 0) {
				if (inputVal != $("#pw1").val()) {
					$("#pw2_div").html("<font color='red'>비밀번호가 일치하지 않습니다.</font>");
					pwbool = false;
				} else {
					$("#pw2_div").html("<font color='blue'>비밀번호가 일치합니다.</font>");
					pwbool = true;
				}
			} else {
				$("#pw2_div").html("<font color='red'>입력되지 않았습니다.</font>");
				pwbool = false;
					}
			}
		});

		//이메일 형식여부만 체크하는 제이쿼리
		//이메일 체크
		function checkEmail(str) {
    		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    		if (regExp.test(str)) return true;
    		else return false;
		}
		
		$("#mmail").keyup(function(event) {
			var inputVal = $(this).val();
			if (inputVal.length != 0){
				if(!(checkEmail(inputVal))) {
					$("#mmail_div").html("<font color='red'>이메일 형식에 맞지않습니다.</font>");
					mailbool = false;
				} else {	
					$("#mmail_div").html("<font color='blue'>정상적인 이메일 주소입니다.</font>");
					mailbool = true;
				}
			}
			//입력이 안된경우
			else {
				$("#mmail_div").html("<font color='red'>이메일을 입력해주세요.</font>");
				mailbool = false;
			}
		});
		
		$("#member_birthday").keyup( function(event) {
			var inputVal = $(this).val();
			var checkDate = new Date();			//유효성검사 추가부분 - 년,월,일 입력정보 엉터리로 넣는 경우 체크 
			var inputValYear = inputVal.substring(0,4);
			var inputValMonth = inputVal.substring(5,7);
			var inputValDay = inputVal.substring(8,10);
			
			if (inputVal.length < 10) 
			{
				$("#birthday_div").html(
				"<font color='red'>YYYY-MM-DD형식으로 입력해주세요!<br>(예 : 2000-01-01)</font>");
				birthbool = false;				
			} 
			else 
				{
					if( inputValYear < 1900 || inputValYear > checkDate.getFullYear() ){
						$("#birthday_div").html(
						"<font color='red'>년도를 확인해주세요.</font>");
						birthbool = false;				
					}
					else if( inputValMonth < 1 || inputValMonth > 12 ){
						$("#birthday_div").html(
						"<font color='red'>월을 확인해주세요.</font>");
						birthbool = false;				
					}
					else if( inputValDay < 1 || inputValDay > 31 ){
						$("#birthday_div").html(
						"<font color='red'>일을 확인해주세요.</font>");
						birthbool = false;										
					}
					else if( inputVal.substring(4,5) !='-' || inputVal.substring(7,8) !='-' ){
						$("#birthday_div").html(
						"<font color='red'>YYYY-MM-DD형식으로 입력해주세요 <br>(예 : 2000-01-01)</font>");
						birthbool = false;										
					}
					else{  
						$("#birthday_div").html(
						"<font color='blue'>올바르게 입력되었습니다.</font>");
						birthbool = true;
					}
				}
			});

		$("#member_weddingday").keyup( function(event) {
			var inputVal = $(this).val();
			var checkDate = new Date();			//유효성검사 추가부분 - 년,월,일 입력정보 엉터리로 넣는 경우 체크 
			var inputValYear = inputVal.substring(0,4);
			var inputValMonth = inputVal.substring(5,7);
			var inputValDay = inputVal.substring(8,10);
			
			if (inputVal.length < 10) 
			{
				$("#weddingday_div").html(
				"<font color='red'>YYYY-MM-DD형식으로 입력해주세요! <br>(예 : 2000-01-01)</font>");
				weddingbool = false;				
			} 
			else 
				{
					if( inputValYear < 1900 || inputValYear > checkDate.getFullYear() ){
						$("#weddingday_div").html(
						"<font color='red'>년도를 확인해주세요.</font>");
						weddingbool = false;				
					}
					else if( inputValMonth < 1 || inputValMonth > 12 ){
						$("#weddingday_div").html(
						"<font color='red'>월을 확인해주세요.</font>");
						weddingbool = false;				
					}
					else if( inputValDay < 1 || inputValDay > 31 ){
						$("#weddingday_div").html(
						"<font color='red'>일을 확인해주세요.</font>");
						weddingbool = false;										
					}
					else if( inputVal.substring(4,5) !='-' || inputVal.substring(7,8) !='-' ){
						$("#weddingday_div").html(
						"<font color='red'>YYYY-MM-DD형식으로 입력해주세요 <br> (예 : 2000-01-01)</font>");
						weddingbool = false;										
					}
					else{  
						$("#weddingday_div").html(
						"<font color='blue'>올바르게 입력되었습니다.</font>");
						weddingbool = true;
					}
				}
		});

		$("#profileEditsubmit").click(function() {
			name = $("#nname").val();
			mail = $("#mmail").val();
			if (!pwbool) {
				alert("사용하실 비밀번호를 입력해주세요.")
				return false;
			}
			if (name.length == 0) {
				alert("본명을 입력해주세요.");
				return false;
			}
			if (mail.length == 0) {
				alert("메일을 입력해주세요.");
				return false;
			}
			if (mail.indexOf('@') == -1 || mail.indexOf('.') == -1) {
				alert("메일 형식이 올바르지 않습니다.");
				return false;
			}

			//결혼기념은 미혼자인 경우도 있으니 무조건 통과불허는 않는 것으로.
			if(!(isDateFormCheck(member_birthday.value))){
				alert("생일을 입력해주세요.");
				return false;
			}
			
		});
	});

	function loginCheck() {
		var id = $("#member_id").val();
		var pw = $("#member_pw").val();
		if (id.length == 0) {
			alert("ID를 입력하세요.");
			return false;
		}
		if (pw.length == 0) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		true;
	}
	 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트입니다.------------------------------
    $(function() {
        $("#imgInp").on('change', function(){
            readURL(this);
        });
    });
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
                $('#previewImg').attr('src', e.target.result);
            }
          reader.readAsDataURL(input.files[0]);
        }
    }
//이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트 종료.----------------------------
</script>
<!-- -----------------유효성검사를 위한 자바스크립트 및 제이쿼리 종료.------------------------------- -->


<style>
#right-body{ padding:30px; }
table { margin:auto; border-collapse: collapse; width:450px; }
table, td, th { border: solid 1px #cccccc; text-align: center; vertical-align : middle; }
tr { height: 70px; }
td, th { padding: 5px; }

.lefttd { background-color: #5f90de; font-weight: bold; }
.righttd {vertical-align: top;}

#table_title { height:30px; background-color: #eeeeee; }
#col1, #col4 { width: 90px; }
#buttonWrap{ margin: 30px; }

input[type=text], input[type=password], input[type=email]{
	width: 250px; height: 2em; 
	padding: 20px 0 20px 10px;
	border-radius: 4%; }
</style>

	<!-- ---------------------------------------------------------------------------------- -->
	<div id="right-body" style="background-color: white-space; height: 900px;">
		<form id="memberUpdateForm" action="<c:url value='/member/memberUpdateExe' />" method="post" enctype="multipart/form-data">
		<table>	
			<!-- 1.이름수정 -->
			<tr style="height: 50px;">
				<td class="lefttd">이름</td>
				<td class="righttd" style="vertical-align: middle;" >
					<input type="text" name="member_name" placeholder="본명을 기입해주세요." id="nname">
				</td>
			</tr>
			
			<!-- 2.비밀번호 수정 -->
			<tr>
				<td class="lefttd" >신규 비밀번호</td>
				<td class="righttd"><input type="password" name="member_pw"
					id="pw1" placeholder="4~12글자 사용가능" maxlength="12">
					<div id="pw_div"></div>	
				</td>
			</tr>
			<tr>
				<td class="lefttd">비밀번호 확인</td>
				<td class="righttd"><input type="password" id="pwchk"
					placeholder="비밀번호 재입력" maxlength="12">
					<div id="pw2_div"></div>
				</td>
			</tr>

			<!-- 3.이메일 변경 -->
			<tr>
				<td class="lefttd">이메일</td>
				<td class="righttd">
					<input type="email" name="member_mail" placeholder="사용하시는 이메일로 입력해주세요"  id="mmail">
					<div id="mmail_div"></div>
				</td>
			</tr>

			<!-- 4.프로필사진변경 -->	
			<tr>
				<td class="lefttd">프로필 사진</td>
				<td class="righttd">
 				    <input type='file' id="imgInp" name="upload" />		       						  
				    <img id="previewImg" src="#" width="250" height="250" alt="프사 미리보기" />   	 
				</td>
			</tr>
			
			<!-- 5.생일변경 -->
			<tr>
				<td class="lefttd">생일</td>
				<td class="righttd">
					<input type="text" name="member_birthday" id="member_birthday" maxlength="10">
					<div id="birthday_div"></div>
				</td>
			</tr>
			
			<!-- 6.결혼여부  -->
			<tr style="height: 40px;">
				<td class="lefttd">결혼여부</td>
				<td class="righttd" style="vertical-align: middle;" >
					<input type="radio" name="member_married" value="0" checked>미혼
					<input type="radio" name="member_married" value="1">기혼
				</td>
				
			<!-- 7.결혼일 변경 -->	
			<tr>
				<td class="lefttd">결혼일</td>
				<td class="righttd">
					<input type="text" name="member_weddingday" id="member_weddingday" maxlength="10">
					<div id="weddingday_div"></div>
				</td>
			</tr>			
		</table>
		
			<!-- 8.변경정보 전송 혹은 전송취소 -->
			<div id="btntd" style="text-align: center; margin:20px">
				<input type="submit" value="변경하기" id="profileEditsubmit">
				<input type="button" value="변경취소" onclick="history.go(-1)"> 
			</div>
		</form>
	</div>
	</body>
</html>