<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${group_name }</title>
    <link href="<c:url value='/css/basic.css' />", rel="stylesheet">

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
​    <!-- <script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
    <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>


    <script type="text/javascript">
    	var temp = '';
		function selectGroup(pk) {
			location.href="group?no="+pk;
		}

		//20.03.29 병합 되지 않아서 직접 추가1 - 부트스트랩 한글 표기설정
		   //단계2. 달력을 한글로 표기설정.(없을 시 영문으로 표기됩니다.)
	    //로드할 메인jsp에서 설정해둬야 적용되어서 주석처리해도 무방합니다..
	    (function($){
	    $.fn.datepicker.dates['kr'] = {
	                days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
	                daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
	                daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
	                months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	                monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	            };
	        }(jQuery));
	        
	        //단계3. 부트스트랩 기본설정 
	        $(function(){
	            $('#datepicker').datepicker({
	                calendarWeeks: false,
	                todayHighlight: true,
	                language: "kr"
	            })
	        //단계4. 사용자가 선택한 날짜를 alert로 출력합니다.
	            .on("changeDate",function(e){
	                alert(e.date);
	            })
	        });

		//20.03.29 병합 되지 않아서 직접 추가2 - 게시판<->캘린더 스위칭.
		
		
		
		//btn1 : 게시판->캘린더로 변경
		$(document).on("click","#btn1",function(){
			$.ajax({
					url:"<c:url value='/calender/calenderMain' />",
					type:"get",
					success:function(data){
						temp = document.getElementById('gaibu-right-bottom').innerHTML;
						document.getElementById('gaibu-right-bottom').innerHTML=data;
				//부트스트랩-데이트피커 실행문
						$('#datepicker').datepicker({
			                calendarWeeks: false,
			                todayHighlight: true,
			                language: "kr"
			            });
					},
					error:function(){alert("캘린더 로드 중 에러가 발생되었습니다.")}
			});
		});
		//btn2 : 캘린더->게시판으로 변경
		$(document).on("click","#btn2",function(){
			$.ajax({
					url:"<c:url value='/document/boardTemp' />",
					type:"get",
					success:function(data){		
						document.getElementById('gaibu-right-bottom').innerHTML=temp;
						//document.getElementById('gaibu-right-bottom').innerHTML=data;
					},
					error:function(){alert("게시판(document) 로드 중 에러가 발생되었습니다.")}
			});
		});
    </script>
</head>
<body>
    <div id="gaibu">
        <div id="gaibu-left">
            <div id="gaibu-left-top">
            <p><img src="http://erines.kr/cat.jpg" height="100px"></p>
            </div>
            <div id="left-menu">
            	   	<c:forEach var="glist" items="${groupJoinList }">
	                <div class="menu-group-button">
	                    <div class="menu-group-button-left">
	                        <a href="javascript:selectGroup(${glist.GROUP_NO })"><p>${glist.GROUP_NAME }</p></a>
	                        <p class="p-group">#${glist.GROUP_SUBCATEGORY }</p>
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
        </div>
        <div id="gaibu-right">
            <div id="gaibu-right-top">
                <div id="naibu-right-left">
                    
                </div>
                <!-- <div id="naibu-right-right"> -->
                    <p><img src="<c:url value='/img/bell.png' />"> <img src="<c:url value='/img/mail.png' />"> <img src="<c:url value='/img/human.png' />" id="usericon"></p>
                <!-- </div> -->
            </div>
            <div id="gaibu-right-bottom">
                <table id="document-body">
                    <tr height="40px">
                        <td width="21%"></td>
                        <td width="auto" align="center"><p id="notice">공지사항 : ㅇㅇㅇ공지부분</p></td>
                        <td width="21%" align="right">
                        <img src="<c:url value='/img/f5.png' />"> 
                        	<a id="btn1">
 								<img  src="<c:url value='/img/cal.png' />">
                        	</a>	                        
                        </td>
                    </tr>
                    <c:forEach var="dlist" items="${documentList }">
	                    <tr>
	                        <td class="document-one">
	                            <a href="">
	                                <div class="document-image">
	                                    <div class="document-image-bottom">
	                                        <p>${dlist.DOCUMENT_DESTINATION }</p>
	                                    </div>
	                                </div>
	                            </a>
	                        </td>
	                        <td colspan="2" class="document-one">
	                            <div class="document-content">
	                                <p>${dlist.DOCUMENT_REGDATE }</p>
	                                <p>#내생일 #니생일 #생일빵</p>
	                            </div>
	                        </td>
	                    </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</body>
</html>