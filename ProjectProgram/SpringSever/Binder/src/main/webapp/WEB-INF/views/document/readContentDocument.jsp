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
function paging(pag){
	showReplyList(pag);
}

function editReply(reply_no, reply_content, member_id){
	var htmls = "";

	htmls += '<div>';

	htmls += member_id;
	
	htmls += '</div>';
		
	htmls += '<input text name="editContent" id="editContent" value = "'+ reply_content +'">';
	
	htmls += '<a href="javascript:replyUpdate(' + reply_no  + ', \'' + reply_content + '\' )" class = "replyUpdate">저장</a>';

	htmls += '<a href="javascript:showReplyList()"class = "replyDelete">취소<a>';




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
					showReplyList();
					}	
					else{
					alert("실패")
					}
				}
	})
}


function deleteReply(reply_no){
	$.ajax({
		type:"post",
		url: "deleteReply",
		data: {
			reply_no : reply_no,
			},
		dataType : "json",
		success : function(result) {
			if(result){
				showReplyList();
				}	
				else{
				alert("실패")
				}
			}
})
}

function showReplyList(currentPage){
	var document_no = $('#document_no').val();

	$.ajax({
			type: "post",
			url: "getReply",
			data: {
				document_no : document_no,
				currentPage : currentPage
			},
			dataType : "json",
			success : function(result){
				var htmls ="";
				var loginId = $('#loginId').val();
				var list = result.list;
				var totalCount = result.totalCount;
				var page = result.page;
				var cnt = 0;
				if(list.length < 1){
						html.push("등록된댓글이 없습니다.")
				}else {
					$(list).each(function(){
						
						htmls += '<div id="rid';
						htmls += this.reply_no;
						htmls += '">';
						
						htmls += '<div class = "replyMemberId">'
						htmls += this.member_id;
						if(this.member_id == loginId){
						htmls += '<a href="javascript:editReply('+ this.reply_no  + ', \'' + this.reply_content + '\', \'' + this.member_id  + '\')" class = "replyUpdate">수정</a>';
						htmls += '<a href="javascript:deleteReply(' + this.reply_no + '\)" class = "replyDelete">삭제</a>';
						}
						htmls += '</div>'
						htmls += '<div class = "replyContent">';
						htmls += this.reply_content;
						htmls += '</div>';
						htmls += '</div>';
						cnt++;						
					})
					pageLoad(result);
				}
				$("#replyTable").html(htmls);
			}
			
		})
}

function pageLoad(result){
	var pageHtmls ="";
	var page = result.page;

	if (page.currentPage != 1) {
		pageHtmls += '<a href="javascript:paging('+ (page.currentPage - 1) + ')" class="pageAtag">◁</a>';
	}

	for (var i = page.startPageGroup ; i < page.endPageGroup ; i++){
			if( i == page.currentPage){
				pageHtmls += '<b class = "nowPage">'+i+'<b>';
			}
			if( i != page.currentPage){
				pageHtmls += '<a href="javascript:paging('+ i +')"class="pageAtag">'+i+'</a>';
			}
		}

	if (page.currentPage != page.totalPageCount) {
		pageHtmls += '<a href="javascript:paging('+ (page.currentPage + 1) +')"class="pageAtag">▷</a>';

	}

	$("#replyPage").html(pageHtmls);
}

function writeRpy(){
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
		
}



$(function(){
	
	showReplyList();
	

	
	$("#reply_content").keyup(function(event) {
		if (event.keyCode == 13) {
			writeRpy();

		}
	})
	$("#btn").click(function(){
			writeRpy();
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
			 </table>
          </table>
	
		<div class = "reply">
          	 	<h6>Reply</h6>
					
						<input type="hidden" id="loginId" value="${sessionScope.loginId}">
						<input type="hidden" id="document_no" name = "document_no" value="${document.document_no }">
						<input type="hidden" id="member_id" value="${loginId }" >
						<input type="text" id="reply_content">
						<input type="button" id="btn" value="댓글등록">
					
          	 	<div id = "replyTable"></div>
          	 	<div id="replyPage"></div>
          	 </div>
       </div>
	
</body>
</html>