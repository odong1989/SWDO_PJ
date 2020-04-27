<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
						<c:if test="${memberJoin.member_level < 3 }">
						<!-- 회원관리 -->
						<div id="app1">
							<c:if test=""></c:if>
							<img src="<c:url value='/img/ShowMember.png' />" title="멤버목록" @click="openModal">
							<modal v-if="showModal" @close="closeModal">
								 	<template slot="header"><h3>회원목록</h3></template>
								 	<template slot="body">
										<table>
											<c:forEach var="gjoin" items="${gjoin }">
												<tr>
												<c:choose>
													<c:when test ="${!gjoin.MEMBER_ID.equals(sessionScope.loginId)}">
														<td class='memberName'>${gjoin.MEMBER_NAME}(${gjoin.MEMBER_ID })</td>
													</c:when>
													
													<c:when test="${gjoin.MEMBER_ID.equals(sessionScope.loginId)}">
														<td class='memberName'>${gjoin.MEMBER_NAME}(${gjoin.MEMBER_ID })(나)</td>
													</c:when>
												</c:choose>
												<td class='memberlevel'>
													<c:if test="${gjoin.MEMBER_LEVEL == 1 }">
														관리자
													</c:if> <c:if test="${gjoin.MEMBER_LEVEL == 2 }">
														부관리자
													</c:if> <c:if test="${gjoin.MEMBER_LEVEL == 3 }">
														일반회원
													</c:if>
												</td>						
													<td class='membericon'>
													<c:if test="${!gjoin.MEMBER_ID.equals(sessionScope.loginId)}">
													<c:choose>
														<c:when test="${gjoin.MEMBER_LEVEL == 1}">
														</c:when>
														<c:when test="${gjoin.MEMBER_LEVEL == 2 && memberJoin.member_level == 1}">
															<img src="<c:url value='/img/subManager.png' />" id ="subManagerIcon" title="관리자로 변경"
													 		@click="manager('${gjoin.MEMBER_ID }')">
														 	<td class='membericon'><img src="<c:url value='/img/commonMember.png' />" id="commonMemberIcon" 
															title="일반회원으로 변경" @click="commonMember('${gjoin.MEMBER_ID }')"></td>
															<td class='membericon'><img src="<c:url value='/img/deleteMember.png' />" id="deleteMemberIcon"
														 	title="회원삭제" @click="deleteMember('${gjoin.MEMBER_ID }')"></td>
														 </c:when>
														 <c:when test="${gjoin.MEMBER_LEVEL == 3}">
														 	<c:if test="${memberJoin.member_level == 1 }">
														 	<img src="<c:url value='/img/subManager.png' />" id ="subManagerIcon" title="부매니저로 변경"
														 	@click="subManager('${gjoin.MEMBER_ID }')">
														 	</c:if>
															<td class='membericon'><img src="<c:url value='/img/deleteMember.png' />" id="deleteMemberIcon"
														 	title="회원삭제" @click="deleteMember('${gjoin.MEMBER_ID }')"></td>
														 </c:when>
													 </c:choose>
													 </c:if>
													 </td>
													
												</tr>
												<input type="hidden" id="memberidh" value="${gjoin.MEMBER_ID}">
												<input type="hidden" id="groupnoh" value="${gjoin.GROUP_NO}">
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
								<!-- 	여기는 모달 화면을 커스텀할수있습니다. template와 slot을 활용하여 커스텀하면 됩니다 
								modal.css
								-->
								 	<template slot="header"><h3>초대코드 보내기</h3></template>
								 	<template slot="body">
								 	<div class="inputMessage"><input v-model="memberid" placeholder="아이디를 입력해주세요"> 
								 	<input type = "hidden" id="gno" value="${group_no}">
								 	<button  @click="showMember">보내기</button></div>
								 	<br>
								 	<div class="inputMessage"><input v-model="message" placeholder="이메일을 입력해주세요"> <button @click="doSend">제출</button></div>
								 	
								 	</template>
								 	<template slot="footer">
								 		<button @click="closeModal">닫기</button>
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
							 	<template slot="header"><h4>공지사항등록</h4></template>
							 	<template slot="body">
							 	<div id="cautionDiv"><input v-model="message"  id = "cautionWrite" placeholder = "내용을 입력해주세요"></div>
							 	</template>
							 	<template slot="footer">
							 		<div><button @click="doSend">제출</button><button @click="closeModal">닫기</button></div>
							 		<input type = "hidden" id="gno" value="${group_no}">
							 	</template>
							  </modal>
						</div>
				<!-- groupcautionend -->
						