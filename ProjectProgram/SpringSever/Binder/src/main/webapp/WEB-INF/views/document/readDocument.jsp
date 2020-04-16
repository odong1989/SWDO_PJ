<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" contents="width=device-width, initial-scale=1.0">
<title>${group_name}</title>

	<link href="<c:url value='/css/basic.css' />" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/vendor/css/fullcalendar.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/css/main.css'/>" >
    <link href="<c:url value='/css/modal.css' />" rel="stylesheet">
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
function edit(pk) {
	location.href="<c:url value='/document/editDocument' />?no="+pk;
}
function write(pk) {
	location.href="<c:url value='/document/writeDocument' />?no="+pk;
}
function groupMgr(pk) {
	location.href="<c:url value='/group/groupMemberMgr' />?no="+pk;
}
function calender(pk) {
	location.href="<c:url value='/calender/calenderMain' />?no="+pk;
}
</script>

    <link href="<c:url value='/css/basic.css' />" rel="stylesheet">
</head>
<body>
	<div id="gaibu-top">
		<span id="gaibu-top-left"> 
			<a href="<c:url value='/document/mainDocument' />">
			<img src="<c:url value='/img/logo.png' />"></a>
		</span> <span id="gaibu-top-middle"> </span> <span id="gaibu-top-right">

            <img src="<c:url value='/img/bell.png' />">
			<c:if test="${newNoteCheck eq 'nashi' }">
				<a href="javascript:noteList()"><img src="<c:url value='/img/mail.png' />"></a>
			</c:if>
			<c:if test="${newNoteCheck eq 'ari' }">
				<a href="javascript:noteList()"><img src="<c:url value='/img/newmail.png' />"></a>
			</c:if>
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
			<table id="document-body">
				<tr height="40px">
					<td width="21%">
						<a href="javascript:invite(${group_no })">
							<img src="<c:url value='/img/invite.png' />" title="초대코드생성">
						</a>
						<a href="javascript:write(${group_no})">
							<img src="<c:url value='/img/pencil.png' />" title="글쓰기"> 
						</a>
						<c:if test="${glist.MEMBER_LEVEL != 3 }">
						<!-- 회원관리 -->
						<div id="app1">
							<img src="<c:url value='/img/ShowMember.png' />" title="멤버목록" @click="openModal">
							<modal v-if="showModal" @close="closeModal">
								 	<template slot="header"><h3>회원목록</h3></template>
								 	<template slot="body">
										<table>
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
												<c:if test="loginid"></c:if>									
													<td width="30px">
													<img src="<c:url value='/img/subManager.png' />" id ="subManagerIcon" title="부매니저로 변경"
													 @click="subManager('${gjoin.member_id }')">
													 </td>
													<td width="30px"><img src="<c:url value='/img/commonMember.png' />" id="commonMemberIcon" 
													title="일반회원으로 변경" @click="commonMember('${gjoin.member_id }')"></td>
													<td width="30px"><img src="<c:url value='/img/deleteMember.png' />" id="deleteMemberIcon"
													 title="회원삭제" @click="deleteMember('${gjoin.member_id }')"></td>
												
												</tr>
												<input type="hidden" id="memberidh" value="${gjoin.member_id}">
												<input type="hidden" id="groupnoh" value="${gjoin.group_no}">
											</c:forEach>
										</table>
								 	</template>
								 	<template slot="footer">
								 		<button @click="closeModal">닫기</button>
								 	</template>
								  </modal>
							</div>
							</c:if>
											<!-- invite start -->
						<div class="Management">
							<div id="app2">
									<img src= "<c:url value='/img/InviteMember.png'/>" title="초대코드보내기" id="show-modal2" @click="openModal">
								  
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
					<!--  invite end-->	
					</td>
					<td width="auto" align="center"><p id="notice">공지사항 :
					<c:if test="${caution.document_content != '' }">
							${caution.document_content }
					</c:if>
							</p>
							</td>
					<td width="21%" align="right">
						<!-- groupcaution -->
						<div id="app3">
							<img src="<c:url value='/img/CautionWrite.png' />" title="공지사항수정" id="show-modal3" @click="openModal">
							  
							 <modal v-if="showModal3" @close="closeModal">
							<!-- 	여기는 모달 화면을 커스텀할수있습니다. template와 slot을 활용하여 커스텀하면 됩니다 -->
							 	<template slot="header"><h3>공지사항등록</h3></template>
							 	<template slot="body">
							 	<div>내용을 입력해주세요</div>
							 	</template>
							 	<template slot="footer">
							 		<div><input v-model="message"><button @click="doSend">제출</button></div>
							 		<input type = "hidden" id="gno" value="${group_no }">
							 	</template>
							  </modal>
						</div>
				<!-- groupcautionend -->
						<img src="<c:url value='/img/f5.png' />">
						<a href="javascript:calender(${group_no})">
							<img src="<c:url value='/img/cal.png' />" id="" title="캘린더화면으로전환"> 
						</a>
					</td>
				</tr>
				<c:forEach var="dlist" items="${documentList }">
					<tr>
						<td class="document-one">
								<a href="javascript:edit(${dlist.DOCUMENT_NO })">
									<div class="document-image" style="background-image:url(<c:url value='/profile/${dlist.PHOTO_SAVEDFILE }'/>);">
										<div class="document-image-bottom">
											<p>${dlist.DOCUMENT_DESTINATION }</p>
										</div>
									</div>
								</a>
						</td>
						<td colspan="2" class="document-one">
							<div class="document-content">
								<p>${dlist.DOCUMENT_REGDATE }</p>
								<p class="p-hash">#해시 table join 점검하세요</p>
							</div>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
    <script src="<c:url value='/vendor/js/moment.min.js' />"></script>
    <script src="<c:url value='/vendor/js/jquery.min.js' />"></script>
    <script src="<c:url value='/vendor/js/fullcalendar.min.js' />"></script>
    <script src="<c:url value='/vendor/js/bootstrap.min.js' />"></script>
 	<script src="<c:url value='/vendor/js/ko.js' />"></script>
    <script src="<c:url value='/vendor/js/select2.min.js' />"></script>
    <script src="<c:url value='/vendor/js/bootstrap-datetimepicker.min.js' />"></script>
    <script src="<c:url value='/js/main.js' />"></script>
    <script src="<c:url value='/js/addEvent.js' />"></script>
    <script src="<c:url value='/js/editEvent.js' />"></script>
    <script src="<c:url value='/js/etcSetting.js' />"></script>
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

						var str = this.message
						
						function chkEmail(str) {

						    var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

						    if (regExp.test(str)) return true;

						    else return false;

						}
						
						if (chkEmail(str)) {
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
							alert('이메일형식을 확인해주세요')
						}
					}
				}
			})
			//앱시작3
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
										history.go(0);
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