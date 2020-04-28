<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>



	<div id="right-body">
			<form id="joinform" action="<c:url value='/group/groupCreate' />" method="get">
		<table id="joinformtable">
			<tr>
				<td class="lefttd">그룹명</td>
				<td class="righttd"><input type="text" id="gname" name="group_name" placeholder="그룹의 이름을 입력해주세요." maxlength="20"></td>
				<td class="chktd">
					<div id="id_div"></div>
				</td>
			</tr>
			<tr>
				<td class="lefttd">카테고리</td>
				<td class="righttd">
					<label id="cate1">
						<input type="radio" name="group_category" checked="checked" value="personal">개인
					</label>
					&nbsp;
					<label id="cate2">
						<input type="radio" name="group_category" value="public">단체
					</label>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td class="chktd">
					<div id="pw_div"></div>
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="lefttd">세부 카테고리</td>
				<td class="righttd"><input type="text" id="subcat" name="group_subcategory"
					placeholder="세부적인 분류를 입력해주십시오." maxlength="12"></td>
				<td class="chktd">
					<div id="subcat_div"></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2">
					<div id="subcat_result" style="padding: 2px; width:220px;"></div>
				</td>
			</tr>
		</table>
		<div id="btntd">
			<input type="button" value="취소" onclick="history.go(-1)"> 
			<input type="submit" value="가입" id="joinsubmit">
		</div>
			<input type="hidden" id="group_name_title" value="그룹 생성 - Binder">
	<script>
	var gnamebool = false;
	var subcatbool = false;

	
	$(function() {
		
		$(document).find("title").text($('#group_name_title').val());

		$(document).on('click','.exam',function() {
			$('#subcat').val($(this).text());
			$("#subcat_div").empty();
			$("#subcat_result").empty();
			$("#subcat_result").css("border","0");
		});
		
		$("#gname").keyup( function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				if (inputVal.length < 2 || inputVal.length > 20) {
					$("#id_div").html("<font color='red'>사용할 수 없는 그룹 이름입니다.</font>");
					gnamebool = false;
				} else {
					$("#id_div").html("<font color='blue'>사용가능한 그룹 이름입니다.</font>");
					gnamebool = true;
				}
			}
		});//그룹이름 검사 완료
		
		$("#subcat").keyup(function(event) {
			if($('#subcat_result').html() == "") {
				$("#subcat_result").css("border","0");
			}
			
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				subcatbool = true;
				var inputVal = $(this).val();
				if (inputVal.length != 0) {
					$("#subcat_div").empty();
					//검색
					$.ajax({
						url : "subcatSearch",
						type : "post",
						data : {"subcat" : $("#subcat").val()},
						success : function(result) {
							var osusume = '';
							for (let i = 0; i < 5; i++) {
								if(result[i] != null) {
									osusume += '<span class="exam">' + result[i] + '</span>';
									osusume += '<br/>';
								} else {
									break;
								}
							}
							$("#subcat_result").css("border","1px solid gray");
							$("#subcat_result").html(osusume);
							},
						error : function() {
							alert("통신 에러");
						}
					})

					
				} else {
					$("#subcat_div").html("<font color='red'>입력되지 않았습니다.</font>");
					subcatbool = false;
				}
			}
		});//세부 카테고리 검사 완료

		


		$("#joinsubmit").click(function() {
			if (!gnamebool) {
				alert("그룹 이름을 입력해주세요.")
				return false;
			}
			if (!subcatbool) {
				alert("세부 카테고리를 기입해주십시오.")
				return false;
			}
			
		});
	});
	</script>
	<link href="<c:url value='/css/createForm.css' />" rel="stylesheet">
</body>
</html>