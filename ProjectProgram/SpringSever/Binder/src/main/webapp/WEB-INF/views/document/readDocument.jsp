<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>



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
						
				<%@ include file="../includes/membermodal.jsp" %>

				<img src="<c:url value='/img/f5.png' />">
						<a href="javascript:calender(${group_no})">
							<img src="<c:url value='/img/cal.png' />" id="" title="캘린더화면으로전환"> 
						</a>
					</td>
				</tr>
				<c:forEach var="dlist" items="${documentList }">
					<tr>
						<td class="document-one">
								<a href="javascript:readContent(${dlist.DOCUMENT_NO })">
									<div class="document-image" style="background-image:url(<c:url value='/profile/${dlist.PHOTO_SAVEDFILE }'/>);" >
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
	<%@ include file="../includes/vuemodal.jsp" %>
</body>
</html>