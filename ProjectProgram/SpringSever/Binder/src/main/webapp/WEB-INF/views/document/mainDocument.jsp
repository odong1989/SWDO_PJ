<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${group_name }</title>
    <link href="<c:url value='/css/basic.css' />", rel="stylesheet">

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
    <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
    
    <script type='text/javascript'>
        //부트스트랩 데이트 피커 달력 한글 출력 설정입니다.
        (function($){
            $.fn.datepicker.dates['kr'] = {
                days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
                daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
                daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
                months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
            };
        }(jQuery));

        $(function(){
            $('#datepicker').datepicker({
                calendarWeeks: false,
                todayHighlight: true,
                language: "kr"
            });
       });

        $(function(){
			$("#btn1").on("click",calenderMain);
			
			function calenderMain(){
				$.ajax({
					url:"/calender/calenderMain",
					type:"get",
					success:function(data){			
						//alert("캘린더를 실시합니다.");//[참고용] 작업시작 확인가능.
						//alert("data : "+data);//[참고용]/calender/calenderMain.jsp의 소스코드가 로드됨을 확인할 수 있습니다. 
						//console.log("data : "+data);//[참고용]/calender/calenderMain.jsp의 소스코드가 로드됨을 확인할 수 있습니다.
						
						//innerHTMl을 통해 기존의 게시판 부분을 데이터피커관련내용으로 변경합니다.
						document.getElementById('gaibu-right-bottom').innerHTML=data;

						//데이터피커를 실행하도록 합니다.(외부에서 로드된 탓인지 아래의 코드를 통해 재시동 필요.)
						   $('#datepicker').datepicker({
				                calendarWeeks: false,
				                todayHighlight: true,
				                language: "kr"
				            });
					},
					error:function(){alert("캘린더 로드 중 에러가 발생되었습니다.")}
				});
			}
        });
	      	//로드후초기화 실시
        	/*
            $('#datepicker').load(function(){
                $('#datepicker').datepicker({				
                    calendarWeeks: false,
                    todayHighlight: true,
                    language: "kr"
                })
            })*/			
		
	</script>
	
</head>
<body>
    <div id="gaibu">
        <div id="gaibu-left">
            <div id="gaibu-left-top">
            <p><img src="http://erines.kr/cat.jpg" height="100px"></p>
            </div>
            <div id="left-menu">
            <c:set var="test1" value="glist.group_name" />
            	<c:forEach var="glist" items="${groupJoinList }">
	                <div class="menu-group-button">
	                    <div class="menu-group-button-left">
	                        <p>${glist.group_name }</p>
	                        <p class="p-group">#${glist.group_subcategory }</p>
	                        <p>${glist.group + _name }</p>
	                    </div>
	                    <div class="menu-group-button-right">
	                    	<c:if test="${loginLevel+glist.group_no == 1 }">
                        		<img src="<c:url value='/img/crown_gold.png' />">
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
                        	<a id="btn1"><img  src="<c:url value='/img/cal.png' />"></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="document-one">
                            <a href="">
                                <div class="document-image">
                                    <div class="document-image-bottom">
                                        <p>영수네 집</p>
                                    </div>
                                </div>
                            </a>
                        </td>
                        <td colspan="2" class="document-one">
                            <div class="document-content">
                                <p>3월 19일</p>
                                <p>#내생일 #니생일 #생일빵</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="document-one">
                            <a href="">
                                <div class="document-image">
                                    <div class="document-image-bottom">
                                        <p>PC방</p>
                                    </div>
                                </div>
                            </a>
                        </td>
                        <td colspan="2" class="document-one">
                            <div class="document-content">
                                <p>3월 17일</p>
                                <p>#ㅇㅇ #ㄴㄴ #ㅋㅋ</p>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>