<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${group_name }</title>
<link href="<c:url value='/css/basic.css' />" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type='text/javascript'
	src='http://code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript'
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

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
 
 		function write(pk) {
			location.href="<c:url value='/document/writeDocument' />?no="+pk;
		}
 		
 		
    </script>

</head>
<body>
	<div id="gaibu-top">
		<span id="gaibu-top-left"> 
			<a href="<c:url value='/document/mainDocument' />">
			<img src="<c:url value='/img/logo.png' />"></a>
		</span> <span id="gaibu-top-middle"> </span> <span id="gaibu-top-right">

            <img src="<c:url value='/img/bell.png' />">
			<img src="<c:url value='/img/mail.png' />">
			<a href="<c:url value='/member/memberMypage' />"><img src="<c:url value='/img/human.png' />" id="usericon">
			<a href="<c:url value='/member/memberLogout' />"><img src="<c:url value='/img/logout.png' />"></a>
		</span>
	</div>
	<div id="gaibu">
		<div id="menu">
			<c:forEach var="glist" items="${groupJoinList }">
				<div class="menu-group-button">
					<div class="menu-group-button-left">
						<a href="javascript:selectGroup(${glist.GROUP_NO })"><p>${glist.GROUP_NAME }</p></a>
						<p class="p-hash">#${glist.GROUP_SUBCATEGORY }</p>
					</div>
					<div class="menu-group-button-right">
						<c:if test="${glist.MEMBER_LEVEL == 1 }">
							<img src="<c:url value='/img/crown_gold.png' />">
						</c:if>
						<c:if test="${glist.MEMBER_LEVEL == 2 }">
							<img src="<c:url value='/img/crown_silver.png' />">
						</c:if>
					</div>
					<div class="menu-group-button-clear"></div>
				</div>
			</c:forEach>
		</div>
		<div id="right-body">
		 <form action="documentInsert" method="POST" enctype="multipart/form-data"> 
		 	<!--그룹번호를 같이보내줍니다 -->		
			<table class="wirteDocForm">		
			 	<tr><td><input type="hidden" name='group_no' value="${writeDocumentGroup_no}"></td></tr>
			     	<tr>
				        <td width=15%> <p id='currentDate' style="display:inline;"></p> </td>
				        <td width=25%> <input type="text" placeholder="장소" id='place' name="document_destination" > </td>
				        <td width=30%> <input type='date' id='startDate' name='document_regdate'  style="display:inline;"/> 부터  </td>
				   		<td width=30%> <input type='date' id='endDate' name='document_finalday'  style="display:inline;"/> 까지   </td>
					</tr>
				        
				    <tr>
						<td colspan=3>
       					    <img id="previewImg" src="<c:url value='/img/preViewImage.png' />" width="300" height="300" alt="첨부사진 미리보기" ><br> 
					        <input type='file' id="imgInp" name="upload" />
				        </td>
				    	<td>
				    		<textarea rows="18" width="300" style="resize: none" 
				    		          id='content' name="document_content" placeholder="일정명">
				    		</textarea> 
				    	</td> 
				   	</tr>     
				   	           
				   	<tr border="0px">
				   		<td colspan="4" border="0"> 
				   			<input type="text" placeholder="#해시태그를 입력해주세요" style="width:400px;"> 
				   		</td>
				   	</tr>
           </table>
           <div style="text-align: center;">
					<input type="submit" value="등록">
			   		<input type="button" value="취소">
		   </div>
           </form>
			     <script>
			  	        document.getElementById('currentDate').innerHTML = new Date().toISOString().substring(0, 10);
			            document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
			            document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
			    </script>
		</div>
	</div>
</body>
</html>