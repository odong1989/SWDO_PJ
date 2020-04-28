<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" contents="width=device-width, initial-scale=1.0">
<title>${group_name}</title>

	<link href="<c:url value='/css/basic.css' />" rel="stylesheet">
	<link href="<c:url value='/css/min1660.css' />" rel="stylesheet" media="screen and (min-width:1660px)">
	<link href="<c:url value='/css/max1660.css' />" rel="stylesheet" media="screen and (min-width:1385px) and (max-width:1660px)">
	<link href="<c:url value='/css/max1385.css' />" rel="stylesheet" media="screen and (min-width:1225px) and (max-width:1385px)">
	<link href="<c:url value='/css/max1225.css' />" rel="stylesheet" media="screen and (min-width:1080px) and (max-width:1225px)">
	<link href="<c:url value='/css/max1080.css' />" rel="stylesheet" media="screen and (min-width:950px) and (max-width:1080px)">
	<link href="<c:url value='/css/max950.css' />" rel="stylesheet" media="screen and (max-width:950px)">
    <link href="<c:url value='/css/modal.css' />" rel="stylesheet">
    <link href="<c:url value='/css/reply.css' />" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/vendor/css/fullcalendar.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/css/main.css'/>" >
    <link href="<c:url value='/css/readDocuStyle.css' />" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">
var temp = '';
function selectGroup(pk) {
	location.href="<c:url value='/document/group' />?no="+pk;
}
function invite(pk) {
	location.href="<c:url value='/group/groupcode' />?no="+pk;
}
function noteList() {
	window.open("<c:url value='/note/noteList' />", "_blank", "width=600, height=500, toolbar=no, menubar=no, scrollbars=no, resizable=no" );  
}    
function edit(pk) {
	location.href="<c:url value='/document/editDocument' />?no="+pk;
}
function readContent(pk,pk2) {
	location.href="<c:url value='/document/readContentDocument' />?no="+pk;
}
function write(pk) {
	location.href="<c:url value='/document/writeDocument' />?no="+pk;
}
function calender(pk) {
	location.href="<c:url value='/calender/calenderMain' />?no="+pk;
}
function Withdrawal(){
    var result = confirm("정말 회원탈퇴하시겠습니까?");//신규창으로 띄워서 예/아니오 받도록한다.
    if(result){
        alert("회원탈퇴를 진행합니다.");
        location.href="/member/memberWdraw";
    }else{
        alert("회원탈퇴가 취소되었습니다.");
    }
}

//jQuery 시작
	$(function() {
		//그룹생성
		$(document).on('click','#gCreateBtn',function() {
			$(location).attr('href','<c:url value="/group/groupCreateForm" />')
		})
		
		//해시태그 추가하기
		$(document).on('click','#addHash',function() {
			//추가된 input이 없을 때만 실행
			if ($('#hashbox2 input').size() == 0) {
				minusbtn = '<span id="removeHash">[-]</span>';
				$('#hashman').append(minusbtn);
			}
			box = '<input type="text" name="hashtag" placeholder="#hash" style="width:100px;" autocomplete="off"> ';
			$('#hashbox2').append(box);
		});
		//해시태그 제거하기
		$(document).on('click','#removeHash',function() {
			//input이 하나 남았을 때는 -버튼도 같이 제거
			if ($('#hashbox2 input').size() == 1) {
				$('#removeHash').remove();
			}
			//끝에서부터 input 제거
			$('#hashbox2 input')[$('#hashbox2 input').size()-1].remove()
		});
	});
</script>
    <link href="<c:url value='/css/basic.css' />" rel="stylesheet">
</head>
<body>

	<div id="gaibu-top">
		<span id="gaibu-top-left"> 
			<a href="<c:url value='/document/mainDocument' />">
			<img src="<c:url value='/img/logo.png' />"></a>
		</span> <span id="gaibu-top-middle"> </span> <span id="gaibu-top-right">

<%--             <img src="<c:url value='/img/bell.png' />"> --%>
			<c:if test="${newNoteCheck eq 'nashi' }">
				<a href="javascript:noteList()"><img src="<c:url value='/img/mail.png' />"></a>
			</c:if>
			<c:if test="${newNoteCheck eq 'ari' }">
				<a href="javascript:noteList()"><img src="<c:url value='/img/newmail.png' />"></a>
			</c:if>

				<c:choose>
					<c:when test="${empty sessionScope.profilePhoto}">
						<td>
							<a href="<c:url value='/member/memberMypage' />">
							<img id="usericon" src="<c:url value='/img/human.png' />" 
								 style="width:30px; height: 30px;" />
							</a> 
						</td>
					</c:when>
					<c:otherwise>
					<td >
							<a href="<c:url value='/member/memberMypage' />">
							<img id="usericon" src="<c:url value='/profile/${sessionScope.profilePhoto}' />" 
										 	 style="width:30px; height: 30px;"/>
							</a>
						</td>
					</c:otherwise>
				</c:choose>
			<a href="<c:url value='/member/memberLogout' />"><img src="<c:url value='/img/logout.png' />"></a>
		</span>
	</div>
	<div id="gaibu">
		<div id="menu">
				
			<c:forEach var="glist" items="${groupJoinList }">
				<div class="menu-group-button">
					<div class="menu-group-button-left">
						<a href="javascript:selectGroup(${glist.GROUP_NO })"><p>${glist.GROUP_NAME }</p></a>
						<p class="p-hash">#${glist.GROUP_SUBCATEGORY }</p>
					</div>
					<div class="menu-group-button-right">
						<c:if test="${glist.MEMBER_LEVEL == 1 }">
							
							<img src="<c:url value='/img/crown_gold.png' />">
						</c:if>
						<c:if test="${glist.MEMBER_LEVEL == 2 }">
							<img src="<c:url value='/img/crown_silver.png' />">
						</c:if>
					</div>
					<div class="menu-group-button-clear"></div>
				</div>
			</c:forEach>
			<c:if test="${groupJoinList.size() == 0 }">
				<div class="menu-group-button">
					<div class="menu-group-button-left">
						<p>가입된 그룹이<br/>없습니다.</p>
					</div>
					<div class="menu-group-button-right">
						<input type="button" value="그룹 생성" id="gCreateBtn" style="background-color:black; color:white;">
					</div>
					<div class="menu-group-button-clear"></div>
				</div>
			</c:if>
			<c:if test="${groupJoinList.size() != 0 }">
				<div class="menu-group-button">
					<div class="menu-group-button-left">
						<input type="button" value="그룹 생성" id="gCreateBtn" style="background-color:black; color:white; margin:5px 0 5px 22px;">
					</div>
					<div class="menu-group-button-right">
					</div>
					<div class="menu-group-button-clear"></div>
				</div>
			</c:if>
		</div>