<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							history.go(0);
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
							history.go(0);
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
							history.go(0);
						}
					}
				})
			},
			manager(memberidh){
				groupnoh = document.getElementById("groupnoh").value;
				$.ajax({
					url:"updateGJMM",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							history.go(0);
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
					groupnoh = document.getElementById("gno").value;
					$.ajax({
						url:"selectGJM",
						type:"get",
						data:{"memberCheck" : mid,
							"no" : groupnoh
							},
						success:
							function(result){
							if(result == "true"){
								alert("메세지전송에 성공하였습니다")
							}else {
								alert("아이디를 찾을수 없습니다.")
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
								alert("email전송에 성공하였습니다.")
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
										history.go(0);
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