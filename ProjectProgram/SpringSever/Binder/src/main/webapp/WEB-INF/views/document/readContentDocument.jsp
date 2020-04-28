<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>


<script>

function paging(pag){
	showReplyList(pag);
}

function showReplyList(currentPage){
	var document_no = $('#document_no').val();
	var cnt = 0;
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
						htmls += '<span class ="replyId">';
						htmls += this.member_id;
						htmls += '</span>';
						if(this.member_id == loginId){
						htmls += '<span class = "replyUpdate">수정</span>&nbsp;';
						htmls += '<span class = "replyDelete">삭제</span>';
						}
						htmls += '<div></div>'						
						htmls += '<input type = "text"   class = "replyContent" value ="'+ this.reply_content +'" readonly>';
						htmls += '<input type = "hidden" class = "replyNoHidden" value ="'+ this.reply_no +'">';
						htmls += '<input type = "hidden" class = "pagingC" value ="'+ page.currentPage +'">';
						htmls += '</div>';
						
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
	var temp;
		
	$('#replyInput').keyup(function(event) {
		if (event.keyCode == 13) {
			writeRpy();
		}
	})
	
	$("#btn").click(function(){
			writeRpy();
		})

	$(document).on('click','.replyUpdate',function() {	
         temp = $(this).parent().children('.replyContent').val();
         $(this).parent().children('.replyContent').prop('readonly', false);
         $(this).text('저장');
         //$(this)의 클래스를 btn2 바꿔준다
         $(this).addClass('editReply');
         $(this).removeClass('replyUpdate');
         
         $(this).parent().children('.replyDelete').text('취소');
         $(this).parent().children('.replyDelete').addClass('cancleReply');
         $(this).parent().children('.replyDelete').removeClass('replyDelete');
      })
      
       $(document).on('click','.replyDelete',function() {
		 var reply_no = $(this).parent().children('.replyNoHidden').val();
		 var page = $(this).parent().children('.pagingC').val();

			$.ajax({
				type:"post",
				url: "deleteReply",
				data: {
					reply_no : reply_no,
					},
				dataType : "json",
				success : function(result) {
					if(result){
						showReplyList(page);
						}	
						else{
						alert("실패")
						}
					}
			})
       })
      

      $(document).on('click','.cancleReply',function(){
    	  $(this).parent().children('.replyContent').val(temp);
          $(this).text('삭제');
          $(this).addClass('replyDelete');
          $(this).removeClass('cancleReply');
          $(this).parent().children('.editReply').text('수정');
          $(this).parent().children('.editReply').addClass('replyUpdate');
          $(this).parent().children('.editReply').removeClass('editReply');
          $(this).parent().children('.replyContent').prop('readonly', true);  
       })
       
      $(document).on('click','.editReply',function() {
    	  var reply_content = $(this).parent().children('.replyContent').val();
    	  var reply_no = $(this).parent().children('.replyNoHidden').val();
    	  var page = $(this).parent().children('.pagingC').val();
          $(this).text('수정');
         $(this).addClass('replyUpdate');
         $(this).removeClass('editReply');
         $(this).parent().children('.cancleReply').text('삭제');
         $(this).parent().children('.cancleReply').addClass('replyDelete');
         $(this).parent().children('.cancleReply').removeClass('cancleReply');
         //ajax이용해서 서버와 통신
       
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
			        //통신이 완료되면 다시 readonly를 준다
			        $(this).parent().children('.replyContent').prop('readonly', true);
					showReplyList(page);
					$(this).parent().children('.replyContent').focus();
					}	
					else{
					alert("실패")
					}
				}
      })
	})
})
</script>


<style type="text/css">

.main_container {
	background-color:white;
	width:90%; height:270px;
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

.main_edit {
	float:left;
	text-align:center;
	width:20%; height:10%;
/*	background-color:green; */
}
div#submain-clear {
	clear:both;
}
.main_photo {
	float:left;
	width:50%; height:300px;
	text-align: center;
/*	background-color:purple; */
}
.main_contents {
	padding-top: 50px;
	float:left;
	width:50%; height:300px;
/*-	background-color:green; */ 
}
div#contentPart-clear {
	clear: both;
}
</style>

	<div id="right-body">
		
		<div class="main_container" >
			<div class="submain">
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
	            <div class="main_edit"> <!-- 작성자만 수정버튼이 표시됨. -->
	                <a href="javascript:edit(${document.document_no})">
	                    <input type="button" value="글 수정하기">                
	                </a>
				</div>
				<div id="submain-clear"></div>	
			</div>
			<!-- submain 여기까지 -->
						
						
			<div id="contentPart">
				<div class="main_photo"> <!-- 사진배치 -->
					<img src="<c:url value='/profile/${cautionPhoto.photo_savedfile}' />"
					width="250px" height="250px"  >
				</div>				
				<div class="main_contents"> <!--  글 배치-->
	          	 	<h6 id="replyTitle" style="margin:10px;">Contents</h6>
					&nbsp; &nbsp; ${document.document_content }			
				</div>
				<div id="contentPart-clear"></div>				
			</div>
			<!-- contentPart 끝 -->
			
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