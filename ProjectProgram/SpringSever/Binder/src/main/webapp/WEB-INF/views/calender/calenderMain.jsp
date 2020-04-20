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
</script>
<link href="<c:url value='/css/basic.css' />" rel="stylesheet">
<style>
.panel-default {
	display: none;
}
</style>
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
			<c:forEach var="glist" items="${groupJoinList}">
				<div class="menu-group-button">
					<div class="menu-group-button-left">
						<a href="javascript:selectGroup(${glist.GROUP_NO })"><p>${glist.GROUP_NAME }</p></a>
						<p class="p-hash">#${glist.GROUP_SUBCATEGORY }</p>
					</div>
					<div class="menu-group-button-right">
						<c:if test="${glist.MEMBER_LEVEL == 1 }">
							<div id="app1">
							<img src="<c:url value='/img/ShowMember.png' />" title="멤버목록" @click="openModal">
							<modal v-if="showModal" @close="closeModal">
								 	<template slot="header"><h3>회원목록</h3></template>
								 	<template slot="body">
										<table>
											<c:forEach var="gjoin" items="${gjoin}">
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
							<img src="<c:url value='/img/crown_gold.png' />">
						</c:if>
						<c:if test="${glist.MEMBER_LEVEL == 2 }">
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
							<img src="<c:url value='/img/crown_silver.png' />">
						</c:if>
					</div>
					<div class="menu-group-button-clear"></div>
				</div>
			</c:forEach>
		</div>
		

		<div id="right-body">
			<table id="document-body">
				<tr><td><input type="hidden" id='groupNumber' value="${groupNumber}"></td></tr>
				<tr height="40px">
					<td width="21%">
						<a href="javascript:invite(${group_no})">
							<img src="<c:url value='/img/invite.png' />" title="초대코드생성">
						</a>
						<a href="javascript:write(${group_no})">
							<img src="<c:url value='/img/pencil.png' />" title="글쓰기"> 
						</a>
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
						<img src="<c:url value='/img/cal.png' />" id="btn1" title="캘린더화면으로전환">
					</td>
				</tr>
					<td colspan="3">
						<div id="wrapper">
				            <div id="loading"></div>
				            <div id="calendar"></div>
				        </div>
        			</td>
			</table>
		</div>
	</div>
	
	  <!-- 일자 클릭시 메뉴오픈 -->
        <div id="contextMenu" class="dropdown clearfix">
            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
                style="display:block;position:static;margin-bottom:5px;">
                <li><a tabindex="-1" href="#">일정추가하기</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
            </ul>
        </div>
        
	    <!-- 일정 추가 MODAL -->
        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    
                    <div class="modal-body">
                        <div class="row">
                           <div class="col-xs-12">
                                <label class="col-xs-4" for="groupNum"></label>
                                <input class="inputModal" type="hidden" name="groupNum" id="groupNum" value="${groupNumber}"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input class="inputModal" type="text" name="edit-title" id="edit-title" required="required" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">장소</label>
                                <input class="inputModal" type="text" name="edit-desc" id="edit-desc" required="required" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">시작일</label>
                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">종료일</label>
                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="inputModal" name="color" id="edit-color">
                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
                                    <option value="#495057" style="color:#495057;">검정색</option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

  
  		<!-- 패널부분을 삭제하면 풀캘린더에 일정이 나오지 않더라. 아직은 아래의 패널쪽 div들은 지우지 말것. -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">필터</h3>
            </div>
            <div class="panel-body">
                <div class="col-lg-6">
                    <label for="calendar_view">등록자별</label>
                    <div class="input-group">
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="정연"
                                checked>정연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="다현"
                                checked>다현</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나"
                                checked>사나</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="나연"
                                checked>나연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="지효"
                                checked>지효</label>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.filter panel -->
    </div>
    <!-- /.container -->
    
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