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
function editReply(reply_no, reply_content){
	var htmls = "";
	htmls += '<a href="javascript:void(0)" onclick="replyUpdate(' + reply_no  + ', \'' + reply_content + '\')" style="padding-right:5px">저장</a>';

	htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';

	htmls += '<textarea name="editContent" id="editContent">';

	htmls += reply_content;

	$('#rid' + reply_no).replaceWith(htmls);

	$('#rid' + reply_no + ' #editContent').focus();

}

function replyUpdate(reply_no, reply_content){
		var reply_content = $('#editContent').val();

		$.ajax({
			type:"post",
			url: "updateReply",
			data: {
				reply_no : reply_no,
				reply_content : reply_content
				},
			dataType : "json",
			success : function(result) {
				if(result){
					alert("성공")
					showReplyList();
					}	
					else{
					alert("실패")
					}
				}
	})
}


function deleteReply(pk){
	$.ajax({
		type:"post",
		url: "deleteReply",
		data: {
			reply_no : pk,
			},
		dataType : "json",
		success : function(result) {
			if(result){
				alert("성공")
				showReplyList();
				}	
				else{
				alert("실패")
				}
			}
})
}

function showReplyList(){
	var document_no = $('#document_no').val();

	$.ajax({
			type: "post",
			url: "getReply",
			data: {document_no : document_no},
			dataType : "json",
			success : function(result){
				var htmls ="";
				if(result.length < 1){
						html.push("등록된댓글이 없습니다.")
				}else {
					$(result).each(function(){
						htmls += '<tr>';
						htmls += '<td id="rid';
						htmls += this.reply_no;
						htmls += '">';
						htmls += '<div style="padding-right:5px">';
						htmls += this.member_id;
						htmls += '<a href="javascript:void(0)" onclick="javascript:editReply(' + this.reply_no  + ', \'' + this.reply_content + '\')" style="padding-right:5px">수정</a>';
						htmls += '<a href="javascript:void(0)" onClick="javascript:deleteReply('+ this.reply_no + ')">삭제<a>';
						htmls += '</div>';
						htmls += '<div>';
						htmls += this.reply_content;
						htmls += '</div>';
						htmls += '</td>';
						htmls += '</tr>';
					})
				}
				$("#replyTable").html(htmls);
			}
			
		})
}

$(function(){
	showReplyList();
	
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
					showReplyList();
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
			 </table>
          </table>
          		<table id = "replyTable">
			 </table>
		</div>

	
</body>
</html>