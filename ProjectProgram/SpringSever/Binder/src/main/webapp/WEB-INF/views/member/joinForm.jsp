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
	$(function() {
		$("#iid")
				.keyup(
						function(event) {
							if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
								var inputVal = $(this).val();
								var chk_eng = /[A-Z]/; // 대문자 
								var chk_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글

								if (inputVal.length < 4) {
									$("#id_div")
											.html(
													"<font color='red'>사용할 수 없는 아이디입니다.</font>");
								} else {
									if (!(chk_eng.test(inputVal))
											&& !(chk_kor.test(inputVal))) {
										//사용가능한지 ajax 검사
										$
												.ajax({
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

						});

		$("#pw1")
				.keyup(
						function(event) {
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

		$("#pwchk")
				.keyup(
						function(event) {
							if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
								var inputVal = $(this).val();
								if (inputVal.length != 0) {
									if (inputVal != $("#pw1").val()) {
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

		$("#nnick")
				.keyup(
						function(event) {
							if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
								var inputVal = $(this).val();
								if (inputVal.length != 0) {
									//ajax를 통해 닉네임 중복검사
									$
											.ajax({
												url : "memberOLCheck",
												type : "post",
												contentType : "application/json; charset=utf-8",
												data : JSON.stringify({
													"member_nickname" : $(
															"#nnick").val()
												}),
												success : function(str) {
													if (str) {
														//사용가능
														$("#nick_div")
																.html(
																		"<font color='blue'>사용 가능한 닉네임입니다.</font>");
														nickbool = true;
													} else {
														//이미 사용중
														$("#nick_div")
																.html(
																		"<font color='red'>이미 사용중인 닉네임입니다.</font>");
														nickbool = false;
													}
												},
												error : function() {
													alert("통신 에러");
												}
											});
								} else {
									$("#nick_div")
											.html(
													"<font color='red'>입력되지 않았습니다.</font>");
									nickbool = false;
								}
							}
						});

		$("#joinsubmit").click(function() {
			name = $("#nname").val();
			mail = $("#mmail").val();
			if (!idbool) {
				alert("사용할 수 없는 ID입니다.")
				return false;
			}
			if (!pwbool) {
				alert("사용할 수 없는 비밀번호입니다.")
				return false;
			}
			if (name.length == 0) {
				alert("이름이 입력되지 않았습니다.");
				return false;
			}
			if (mail.length == 0) {
				alert("메일이 입력되지 않았습니다.");
				return false;
			}
			if (mail.indexOf('@') == -1 || mail.indexOf('.') == -1) {
				alert("메일 형식이 올바르지 않습니다.");
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
</script>
</head>
<body>
	<form id="joinform" action="<c:url value='/member/memberJoin' />"
		method="post">
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
				<td class="righttd"><input type="text" name="member_name"
					id="nname"></td>
			</tr>
			<tr></tr>
			<tr>
				<td class="lefttd">이메일</td>
				<td class="righttd"><input type="email" name="member_mail"
					id="mmail"></td>
			</tr>
		</table>
		<div id="btntd">
			<input type="button" value="취소"> <input type="submit"
				value="가입" id="joinsubmit">
		</div>
	</form>