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
<link href="<c:url value='/css/modal.css' />" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type='text/javascript'
	src='http://code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript'
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>


<script type="text/javascript">
var temp = '';
function selectGroup(pk) {
	location.href="../document/group?no="+pk;
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

			<img src="<c:url value='/img/bell.png' />"> <img
			src="<c:url value='/img/mail.png' />"> <img
			src="<c:url value='/img/human.png' />" id="usericon"> <a
			href="<c:url value='/member/memberLogout' />"><img
				src="<c:url value='/img/logout.png' />"></a>
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
					<div id="app1">
						<table>
							<tr>
							<td>
								<br/><br/>
								<h1>회원목록</h1>
								<br/><br/><br/><br/>
							</td>
							</tr>
							<c:forEach var="gjoin" items="${gjoin }">
							<tr>
								<td class='center'>${gjoin.member_id }</td>
								<td class='center'><c:if test="${gjoin.member_level == 1 }">
									관리자
								</c:if> <c:if test="${gjoin.member_level == 2 }">
									부관리자
								</c:if> <c:if test="${gjoin.member_level == 3 }">
									일반회원
								</c:if>
								</td>
								<td>
								     
								</td>
								
									
									<td width="30px"><img src="<c:url value='/img/subManager.png' />" @click="subManager('${gjoin.member_id }')"></td>
									<td width="30px"><img src="<c:url value='/img/commonMember.png' />" @click="commonMember('${gjoin.member_id }')"></td>
									<td width="30px"><img src="<c:url value='/img/deleteMember.png' />" @click="deleteMember('${gjoin.member_id }')"></td>
								
								</tr>
								<input type="hidden" id="memberidh" value="${gjoin.member_id}">
								<input type="hidden" id="groupnoh" value="${gjoin.group_no}">
							</c:forEach>
						</table>
						</div>
				</div>
			</div>
	</div>
<!-- management start -->
	<div class="Management">
		<div id="app2">
				<button id="show-modal2" @click="openModal">초대코드보내기</button>
			  
			  <modal v-if="showModal2" @close="closeModal">
			<!-- 	여기는 모달 화면을 커스텀할수있습니다. template와 slot을 활용하여 커스텀하면 됩니다 -->
			 	<template slot="header"><h3>초대코드 보내기</h3></template>
			 	<template slot="body">
			 	<div>초대코드를 보낼 아이디를 입력해주세요</div>
			 	<div><input v-model="memberid"></div>
			 	<button  @click="showMember">멤버확인</button>
			 	</template>
			 	<template slot="footer">
			 		<div>초대코드를 보낼 이메일을 입력해주세요</div>
			 		<div><input v-model="message"></div>
			 		<button @click="doSend">제출</button>
			 	</template>
			  </modal>
		</div>
	<div>	
<!--  manangement end-->
<!-- groupcaution -->
	<div class="Caution">
		<div id="app3">
				<button id="show-modal3" @click="openModal">공지사항등록</button>
			  
			  <modal v-if="showModal3" @close="closeModal">
			<!-- 	여기는 모달 화면을 커스텀할수있습니다. template와 slot을 활용하여 커스텀하면 됩니다 -->
			 	<template slot="header"><h3>공지사항등록</h3></template>
			 	<template slot="body">
			 	<div>내용을 입력해주세요</div>
			 	</template>
			 	<template slot="footer">
			 		<div><input v-model="message"><button @click="doSend">제출</button></div>
			 		<input type = "hidden" id="gno" value="${gno }">
			 	</template>
			  </modal>
		</div>
	</div>
<!-- groupcautionend -->
</div>

            </div>
        </div>
    </div>
 <script>
var groupnoh='';
var memberidh='';
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
	//앱시작1
		new Vue({
	  el: '#app1',
	  data: 
		{
	    showModal: false,    
		},
	  methods: {
			openModal(){
				this.showModal = true
			},
			closeModal(){
				this.showModal = false
			},
			deleteMember(memberidh){
				groupnoh = document.getElementById("groupnoh").value;
				$.ajax({
					url:"deleteGMember",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
							history.go(0);
						}else {
							alert("실패")
						}
					}
				})
	  		},
			subManager(memberidh){
	  			groupnoh = document.getElementById("groupnoh").value;
				$.ajax({
					url:"updateGJMS",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
							history.go(0);
						}else {
							alert("실패")
						}
					}
				})
			},
			commonMember(memberidh){
	  			groupnoh = document.getElementById("groupnoh").value;
				$.ajax({
					url:"updateGJMC",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
							history.go(0);
						}else {
							alert("실패")
						}
					}
				})
			}
	 	}
	})
	
	
	//앱시작2
	new Vue({
		el: '#app2',
		data: function(){
		return {
		  	showModal2: false,
		   	message: '',
		   	memberid: ''
			 }
		 },
		methods: {
			openModal(){
				this.showModal2 = true
			},
		showMember(){
			if(this.memberid.length > 0) {
			var mid = this.memberid;
			$.ajax({
				url:"selectGJM",
				type:"get",
				data:{"memberCheck" : mid},
				success:
					function(result){
					if(result == "true"){
						alert("성공")
					}else {
						alert("존재안함")
					}
				}
			})
			this.memberid = ''
			this.closeModal()
			}
			else {
					alert("아이디입력필요")
				}
			},
			closeModal(){
				this.showModal2 = false
			},
			doSend(){
				if (this.message.length > 0) {
		// 		이메일로 보내기
				$.ajax({
				url:"sendEmail",
				type:"get",
				data:{"email" : this.message},
				success:
					function(result){
					if(result == "true"){
						alert("성공")
					}else {
						alert("실패")
					}
				}
			})
				this.message =''
				this.closeModal()
				}
				else {
					alert('이메일 입력필요')
				}
			}
		}
	})
	new Vue({
	  el: '#app3',
	  data: function(){
	    return {
	    	showModal3: false,
	    	message: '',
		 }
	  },
	  methods: {
			openModal(){
				this.showModal3 = true
				
			},
			closeModal(){
				this.showModal3 = false
			},
			doSend(){
				if (this.message.length > 0) {
// 					여기에 이벤트를 주면됩니다
					var msg = this.message
					groupnoh = document.getElementById("gno").value;
					$.ajax({
						url:"insertCaution",
						type:"get",
						data:{"caution" : msg,
							"gno" : groupnoh
							},
						success:
						function(result){
							if(result == "true"){
								alert("성공")
							}else {
								alert("실패")
							}
						}
					})
					this.message =''
					this.closeModal()
				}else {
					alert('텍스트 입력필요')
				}
			}
	  }
	})

</script>
</body>
</html>