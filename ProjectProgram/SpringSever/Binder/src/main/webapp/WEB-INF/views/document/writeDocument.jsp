<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

		<div id="right-body" >
			<div id="right-body-menuWrap"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->
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
		</table>
		</div>
			<div id="right-body-wirteDocWrap" style="background-color:white; padding:10px 10px 30px 20px;"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->
			<table class="wirteDocForm">		
				<form action="documentInsert" onsubmit="return documentInsertCheck();" method="POST" enctype="multipart/form-data">
			     	<tr>
			     	    <td> 오늘 날짜 : <p id='currentDate' style="display:inline;"></p> </td>
						<!--그룹번호를 같이보내줍니다 -->		
					    <td><input type="hidden" name='group_no' value="${writeDocumentGroup_no}"></td>
				    </tr>
				    <tr style="border-bottom: 1px solid #444444;">
						<!-- <td>여행 일정</td>-->
				        <td> <input type='date' id='startDate' name='document_regdate'  style="display:inline;"/> 부터  </td>
				   		<td> <input type='date' id='endDate' name='document_finalday'  style="display:inline;"/> 까지   </td>
					</tr>
				    <tr>
 						<!-- <td rowspan="3" style="text-align:center;vertical-align:middle;">사진등록<br>
							&기록하기</td>-->
						<td> <img id="previewImg" src="<c:url value='/img/preViewImage.png' />"
						      width="250" height="250" alt="첨부사진 미리보기" ></td>
				    	<td> <textarea rows="14" width="300" style="resize: none" id="content" name="document_content"></textarea> </td> 
				   	</tr>     
					<tr>
						<td><input type='file' id="imgInp" name="upload" value="등록사진"/></td>
						<td> <input type="text" placeholder="장소" id='place' name="document_destination" style="width:160px;"></td>
					</tr>
				   	<tr>	
				   		<td colspan="2"> <input type="text" placeholder="#해시태그를 입력해주세요" style="width:430px;"> </td>
				   	</tr>       
				    <tr style="border-top: 1px solid #444444;">
           				<td colspan="3">
				            <div style="text-align: center;">
							<input type="submit" value="글 등록하기" >
					   		<input type="button" value="취소" onclick="history.back(-1);">
				   			</div>
						</td>
					</tr>
        			   </form>
          		</table>
				</div>

      </div>
     <script>
  	        document.getElementById('currentDate').innerHTML = new Date().toISOString().substring(0, 10);
            document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
            document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
    </script>

	<style>
	
	.wirteDocForm  table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  	}
  	
	.wirteDocForm td{padding:10px;}

    #right-body {
    margin-top:5px;
    float:left;
    background-color: white;
    width:100%;
    height:100%;
	}

	/* 
	#right-body{background-color: green;  height: 500px;}
	
    .wirteDocForm th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  	}
  	*/
	</style>
	
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type='text/javascript'
		src='http://code.jquery.com/jquery-1.8.3.js'></script>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
	<script type='text/javascript'
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
	
	 <script type="text/javascript">
	 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트입니다.------------------------------
	        $(function() {
	            $("#imgInp").on('change', function(){
	                readURL(this);
	            });
	        });
	        function readURL(input) {
	            if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function (e) {
	                    $('#previewImg').attr('src', e.target.result);
	                }
	              reader.readAsDataURL(input.files[0]);
	            }
	        }
	 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트 종료.----------------------------
	 
	 		function write(pk) {
				location.href="<c:url value='/document/writeDocument' />?no="+pk;
			}
	
	  //유효성체크 시작------------------------------------------------------------------
			function documentInsertCheck(){
				var content = document.getElementById("content");						//컨텐츠 유효성 검사
				var startDate = document.getElementById("startDate").value; // 시작일, 날짜 유효성 검사
			    var endDate = document.getElementById("endDate").value;     // 종료일, 날짜 유효성 검사
	
				//alert("startDate : " + startDate );
				//alert("endDate   : " + endDate );
			   //textarea의 내용이 없다면 다시 작성하도록 flase실시.
				if(content.value.length==0){
					alert("여행의 추억을 기록해주세요");
					return false;
				}
			
				if(startDate > endDate){
		            alert("시작일이 종료일보다 이 후 일수는 없습니다.\n다시 선택하여 주시기 바랍니다.");
					return false;
				}
	       	 	
	       	 	else if(endDate < startDate){
		            alert("종료일이 시작일보다 이 전 일수는 없습니다.\n다시 선택하여 주시기 바랍니다.");
					return false;
	       	 	} 
		        
				return true;
			}
	
	 //유효성체크 종료------------------------------------------------------------------
	</script>
</body>
</html>