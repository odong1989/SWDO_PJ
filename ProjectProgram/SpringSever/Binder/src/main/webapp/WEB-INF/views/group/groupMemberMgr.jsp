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
               <div>
	<div class="GroupMemberList">
			<div id="app">
		<table>
			<tr>
			<td class='center'>${gjoin.member_id }</td>
			<td class='center'>
				<c:if test="${gjoin.member_level == 1 }">
					관리자
				</c:if>
				<c:if test="${gjoin.member_level == 2 }">
					부관리자
				</c:if>
				<c:if test="${gjoin.member_level == 3 }">
					일반회원
				</c:if>
			</td>
			<td class='center'>${gjoin.group_joindate }</td>
			<td><input type='button' id='remove' value ='삭제'></td>
			<td><button @click='openModal'>수정</button></td>
			</tr>
		</table>
		
				<modal v-if="showModal" @close="closeModal">
			<!-- 	여기는 모달 화면을 커스텀할수있습니다. template와 slot을 활용하여 커스텀하면 됩니다 -->
			 	<h3 slot="header">회원 타입 변경</h3>
			 	<template slot="body">
			 	<div>변경할 값을 선택해주세요</div>
			 	<child memberidm='${gjoin.member_id }'></child>
				<button id="sub" @click="subManager">부관리자</button>
				<button id="not" @click="notManager">일반회원</button>
			 	<div id="testitem"></div>
				</template>
			 	<template slot="footer">
			 		<button @click="doSend">제출</button>
			 	</template>
			  </modal>
			</div>
	</div>
</div>
<input type="hidden" id="testtest" value="${gjoin.member_id}">
            </div>
        </div>
    </div>
 <script>
var testtest = document.getElementById("testtest").value;
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
					data:{"memberCheck" : testtest},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
						}else {
							alert("실패")
						}
					}
				})
			},
			notManager(){
				
			}
			
	  }
	})
</script>
</body>
</html>