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
function replyUpdate(pk){
	alert('수정')
}

function replyDelete(pk){
	alert('삭제')
}
$(function(){
        
	$("#btn").click(function(){
		var reply_content = $('#reply_content').val();
		var document_no = $('#document_no').val();
		var member_id = $('#member_id').val();
		var formData = {
					reply_content : reply_content,
					document_no : document_no,
					member_id : member_id
				};
		if(reply_content ==""){
			alert("내용을입력해주세요")
			return;
		}
		$.ajax({
			type:"post",
			url: "writeReply",
			data: formData,
			dataType : "json",
			success : function(result) {
				if(result){
					alert("성공")
					$("#reply_content").val("");
					}	
					else{
					alert("실패")
					}
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
					<tr>	
						<td>${document.document_no }번 글</td>
					</tr>	
			     	<tr>
				     	<td style="text-align:center;vertical-align:middle;"> 장소 : ${document.document_destination } </td>
			     	    <td colspan="2"> <p id='currentDate' style="display:inline;"></p> </td>
				    </tr>
				    <tr style="border-bottom: 1px solid #444444;">
						<td style="text-align:center;vertical-align:middle;">여행 일정</td>
				        <td> <p id='startDate' style="display:inline;"/></p> ${document.document_regdate }부터  </td>
				   		<td> <p id='endDate'  style="display:inline;"/></p> ${document.document_finalday }까지   </td>
					</tr>
				    <tr>
 						<td rowspan="3" style="text-align:center;vertical-align:middle;">${document.document_content }</td>
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
							<input type="submit" value="글 수정하기" >
					   		<input type="button" value="이전페이지 가기" onclick="history.back(-1);">
						</td>
					</tr>
					<tr>
						<td>
						<h>Reply</h>
							<form id="replyForm">
								<input type="hidden" id="document_no" value="${document.document_no }">
								<input type="text" id="member_id" value="${loginId }">
								<input type="text" id="reply_content">
								<button type="button" id="btn">댓글등록</button>
							</form>
							
						</td>
					</tr>
			<div id="replyList">
			<c:forEach var="replyList" items ="${replyList }">
				<tr>
					<td>
					${replyList.member_id } : ${replyList.reply_content }
					</td>
				</tr>	
			</c:forEach>
			</div>
			 </table>
          </table>
	
		</div>
	
</body>
</html>