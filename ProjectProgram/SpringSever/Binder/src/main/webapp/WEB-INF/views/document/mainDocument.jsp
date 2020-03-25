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
    	//btn1 : 게시판->캘린더로 변경
		$(document).on("click","#btn1",function(){
			$.ajax({
					url:"<c:url value='/calender/calenderMain' />",
					type:"get",

					success:function(data){			
					alert("수정된 ajax - 캘린더로 변경 실시합니다.!");//[참고용] 작업시작 확인가능.							
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
						alert("게시판로 변경 실시합니다.");//[참고용] 작업시작 확인가능.
						document.getElementById('gaibu-right-bottom').innerHTML=data;
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
            <c:set var="test1" value="glist.group_name" />
            	<c:forEach var="glist" items="${groupJoinList}">
	                <div class="menu-group-button">
	                    <div class="menu-group-button-left">
	                        <p>${glist.group_name }</p>
	                        <p class="p-group">#${glist.group_subcategory }</p>
	                    </div>
	                    <div class="menu-group-button-right">
	                    	${sessionScope.loginLevel1 }
	                    	${sessionScope.loginLevel + glist.group_no }
	                    	<c:if test="${sessionScope.loginLevel + glist.group_no  == 1 }">
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
                    <p><img src="<c:url value='/img/bell.png' />"> 
                       <img src="<c:url value='/img/mail.png' />"> 
                       <img src="<c:url value='/img/human.png' />" id="usericon">
                    </p>
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
    <a href="/member/memberMypage">마이페이지 실시</a>
</body>
</html>