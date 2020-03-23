
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>${group_name }</title>
    <link href="/css/suggest_Page_Basic.css", rel="stylesheet">
    
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
        //---------------------------------------------------------------------------------------------
        </script>
        <style>
            table.table-condensed{
                width: 500px;
                border-style: double;
                font-family:돋움;
            }
            td{
                padding-left: 10px;
                padding-top: 5px;
            }
            #nextSchedule{
                width:100px;
                height:10px;
                font-size: 10px;
                border-radius: 30%;
            }
            td.old.day{
                color:red; /*테스트겸 폰트컬러 변경시도, 안먹히는 상태.*/   
                text-align:left; 
                background: <line x1:"0" y1="100%" x2="100%" y2="0" stroke="gray">;
                background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="0" x2="100%" y2="100%" stroke="gray" /><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');
            }
            td.new.day{
                color:red;    
                text-align:left;                 
            }
            td.day{
                color:cyan;    
                text-align:left;
                font-size: larger;    
            }
            td{
                color:chocolate;                
            }
            table.table-condensed.datepicker-title{
                height: 200px;     
                background-color: red;
             }
             div.datepicker-days{
                background-color: rgb(255, 166, 0);/*영역확인용*/
                font-size: 10px;            
                width: 17em; padding: .2em .2em 0; display: none;
            }
            </style>
</head>
<body>
    <div id="WrapAll">
        <div id="WrapLeft">
            <div id="Logo">
            <p><img src="http://erines.kr/cat.jpg" height="100px"></p>
            </div>
            <div id="left-menu">
                <div class="menu-group-button">
                    <div class="menu-group-button-left">
                        <p>그룹1</p>
                        <p class="p-group">#가족그룹</p>
                    </div>
                    <div class="menu-group-button-right">
                        <img src="crown_gold.png">
                    </div>
                    <div class="menu-group-button-clear"></div>
                </div>
                <div class="menu-group-button">
                    <div class="menu-group-button-left">
                        <p>그룹2</p>
                        <p class="p-group">#가족그룹</p>
                    </div>
                    <div class="menu-group-button-right">
                        <img src="crown_silver.png">
                    </div>
                    <div class="menu-group-button-clear"></div>
                </div>
                <div class="menu-group-button">
                    <div class="menu-group-button-left">
                        <p>그룹3</p>
                        <p class="p-group">#단체그룹</p>
                    </div>
                    <div class="menu-group-button-right">
                    <img src="human.png"> 
                    </div>
                    <div class="menu-group-button-clear"></div>
                </div>
            </div>  
        </div>
        <div id="WrapRight">
            <div id="MemberMenu">
                <div id="naibu-right-left">
                </div>
                <!-- <div id="naibu-right-right"> -->
                    <p><img src="bell.png"> <img src="mail.png"> <img src="human.png"></p>
                <!-- </div> -->
            </div>
                <!--<div id="gaibu-right-bottom">-->

                    <div id="datepicker" >
                        <script>
                              $( "datepicker" ).datepicker();
                        </script>
                    </div>
            </div>
        </div>
</body>
</html>