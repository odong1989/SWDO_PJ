<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부트스트랩 데이터 피커 샘플 예제</title>
    <!-- 부트스트랩 데이터 피커 샘플입니다.
        실행사항1)이전 달은 'X'자로 그려넣어 처리하도록 설정.(#배경그림방식으로 처리)
        실행사항2)
    -->
    <!--단계1 : 제이쿼리 등 해당 필요 소스들 로드. -->
    <script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
    <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript"> 
    //단계2. 달력을 한글로 표기설정.(없을 시 영문으로 표기됩니다.)
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
        </script>
        <!--[옵션] 스타일(CSS) 설정입니다. 
            부트스트랩은 실제 실행하면서 로드되므로 본 코드내에서는 확인하실 수 없습니다.
            본 HTML파일을 실행후 개발자모드에서 코드를 확인하세요.
        -->
        <style>
            table.table-condensed{    
                width: 500px;         /*데이터피커의 가로폭을 설정할 수 있습니다.*/
                border-style: double;
                font-family:돋움;     /*데이터피커의 날짜들의 폰트 설정 가능.*/
            }
            .table-condensed. td{
                padding-right:50px;
                padding-top: 5px;
            }
            #nextSchedule{
                width:100px;
                height:10px;
                font-size: 10px;
                border-radius: 30%;
            }
            td.old.day{
                text-align:left; 
                background: <line x1:"0" y1="100%" x2="100%" y2="0" stroke="gray">;
                background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="0" x2="100%" y2="100%" stroke="gray" /><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');
            }
            td.new.day{
                color:red;    
                text-align:left;                 
            }
            td.day{ /*현재 달의 일자들을 설정할 수 있습니다.*/
                color:cyan;    
                text-align:left;
                font-size: larger;    
            }
            table.table-condensed.datepicker-title{
                height: 200px;     
                background-color: red;
             }
             div.datepicker-days{
                font-size: 10px;            
                width: 17em; padding: .2em .2em 0; display: none;
            }
            </style>
</head>
<body>
    <!--단계5. HTML body내에 부트스트랩 선언. 여기서 선언해야 작동됩니다.-->
			
    <div id="datepicker" >
    datepicker가 로드되어 실시됩니다.
        <script>
              $( "datepicker" ).datepicker();
        </script>
    </div>
</body>
</html>