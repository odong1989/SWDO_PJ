<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 부트스트랩 데이터 피커 샘플입니다.
        실행사항1)이전 달은 'X'자로 그려넣어 처리하도록 설정.(#배경그림방식으로 처리)
        실행사항2)
    -->
<!--단계1 : 제이쿼리 등 해당 필요 소스들 로드. -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript'
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript"> 
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
        
        $(function(){
  			$("#btn2").on("click",boardTemp);			
  				function boardTemp(){
  					$.ajax({
  						url:"<c:url value='/document/boardTemp' />",
  						type:"get",
  						success:function(data){			
  							alert("게시판로 변경 실시합니다.");//[참고용] 작업시작 확인가능.
​
  														
  							document.getElementById('gaibu-right-bottom').innerHTML=data;
  							},
  						error:function(){alert("boardDocumnets 로드 중 에러가 발생되었습니다.")}
  					});
  				}
  			});
        </script>
<!--[옵션] 스타일(CSS) 설정입니다. 
            부트스트랩은 실제 실행하면서 로드되므로 본 코드내에서는 확인하실 수 없습니다.
            본 HTML파일을 실행후 개발자모드에서 코드를 확인하세요.
        -->
<style>
table.table-condensed {
	width: 850px; /*데이터피커의 총 가로폭을 설정할 수 있습니다.*/
	height: 450px; /*데이터피커의 총 세로폭을 설정할 수 있습니다.*/
	border-style: double;
	font-family: 돋움; /*데이터피커의 날짜들의 폰트 설정 가능.*/
	background-color:white;
	border: 1px solid black;
	margin-left: 20px;
}

td.day { /*현재 달의 일자들을 설정할 수 있습니다.*/
	color: blue;
	text-align: left;
	font-size: larger;
}

td.old.day {
	text-align: left;
	vertical-align: top;
	padding-left: 1em;
	/*오래전 날짜들은 X선(대각선)을 그을 수 있습니다.
     당장은 필요없다고 답변받아 사용할 수 있도록 주석처리만 함.*/
	/*
     background: <line x1:"0" y1="100%" x2="100%" y2="0" stroke="gray">;
     background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="0" x2="100%" y2="100%" stroke="gray" /><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');*/
}

td.new.day {
	text-align: left;
	vertical-align: top;
	padding-left: 1em;
}
</style>
<!--단계5. HTML body내에 부트스트랩 선언. 여기서 선언해야 작동됩니다.-->
<table id="document-body">
	<tr height="40px">
		<td width="21%"></td>
		<td width="auto" align="center"><p id="notice">공지사항 : ㅇㅇㅇ공지부분</p></td>
		<td width="21%" align="right"><img
			src="<c:url value='/img/f5.png' />" /> 
			<img src="<c:url value='/img/board.png'/>"  id="btn2"/></a>
		</td>
	</tr>
</table>
<div id="datepicker">
	<script>
		$( "datepicker" ).datepicker();
	</script>
</div>