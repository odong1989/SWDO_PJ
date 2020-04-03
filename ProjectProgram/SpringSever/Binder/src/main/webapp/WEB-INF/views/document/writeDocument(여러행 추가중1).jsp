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
        };
 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트 종료.----------------------------


 	//	function write(pk) {
	//		location.href="<c:url value='/document/writeDocument' />?no="+pk;
	//	}
	</script>
 	<script>	
	var data ='<tr>' 
		data += '<td><input type='file' id="imgInp" name="upload" /></td>'
		data += '<td><img id="previewImg" src="#" alt="첨부한 사진을 미리 볼 수 있습니다." /></td>'
		data += '<td><input type="date" /></td>'
		data += '<td>'
		data += '<input class="add" type="button" value="+" />'
		data += '<input class="delete" type="button" value="-" />'
		data += '</td>'
		data += '</tr>'
	
	$(function(){
		$('table').on('click', 'input[value="+"]', function(){
			$('table').append(data);
		});
		$('table').on('click', 'input[value="-"]', function(){
			$(this).parent().parent().remove();
		}); 
	});
</script>

<!-- --------------------------------------- -->
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
		<!--
			VO인 document.java의 구조를 준수한다.  			//본 폼에서 담당하는 정보 여부
			private int group_no;					//X(본 문서의 번호에서 자동퍼오도록 한다	.)	
			private int document_no;				//X이건 SQL에서 알아서 nextval로 체크.
			private String member_id;				//X세션의 정보를 준다.
			private String document_content;		//ㅇ id='content'
			private String document_regdate;		//ㅇ id='startDate'
			private String document_finalday;		//ㅇ id='endDate'
			private String document_destination;	//ㅇ id='place'  (장소정보이다. 미입력시 널값으로 처리됨)


			-id를 설정한 이유는 유효성검사를 할 수 있도록 하고자 미리 정의한 것임.
		 -->

		 <form action="documentInsert" method="POST" enctype="multipart/form-data"> 
				<table>				
				<form>
			        <tr>
				        <td>
				        	<input type="hidden" name='group_no' value="${writeDocumentGroup_no}"> 				        
				        </td>
			        </tr>
                	<tr height="40px">
	         			<td width="5%"> < </td>
				        <td width="45%">	
				            	<p id='currentDate' style="display:inline;"></p>
				   		        <input type="text" placeholder="장소" id='place' name="document_destination" >
				        </td>
				        <td width="45%">
				        	<input type='date' id='startDate' name='document_regdate'/> 부터 
				            <input type='date' id='endDate' name='document_finalday' />   
				        </td>
				        <td width="5%"> > </td>
					</tr>                     
				   	<tr>
				   		<td colspan="4"> <input type="text" placeholder="#해시태그를 입력해주세요" > </td>
				   	</tr>
				   	<tr>
				   		<td colspan="4" style="text-align:center;">
					   	    <input type="submit" value="등록">
					   		<input type="button" value="취소">
				   		</td>
				   	</tr>
				<tr>
					<td>첨부하실 사진</td>
					<td>사진 미리보기</td>
					<td>기입하실 내용</td>	
					<td></td>
				</tr>
				<tr>
					<td><input type='file' id="imgInp" name="upload" /></td>
					<td><img id="previewImg" src="#" alt="첨부한 사진을 미리 볼 수 있습니다." /></td>
					<td><textarea rows="15" width="300" style="resize: none;" id='content' name="document_content"></textarea> </td>
					<td><input class="add" type="button" value="+" /></td>
				</tr>
				</form>			    
				</table>
			    <!-- ----------------------------  -->			    
	    			<table border="1">
	<tr>
		<th>자격증 명</th>
		<th>시행처</th>
		<th>취득 날짜</th>
		<th></th>
	</tr>
	<tr>
		<td><input type="text" /></td>
		<td><input type="text" /></td>
		<td><input type="date" /></td>
		<td>
			<input class="add" type="button" value="+" />
		</td>
	</tr>
</table>    
			    <!-- ----------------------------  -->
				<script>
			  	        document.getElementById('currentDate').innerHTML = new Date().toISOString().substring(0, 10);
			            document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
			            document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
			    </script>		    

		</div>
	</div>
</body>
</html>