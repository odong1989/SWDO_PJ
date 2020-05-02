<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

		<div id="right-body" >
			<div id="right-body-menuWrap"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->

		</div>
			<div id="right-body-wirteDocWrap" style="background-color:white; padding:10px 10px 30px 20px;"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->
			<form id="writeForm" action="documentInsert" onsubmit="return documentInsertCheck();" method="POST" enctype="multipart/form-data">			
				<table class="wirteDocForm">		
			     	<tr>
			     	    <td> 오늘 날짜 : <p id='currentDate' style="display:inline;"></p> </td>
						<!--그룹번호를 같이보내줍니다 -->		
					    <td><input type="hidden" name='group_no' value="${writeDocumentGroup_no}"></td>
				    </tr>
				    <tr style="border-bottom: 1px solid #444444;">
						<!-- <td>여행 일정</td>-->
				        <td> <input type='date' id='startDate' name='document_regdate'  style="display:inline;"/> 부터  </td>
				   		<td> <input type='date' id='endDate' name='document_finalday'  style="display:inline;"/> 까지   </td>
					</tr>
				    <tr>
 						<!-- <td rowspan="3" style="text-align:center;vertical-align:middle;">사진등록<br>
							&기록하기</td>-->
						<td> <img id="previewImg" src="<c:url value='/img/preViewImage.png' />"
						      width="250" height="250" alt="첨부사진 미리보기" ></td>
				    	<td> <textarea rows="14" width="300" style="resize: none" id="content" name="document_content"></textarea> </td> 
				   	</tr>     
					<tr>
						<td><input type='file' id="imgInp" name="upload" value="등록사진"/></td>
						<td> <input type="text" placeholder="장소" id='place' name="document_destination" style="width:160px;"><div id="sights"></div></td>
					</tr>
				   	<tr>	
				   		<td colspan="2">
				   			<div id="hashbox">
				   				<input type="text" name="hashtag" placeholder="#hash" style="width:100px;" autocomplete="off">&nbsp;
				   			</div>
				   			<div id="hashbox2">
				   			</div>
				   			<div id="hashman">
				   				<span id="addHash"><img src="<c:url value='/img/plus.png'/>"></span>
				   			</div>
				   			<div id="hashclear">
				   			</div>
				   			<div id="hash_result"></div>
				   		</td>
				   	</tr>       
				    <tr style="border-top: 1px solid #444444;">
           				<td colspan="3">
				            <div style="text-align: center;">
							<input type="submit" value="글 등록하기" style="margin-right:300px;">
					   		<input type="button" value="취소" onclick="history.back(-1);">
				   			</div>
						</td>
					</tr>
	          		</table>
				</form>
				</div>
			<input type="hidden" id="subcat" value="${subcat }">
      </div>
     <script>
  	        document.getElementById('currentDate').innerHTML = new Date().toISOString().substring(0, 10);
            document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
            document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
    </script>

	<style>
	
	table.wirteDocForm {
    /*width: 100%;*/
    margin-left: 100px;
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
	div#hash_result{
		background-color:white;
		position:absolute;
	}
	div#sights{
		padding:15px;
		border-radius:10px;
		background-color:white;
	}
	span.exam{
		margin:2px 0;
		cursor:pointer;
	}
	p#p-1line{
		fone-size:1.5em;
	}
	span#span-weight{
		font-weight: bold;
		cursor:pointer;
	}
	p#p-3line{
		font-size:1.2em;
		cursor:pointer;
		text-align:center;
		margin-top:5px;
	}
	p#p-close{
		text-align:right;
	}
	input#closeBtn{
	    background-color: lavender;
	    border: 1px solid;
	    padding: 5px 10px;
	    color: black;
	}
	
	
	/* 
	#right-body{background-color: green;  height: 500px;}
	
    .wirteDocForm th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  	}
  	*/
	</style>
	
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
		        var selector;
		        
	            $("#imgInp").on('change', function(){
	                readURL(this);
	            });

	            //예시를 클릭하면 입력
	            $(document).on('click','.exam',function() {
	    			selector.val($(this).text());
	    			$("#hash_result").empty();
	    			$("#hash_result").css("border","0");
	    		});


				//name=hashtag 키입력
	            $(document).on('keyup','input[name=hashtag]',function(event) {
					//해시태그 박스 이동
					//좌표구하기 및 크기조정
					var divX = $(this).offset().left;
					var divY = $(this).offset().top;
					var divW = $(this).width();
					selector = $(this);
					//$('#hash_result').css('position', 'absolute');
					$('#hash_result').css('width', divW);
					$('#hash_result').css('left', divX);
					$('#hash_result').css('top', divY+30);
					
					//해시태그 박스에 검색결과가 없으면 테두리를 제거					
	    			if($('#hash_result').html() == "") {
	    				$("#hash_result").css("border","0");
	    			}

					//유효 입력일 때
	    			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
	    				var inputVal = $(this).val();
	    				if (inputVal.length != 0) {
	    					$("#hash_result").empty();
	    					//검색
	    					$.ajax({
	    						url : "hashSearch",
	    						type : "post",
	    						data : {"hash" : inputVal},
	    						success : function(result) {
	    							var osusume = '';
	    							for (let i = 0; i < 5; i++) {
	    								if(result[i] != null) {
	    									osusume += '<span class="exam">' + result[i] + '</span>';
	    									osusume += '<br/>';
	    								} else {
	    									break;
	    								}
	    							}
	    							//해시태그 박스에 테두리 입력
	    							$("#hash_result").css("border","1px solid gray");
	    							$("#hash_result").html(osusume);
	    							},
	    						error : function() {
	    							alert("통신 에러");
	    						}
	    					})
	    				}
	    			}//해시태그 검색 완료
	    		});//name=hashtag 키입력 이벤트 종료


	    		//추천명소 검색
	    		//장소 좌표 가져오기
	    		var placeLeft = $('#place').offset().left;
	    		var placeTop = $('#place').offset().top;
	    		var placeWidth = $('#place').width();

	    		//div위치 설정
	    		$('#sights').css('position', 'absolute');
				$('#sights').css('left', placeLeft + placeWidth + 10);
				$('#sights').css('top', placeTop);
	    		
				//서브카테고리 가져오기
	    		var subcat = $('#subcat').val();
	    		//검색 시작
	    		$.ajax({
					url : "sightsSearch",
					type : "post",
					data : {"subcat" : subcat},
					success : function(result) {
							//받아온 데이터가 있다면
							if(result != null && result.length != 0) {
								//해시태그 박스에 테두리 입력
								$("#sights").css("border","1px solid gray");
								$("#sights").css("background-color","white");
								var osusume2 = '';
								osusume2 += '<p id="p-2line">최근 <span id="span-weight">' + subcat + '</span> 카테고리에서<br/>'
								osusume2 += '가장 많이 방문한 곳입니다.<br/></p><p id="p-3line">';
								osusume2 += result;
								osusume2 += '</p>';
								osusume2 += '<p id="p-close"><input type="button" id="closeBtn" value="닫기"></p>';
								$("#sights").html(osusume2);
							//없다면
							} else {
								$('#sights').remove();
							}
						},
					error : function() {
						console.log("통신 에러");
					}
				})
				//추천명소 검색 끝

				$(document).on('click','#closeBtn',function(){
					$('#sights').remove();
				})
				$(document).on('click','#p-3line',function(){
					$('#place').val($(this).text());
					$('#sights').remove();
				})
				
			
	        });//onload 끝
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
				//var hasharray = 
				var okform = document.getElementById("writeForm"); 

				okform.hashtag = document.getElementsByName("hashtag");
				
				okform.submit();
		        
				return false;
			}
	
	 //유효성체크 종료------------------------------------------------------------------
	</script>
</body>
</html>