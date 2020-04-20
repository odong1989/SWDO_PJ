<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>
<script>
$(function(){
	$("#btn").click(function(){
		var reply_content = $('#reply_content').val();
		var vo = $('#reply').serialize();
		if(reply_content ==""){
			alert("내용을입력해주세요")
			return;
		}
		$("#reply_content").val("");

		$.ajax({
			type:"post",
			url: "getReply",
			data: vo,
			dataType : json,
			success : function(result) {
					alert("성공")
				},
			error: function(error) {
					alert("실패")
				}
		})
			
	})
})
</script>

		<div id="right-body">
			<table id="document-body">
				<tr height="40px">
					<td width="21%">
						${documentno }번 글입니다.
					</td>
				</tr>
				<tr>
					<td>
					reply
						<form id="reply" modelAttribute="Reply" method="post">
							<input type="hidden" id="no" value="${document_no }">
							<input type="text" id="member_id" value="${loginId }">
							<input type="text" id="reply_content">
						</form>
						<button type="button" id="btn">입력</button>
					</td>
				</tr>
				<tr>
					<td>
						<div id="replyList"></div>
					</td>
				</tr>
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
		
	</script>
</body>
</html>