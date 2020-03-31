<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${group_name }</title>
<link href="<c:url value='/css/basic.css' />" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type='text/javascript'
	src='http://code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript'
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>


<script type="text/javascript">
var temp = '';
function selectGroup(pk) {
	location.href="group?no="+pk;
}
function invite(pk) {
	location.href="../group/groupcode?no="+pk;
}
//20.03.29 병합 되지 않아서 직접 추가1 - 부트스트랩 한글 표기설정//단계2. 달력을 한글로 표기설정.(없을 시 영문으로 표기됩니다.)
//로드할 메인jsp에서 설정해둬야 적용되어서 주석처리해도 무방합니다..
(function($){
$.fn.datepicker.dates['kr'] = {
            days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
            daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
            daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
            months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
        };
    }(jQuery));
    
    //단계3. 부트스트랩 기본설정 
    $(function(){
        $('#datepicker').datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            language: "kr"
        })
    //단계4. 사용자가 선택한 날짜를 alert로 출력합니다.
        .on("changeDate",function(e){
            alert(e.date);
        })
    });
//20.03.29 병합 되지 않아서 직접 추가2 - 게시판<->캘린더 스위칭.
//btn1 : 게시판->캘린더로 변경
$(document).on("click","#btn1",function(){
	$.ajax({
			url:"<c:url value='/calender/calenderMain' />",
			type:"get",
			success:function(data){
				temp = document.getElementById('right-body').innerHTML;
				document.getElementById('right-body').innerHTML=data;
		//부트스트랩-데이트피커 실행문
				$('#datepicker').datepicker({
	                calendarWeeks: false,
	                todayHighlight: true,
	                language: "kr"
	            });
			},
			error:function(){alert("캘린더 로드 중 에러가 발생되었습니다.")}
	});
});
//btn2 : 캘린더->게시판으로 변경
$(document).on("click","#btn2",function(){
	$.ajax({
			url:"<c:url value='/document/boardTemp' />",
			type:"get",
			success:function(data){		
				document.getElementById('right-body').innerHTML=temp;
				//document.getElementById('right-body').innerHTML=data;
			},
			error:function(){alert("게시판(document) 로드 중 에러가 발생되었습니다.")}
	});
});

</script>
<style>
table.table-condensed {
	width: 650px; /*데이터피커의 총 가로폭을 설정할 수 있습니다.*/
	height: 450px; /*데이터피커의 총 세로폭을 설정할 수 있습니다.*/
	border-style: double;
	font-family: 돋움; /*데이터피커의 날짜들의 폰트 설정 가능.*/
}

td.day { /*현재 달의 일자들을 설정할 수 있습니다.*/
	color: cyan;
	text-align: left;
	font-size: larger;
}

td.old.day {
	text-align: left;
	vertical-align: top;
	/*오래전 날짜들은 X선(대각선)을 그을 수 있습니다.
	     당장은 필요없다고 답변받아 사용할 수 있도록 주석처리만 함.*/
	/*
	     background: <line x1:"0" y1="100%" x2="100%" y2="0" stroke="gray">;
	     background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="0" x2="100%" y2="100%" stroke="gray" /><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');*/
}

td.new.day {
	text-align: left;
	vertical-align: top;
}
</style>
</head>
<body>
	<div id="gaibu-top">
		<span id="gaibu-top-left"> <a
			href="<c:url value='/document/mainDocument' />"> <img
				src="<c:url value='/img/logo.png' />"></a>
		</span> <span id="gaibu-top-middle"> </span> <span id="gaibu-top-right">

            <img src="<c:url value='/img/bell.png' />">
			<img src="<c:url value='/img/mail.png' />">
			<a href="<c:url value='/member/memberMypage' />"><img src="<c:url value='/img/human.png' />" id="usericon">
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
		</div>
		<div id="right-body">
			<div>
				<div class="GroupMemberList">
					<div id="app">
						<table>
							<c:forEach var="gjoin" items="${gjoin }">
							<tr>
								<td class='center'>${gjoin.member_id }</td>
								<td class='center'>${gjoin.group_no }</td>
								<td class='center'><c:if test="${gjoin.member_level == 1 }">
					관리자
				</c:if> <c:if test="${gjoin.member_level == 2 }">
					부관리자
				</c:if> <c:if test="${gjoin.member_level == 3 }">
					일반회원
				</c:if></td>
								<td class='center'>${gjoin.group_joindate }</td>
								<c:if test="${gjoin.member_level < 3 }">
									<td><button @click='deleteMember'>삭제</button></td>
									<td><button @click='openModal'>수정</button></td>
								</c:if>
							</tr>
							</c:forEach>
						</table>

						<modal v-if="showModal" @close="closeModal"> <!-- 	여기는 모달 화면을 커스텀할수있습니다. template와 slot을 활용하여 커스텀하면 됩니다 -->
						<h3 slot="header">회원 타입 변경</h3>
						<template slot="body">
						<div>변경할 값을 선택해주세요</div>
						<child memberidm='${gjoin.member_id }'></child> </template> <template
							slot="footer"> <c:if
							test="${gjoin.member_level == 1 }">
							<button id="sub" @click="subManager">부관리자</button>
							<button id="not" @click="notManager">일반회원</button>
						</c:if> <c:if test="${gjoin.member_level == 2 }">
							<button id="not" @click="notManager">일반회원</button>
						</c:if>
						<div id="testitem"></div>
						</template> </modal>
					</div>
				</div>
			</div>
			<input type="hidden" id="memberidh" value="${gjoin.member_id}">
			<input type="hidden" id="groupnoh" value="${gjoin.group_no}">
		</div>
	</div>
	<script>
var memberidh = document.getElementById("memberidh").value;
var groupnoh = document.getElementById("groupnoh").value;
var msg; // 데이터 받아올 var
Vue.component('modal', {
	  template: `
		  <transition name="modal">
		    <div class="modal-mask" @click.self="$emit('close')">
		      <div class="modal-wrapper">
		        <div class="modal-container">
		          
				<div class="modal-header">
		            <slot name="header">
		              default header
		            </slot>
		          </div>

		          <div class="modal-body">
		            <slot name="body">
		              default body
		            </slot>
		          </div>

		          <div class="modal-footer">
		            <slot name="footer">
		              default footer
		              <button class="modal-default-button" @click="$emit('close')">
		                	close
		              </button>		
		            </slot>
		          </div>
		        </div>
		      </div>
		    </div>
		  </transition>
		  `
	})
	Vue.component('child',{
		props: ['memberidm'],
		data: function(){
			return {memberidm2: this.memberidm}
		},
		template: '<span>{{memberidm}}</span>'
		})
	
	// 앱시작
	new Vue({
	  el: '#app',
	  data: 
		{
	    showModal: false,
	    message: '',
	    member123: ''    
		},
	  methods: {
			openModal(){
				this.showModal = true
			},
			closeModal(){
				this.showModal = false
			},
			doSend(){
				if (this.message.length > 0) {
// 					여기에 이벤트를 주면됩니다
					msg = this.message
					this.message =''
					this.closeModal()
				}else {
					alert('메세지 입력필요')
				}
			},
			subManager(){
				$.ajax({
					url:"updateGJMS",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
						}else {
							alert("실패")
						}
					}
				})
				this.closeModal();
			},
			notManager(){
				$.ajax({
					url:"updateGJMC",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
						}else {
							alert("실패")
						}
					}
				})
				this.closeModal();
			},
			deleteMember(){
				$.ajax({
					url:"deleteGMember",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
						}else {
							alert("실패")
						}
					}
				})
				this.closeModal();
	  }
	  }
	})
</script>
</body>
</html>