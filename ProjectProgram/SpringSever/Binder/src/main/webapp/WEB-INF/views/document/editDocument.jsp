<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

	<style type="text/css">
	#buttonStyle{
		background-color: cornflowerblue;
	    color: white;
	    border: none;
	    padding: 5px;
	    margin: 10px;
    }
	
	/* placeholder 스타일 지정 */
	input::placeholder {
	  color: #08c;
	  opacity: 1; /* 파이어폭스에서 뿌옇게 나오는 현상을 방지하기 위한 css */
	}
	textarea::placeholder {
  	 color: #ff6565;
 	 opacity: 1; /* 파이어폭스에서 뿌옇게 나오는 현상을 방지하기 위한 css */
	}
	
	/* input 기본 스타일 지정 */
	input {
	  padding: 10px;
	}

	/* textarea 기본 스타일 지정 */
	textarea {
	  padding: 10px;
	}
	
	
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
	
	</style>
	
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
	 
	 		function deleteDocument(pk) {
				location.href="<c:url value='/document/deleteDocument' />?no="+pk;
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
	 
		<div id="right-body" >
			<div id="right-body-menuWrap"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->
		</div>
			<div id="right-body-wirteDocWrap" style="background-color:white; padding:10px 10px 30px 20px;"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->
			<table class="wirteDocForm">		
				<form action="documentInsert" onsubmit="return documentInsertCheck();" method="POST" enctype="multipart/form-data">
			     	<tr>
						<!--그룹번호를 같이보내줍니다 -->		
					    <td><input type="hidden" name='group_no' value="${writeDocumentGroup_no}"></td>
				    </tr>
				    <tr style="border-bottom: 1px solid #444444;">
						<!-- <td>여행 일정</td>-->
                        <td> <input type='date' id='start_day' name='document_regdate'  style="display:inline;" value=${document.document_regdate}/> 부터  </td>
                           <td> <input type='date' id='start_time' name='document_finalday'  style="display:inline;" value=${fn:substring(document.document_regdate,0,11)}/> 까지   </td>
					</tr>
				    <tr>
						<c:choose>
							<c:when test="${empty cautionPhoto.photo_savedfile}">
								<td> <img id="previewImg" src="<c:url value='/img/preViewImage.png' />
		 									  width="250" height="250" alt="첨부사진 미리보기" ></td>
							</c:when>
							<c:otherwise>		        							
								<td> <img id="previewImg" src="<c:url value='/profile/${cautionPhoto.photo_savedfile}' />" 
			  								  width="250" height="250" alt="첨부사진 미리보기" /> </td>
							</c:otherwise>
						</c:choose>
                            <td> <textarea rows="14" style="resize: none" id="content" name="document_content" placeholder="하고싶은 말을 적어주세요"></textarea> 
                            </td> 
				   	</tr>     
					<tr>
						<td><input type='file' id="imgInp" name="upload" value="등록사진"/></td>
                        <td> <input type="text" placeholder="장소" id='place' name="document_destination" style="width:160px;"></td>
					</tr>							  
				   	<tr>	
				   		<td colspan="2"> <input type="text" placeholder="#해시태그를 입력해주세요" style="width:500px;"> </td>
				   	</tr>       
				    <tr style="border-top: 1px solid #444444;">
           				<td colspan="3">
				            <div style="text-align: center;">
							<input id="buttonStyle" type="submit" value="수정">
						
							<a href="javascript:deleteDocument(${document.DOCUMENT_NO})">
	                   		<input  id="buttonStyle" type="button" value="삭제">                
							</a>
						
					   		<input id="buttonStyle" type="button" value="취소" onclick="history.back(-1);">
				   			</div>
						</td>
					</tr>
        			   </form>
          		</table>
				</div>

      </div>
 
</body>
</html>