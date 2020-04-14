<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 - Binder</title>
<link href="<c:url value='/css/joinform.css' />" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.4.1.js"></script>
<script>
	var idbool = false;
	var pwbool = false;
	var nickbool = false;
	
	$(function()
	{
		$("#iid").keyup( function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var inputVal = $(this).val();
			var chk_eng = /[A-Z]/; // 대문자 
			var chk_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글
			if (inputVal.length < 4) 
			{
				$("#id_div").html("<font color='red'>사용할 수 없는 아이디입니다.</font>");
			} else {
				if (!(chk_eng.test(inputVal))&& !(chk_kor.test(inputVal))) {
				//사용가능한지 ajax 검사
				$.ajax({
					url : "memberIdCheck",
					type : "post",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify({
					"member_id" : $("#iid").val()
					}),
					success : function(str) {
						if (str) {
							//사용가능
							$("#id_div")
							.html(
							"<font color='blue'>사용할 수 있는 아이디입니다.</font>");
							 idbool = true;
							 } else {
								 
							//사용불가
							$("#id_div")
							.html(
								"<font color='red'>사용할 수 없는 아이디입니다.</font>")
							idbool = false;
							}
						},
					error : function() {
						alert("통신 에러");
					}
			});
				} else {
				//$(this).val(inputVal.replace(/[^a-z0-9]/gi, ''));
						$("#id_div")
						.html(
							"<font color='red'>영문, 숫자만 입력해주십시오.</font>");
						idbool = false;
					}
				}
			}
		});//ID를 실시간체크하는 AJAX종료
		
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
					pwbool = false;
				} else {	
					$("#mmail_div").html("<font color='blue'>정상적인 이메일 주소입니다.</font>");
					pwbool = true;
				}
			}
			//입력이 안된경우
			else {
				$("#mmail_div").html("<font color='red'>이메일을 입력해주세요.</font>");
				pwbool = false;
			}
		});

		

		//생일, 결혼일의 날짜 형식 체크하는데 사용하는 함수.
		function isDateFormCheck(date)
		{
		    var formYYYYMMDD = /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])/;
		    //                     yyyy -       MM      -       dd     
		    return formYYYYMMDD.test(date);
		}
		
		$("#member_birthday").keyup( function(event) {
			var inputVal = $(this).val();
			if (inputVal.length < 10) 
			{
				$("#birthday_div").html("<font color='red'>YYYY-MM-DD형식으로 입력해주세요! (예 : 2000-01-01)</font>");
			} else {
				if(!(isDateFormCheck(inputVal.value))){
						$("#birthday_div").html(
						"<font color='blue'>올바르게 입력되었습니다.</font>");
						pwbool = true;
					} else {
						$("#birthday_div").html(
						"<font color='red'>YYYY-MM-DD형식으로 입력해주세요! (예 : 2000-01-01)</font>");
					pwbool = false;
				 	}
				}
		});

		$("#member_weddingday").keyup( function(event) {
			var inputVal = $(this).val();
			if (inputVal.length < 10) 
			{
				$("#weddingday_div").html("<font color='red'>YYYY-MM-DD형식으로 입력해주세요! (예 : 2000-01-01)</font>");
			} else {
				if(!(isDateFormCheck(inputVal.value))){
						$("#weddingday_div").html(
						"<font color='blue'>올바르게 입력되었습니다.</font>");
						pwbool = true;
					} else {
						$("#weddingday_div").html(
						"<font color='red'>YYYY-MM-DD형식으로 입력해주세요! (예 : 2000-01-01)</font>");
					pwbool = false;
				 	}
				}
		});

		


		$("#joinsubmit").click(function() {
			name = $("#nname").val();
			mail = $("#mmail").val();
			if (!idbool) {
				alert("사용하실 ID를 입력해주세요.")
				return false;
			}
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

			//4/13추가
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
	<style>
	#btntd{text-align: center;}
</style>
</head>
<body>
<!-- <form id="joinform" action="<c:url value='/member/memberJoin' />" method="post"> -->
	<form id="joinform" action="<c:url value='/loginAndJoin/memberJoin' />" method="post" enctype="multipart/form-data">
		<table id="joinformtable">
			<tr>
				<td class="lefttd">아이디</td>
				<td class="righttd"><input type="text" id="iid"
					name="member_id" placeholder="4~12글자 사용가능" maxlength="12"></td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="id_div"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd">비밀번호</td>
				<td class="righttd"><input type="password" name="member_pw"
					id="pw1" placeholder="4~12글자 사용가능" maxlength="12"></td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="pw_div"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd">비밀번호 확인</td>
				<td class="righttd"><input type="password" id="pwchk"
					placeholder="비밀번호 재입력" maxlength="12"></td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="pw2_div"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd">이름</td>
				<td class="righttd">
					<input type="text" name="member_name" placeholder="본명을 기입해주세요." id="nname">
				</td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="nname_div"></div><!-- 개행(엔터)용도로만 생성. 현재 별도의 ajax안내문 코딩은 없음 -->
				</td>
			</tr>		
			<tr>
				<td class="lefttd">이메일</td>
				<td class="righttd"><input type="email" name="member_mail" placeholder="사용하시는 이메일로 입력해주세요"  id="mmail"></td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="mmail_div"></div>
				</td>
			</tr>		
			
			<!-- -----------------기존에 정수환 반장이 만들고 튜닝한 부분------------------- -->
			<tr>
				<td class="lefttd">프로필 사진</td>
				<td class="righttd">
				    <input type='file' id="imgInp" name="upload" />		       						  
				    <img id="previewImg" src="#" width="250" height="250" alt="프사 미리보기" />    	
				</td>
			</tr>
			<tr><!-- 첨부사진 미리보기 가능하게 -->
				<td></td>
				<td class="chktd">
					<div id="photo_div"></div>
				</td>
			</tr>			
			
			<tr>
				<td class="lefttd">생일</td>
				<td class="righttd">
					<input type="text" name="member_birthday" id="member_birthday" maxlength="10">
				</td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="birthday_div"></div>
				</td>
			</tr>
			
			<tr>
				<td class="lefttd">결혼여부</td>
				<td class="righttd">
					<input type="radio" name="member_married" value="0" checked>미혼
					<input type="radio" name="member_married" value="1">기혼
				</td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="married_div"></div><!-- 개행(엔터)용도로만 생성. 현재 별도의 ajax안내문 코딩은 없음 -->
				</td>
			</tr>		
			
			
			<tr>
				<td class="lefttd">결혼일</td>
				<td class="righttd">
				<input type="text" name="member_weddingday" id="member_weddingday" maxlength="10"></td>
			</tr>			
			<tr>
				<td></td>
				<td class="chktd">
					<div id="weddingday_div"></div>
				</td>
			</tr>
			
		</table>
		<div id="btntd">
			<input type="button" value="취소" onclick="history.go(-1)"> 
			<input type="submit" value="가입" id="joinsubmit">
		</div>
	</form>