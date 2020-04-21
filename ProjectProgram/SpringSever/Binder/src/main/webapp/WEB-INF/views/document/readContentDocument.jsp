<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

<style>
	.DocData {
	margin:50px;
	} 
	
	.DocData  table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  	}

	.DocData td{padding:10px;}
  
</style>


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
				<table class="DocData">		
				<!--그룹번호를 같이보내줍니다 -->		
			 	<tr><td><input type="hidden" name='group_no' value="${writeDocumentGroup_no}"></td></tr>
			     	<tr>
				     	<td style="text-align:center;vertical-align:middle;"> 작성일 </td>
			     	    <td colspan="2"> <p id='currentDate' style="display:inline;"></p> </td>
				    </tr>
				    <tr style="border-bottom: 1px solid #444444;">
						<td style="text-align:center;vertical-align:middle;">여행 일정</td>
				        <td> <p id='startDate' style="display:inline;"/></p> 부터  </td>
				   		<td> <p id='endDate'  style="display:inline;"/></p> 까지   </td>
					</tr>
				    <tr>
 						<td rowspan="3" style="text-align:center;vertical-align:middle;">contents</td>
						<td rowspan="2" style="vertical-align:middle;"> <img id="previewImg" src="<c:url value='/img/preViewImage.png' />"
						      width="250" height="250" alt="첨부사진 미리보기" ></td>
				    	<td> <p id="content" style="display:inline;"/> </p> </td> 
				   	</tr>     
					<tr>
						<td> <p id='place' style="display:inline;"/></p></td>
					</tr>
				   	<tr>	
				   		<td colspan="2"> <p id='hashtag' style="display:inline;"/></p></td>
				   	</tr>       
				    <tr style="border-top: 1px solid #444444;">
           				<td colspan="3">
				            <div style="text-align: center;">
							<input type="submit" value="글 수정하기" >
					   		<input type="button" value="이전페이지 가기" onclick="history.back(-1);">
				   			</div>
						</td>
					</tr>
          		</table>
			
			
			
			
			<!-- 영수씨의 기존 댓글 소스코드 -->
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
</body>
</html>