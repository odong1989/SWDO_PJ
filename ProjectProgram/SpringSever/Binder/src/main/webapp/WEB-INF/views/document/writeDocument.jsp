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
        $(function() {
            $("#imgInp").on('change', function(){
                readURL(this);
            });
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
            }
        }


    </script>


출처: https://touchsoul.tistory.com/84 [Knowledge Box]

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
		<form action="/notice/noticeInsert" method="POST" enctype="multipart/form-data">
                <table id="document-body" border="1px;">
                	<tr height="40px">
	         			<td width="5%"> < </td>
				        <td width="45%">	
				            	<p id='currentDate' style="display:inline;"></p>
				   		        <input type="text" placeholder="장소" >
				        </td>
				        <td width="45%">
				        	<input type='date' id='startDate'/> 부터 
				            <input type='date' id='endDate'/>   까지
				        </td>
				        <td width="5%"> > </td>
					</tr>        
				    <tr>
				        <td style="width:50%;" colspan="2">
				    		    <form id="form1" runat="server">
 						        <input type='file' id="imgInp" name="upload" />
       						    <img id="blah" src="#" alt="your image" />
                                </form>
				        </td>

				    	<td style="width:50%;" colspan="2">
				    		<textarea rows="15" width="300" style="resize: none;"></textarea> 
				    	</td> 
				   	</tr>                
				   	<tr>
				   		<td colspan="4"> <input type="text" placeholder="#해시태그를 입력해주세요" > </td>
				   	</tr>
				   	<tr ">
				   		<td colspan="4" style="text-align:center;">
					   		<input type="button" value="확인">
					   		<input type="button" value="취소">
				   		</td>
				   	</tr>
                 </table>
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