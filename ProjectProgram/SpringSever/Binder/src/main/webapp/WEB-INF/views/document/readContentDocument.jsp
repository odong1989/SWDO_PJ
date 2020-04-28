<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>


<script>
function editDocument(pk){
    location.href="<c:url value='/document/editDocument' />?no="+pk;
}
function paging(pag){
	showReplyList(pag);
}
function editReply(reply_no, reply_content, member_id){
	var htmls = "";

    htmls += '<div class = "editDiv"><span id="replyEditId" >';

    htmls += member_id;
    
    htmls += '</span>';
    
    htmls += '<a href="javascript:replyUpdate(' + reply_no  + ', \'' + reply_content + '\' )" class = "replyUpdate">저장</a>';

    htmls += '<a href="javascript:showReplyList()"class = "replyDelete">취소</a>';

    htmls += '</div><div>';
        
    htmls += '<input text name="editContent" id="editContent" value = "'+ reply_content +'" >';

    htmls += '<p id = "editPtag">글을 수정하시려면 저장을 눌러주세요</p>';

		
	$('#rid' + reply_no).replaceWith(htmls);
	

	$('#editContent').focus();


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
						
						htmls += '<div class = "replyMemberId">';
						htmls += '<span class ="replyId">';
						htmls += this.member_id;
						htmls += '</span>';
						if(this.member_id == loginId){
						htmls += '<'
						htmls += '<a href="javascript:editReply('+ this.reply_no  + ', \'' + this.reply_content + '\', \'' + this.member_id  + '\')" class = "replyUpdate">수정</a>';
						htmls += '<a href="javascript:deleteReply(' + this.reply_no + '\)" class = "replyDelete">삭제</a>';
						}
						htmls += '</div>';
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
	pageHtmls += '<div class = "pagingDiv">';
	if(page.currentPage > page.pagePerGroup) {
		pageHtmls += '<a href="javascript:paging('+ (page.currentPage - page.pagePerGroup) + ')" class="atag">◀</a>'
	}
	if (page.currentPage != 1) {
		pageHtmls += '<a href="javascript:paging('+ (page.currentPage - 1) + ')">◁</a>';
	}
	for (var i = page.startPageGroup ; i <= page.endPageGroup ; i++){
			if( i == page.currentPage){
				pageHtmls += '<b class = "replyNowPage">'+i+'</b>';
			}
			if( i != page.currentPage){
				pageHtmls += '<a href="javascript:paging('+ i +')"class="replyPageAtag">'+i+'</a>';
			}
		}
	if (page.currentPage != page.totalPageCount) {
		pageHtmls += '<a href="javascript:paging('+ (page.currentPage + 1) +')">▷</a>';
	}
	if(page.currentPage < (
			page.totalPageCount - (page.totalPageCount % page.pagePerGroup == 0 ?
					  page.pagePerGroup : page.totalPageCount%page.pagePerGroup)
					  + 1)) {
		pageHtmls += '<a href="javascript:paging('+ (page.currentPage + page.pagePerGroup) + ')" class="atag">▶</a>'
	}
	pageHtmls += '</div>';
	$("#replyPage").html(pageHtmls);
}
function writeRpy(){
	var reply_content = $('#replyInput').val();
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
				$("#replyInput").val("");
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
function editDocument(pk){
	location.href="<c:url value='/document/editDocument' />?no="+pk;
}
$(function(){
	
	showReplyList();
	
	$('#replyInput').keyup(function(event) {
		if (event.keyCode == 13) {
			writeRpy();
		}
	})
	
	$("#btn").click(function(){
			writeRpy();
		})	
})
</script>


<style type="text/css">

.main_container {
	background-color:white;
	width:90%; height:90%;
	margin :20px;
/*	background-color: yellow; */
}

.main_destination {/*장소출력*/
	float:left;
	text-align:center;
	width:25%; height:10%;
/*	background-color: red; */
}

.main_days {
	float:left;
	text-align:center;
	width:55%; height:10%;
/*	background-color:orange; */
}

.main_editarea {
	float:left;
	text-align:center;
	width:20%; height:10%;
/*	background-color:green; */
}

.main_photo {
	padding : 3%;
	float:left;
	width:100%; height:300px;
	text-align: center;
/*	background-color:purple; */

}

.main_contents {
	float:left;
	width:100%; height:30%;
<!--	background-color:green;
}
</style>

	<div id="right-body">
		
		<div class="main_container" >
			<div class="main_destination"> <!-- 장소 -->
				<p>${document.document_destination }</p>
			</div>
			
			<div class="main_days"> <!-- 기간 -->
				여행기간 :
		        <p id='startDate' style="display:inline;"/></p>
				${fn:substring(document.document_regdate,0,11)}
				~
				<p id='endDate'  style="display:inline;"/></p> 
	   			${fn:substring(document.document_finalday,0,11)}					
			</div>	
			<div class="main_editarea"> <!-- 본인시 수정버튼 구현 -->
			<c:if test="${sessionScope.loginId == document.member_id}">
				<a href="<c:url value='/document/editDocument' />"><input type="button" value="글 수정하기"></a>
			</c:if>
			</div>				
			<div class="main_photo"> <!-- 사진배치 -->
				<img src="<c:url value='/profile/${cautionPhoto.photo_savedfile}' />"
				width="250px" height="250px"  >
			</div>				
			<div class="main_contents"> <!--  글 배치-->
          	 	<h6 id="replyTitle" style="margin:10px;">Contents</h6>
				&nbsp; &nbsp; ${document.document_content }			
			</div>				
		</div>
			 	
		<!-- 댓글 코드시작 -->	 	
		<div class = "reply">
          	 	<h6 id="replyTitle">Reply</h6>
					
						<input type="hidden" id="loginId" value="${sessionScope.loginId}">
						<input type="hidden" id="document_no" name = "document_no" value="${document.document_no }">
						<input type="hidden" id="member_id" value="${loginId }" >
						<input type="text" id="replyInput">
						<p id="replyP">댓글을 작성하시려면 Enter를 눌러주세요</p>
					
          	 	<div id = "replyTable"></div>
          	 	<div id="replyPage"></div>
          </div>
       </div>
	
</body>
</html>