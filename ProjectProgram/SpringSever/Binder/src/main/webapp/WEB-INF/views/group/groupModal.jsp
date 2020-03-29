<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${group_name }</title>
    <link href="<c:url value='/css/basic.css?ia=1' />", rel="stylesheet">
     <link href="<c:url value='/css/modal.css'/>", rel="stylesheet">
     <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
     <script src="http://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">
		function selectGroup(pk) {
			location.href="group?no="+pk;
		}
    </script>
</head>
<body>
    <div id="gaibu">
        <div id="gaibu-left">
            <div id="gaibu-left-top">
            <p><img src="<c:url value='/img/logo.png' />"></p>
            </div>
            <div id="left-menu">
            	            	<c:forEach var="glist" items="${groupJoinList }">
	                <div class="menu-group-button">
	                    <div class="menu-group-button-left">
	                        <a href="javascript:selectGroup(${glist.GROUP_NO })"><p>${glist.GROUP_NAME }</p></a>
	                        <p class="p-group">#${glist.GROUP_SUBCATEGORY }</p>
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
        </div>
        <div id="gaibu-right">
            <div id="gaibu-right-top">
                <div id="naibu-right-left">
                    
                </div>
                <!-- <div id="naibu-right-right"> -->
                    <p><img src="<c:url value='/img/bell.png' />"> <img src="<c:url value='/img/mail.png' />"> <img src="<c:url value='/img/human.png' />" id="usericon"></p>
                <!-- </div> -->
            </div>
            <div id="gaibu-right-bottom">
                <!-- app -->
			<div id="app">
			  <button id="show-modal" @click="showModal = true">모달화면입니다</button>
			  
			  <modal v-if="showModal" @close="closeModal">
			<!-- 	여기는 모달 화면을 커스텀할수있습니다. template와 slot을 활용하여 커스텀하면 됩니다 -->
			 	<h3 slot="header">모달테스트</h3>
			 	<template slot="body">
			 	<div>메세지를 보낼 아이디를 입력해주세요</div>
			 	<div><input v-model="memberid"></div>
			 	<button  @click="showMember">멤버확인</button>
			 	<div>
			 		<table id="testd">
			 		</table>
			 	</div>
			 	</template>
			 	<template slot="footer">
			 		<div>이메일을 입력해주세요</div>
			 		<div><input v-model="message"></div>
			 		<button @click="doSend">제출</button>
			 	</template>
			  </modal>
			</div>
			
			
			
			<script>
			//뷰 컴포넌트 모달화면 슬롯설정
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
	
			// 앱시작
			new Vue({
			  el: '#app',
			  data: function(){
			    return {
			    	showModal: false,
			    	message: '',
			    	memberid: ''
				 }
			  },
			  methods: {
					openModal(){
						this.showModal = true
						
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
						document.getElementById("testidx").value = mid
						this.memberid = ''
							
						this.closeModal()
						}
						else {
								alert("아이디입력필요")
							}
					},
					closeModal(){
						this.showModal = false
					},
					doSend(){
						if (this.message.length > 0) {
		// 					여기에 이벤트를 주면됩니다
							msg = this.message
							document.getElementById("testmsg").value = msg //이걸로 데이터를 받아와서
							this.message =''
							this.closeModal()
						}else {
							alert('메세지 입력필요')
						}
					}
			  }
			})
</script>
<!-- 	여기에 출력 확인을 위해 text타입으로 받았으나 히든타입으로 받으면 넘길수있을것같습니다.-->
	<input type="text" id ="testmsg">
	<input type="text" id ="testidx">

            </div>
        </div>
    </div>
</body>
</html>