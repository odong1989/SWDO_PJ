<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="/css/suggest_Page_Basic.css", rel="stylesheet">
</head>
<body>
    <div id="WrapAll">
        <div id="WrapLeft">
            <div id="Logo">
            <p><img src="/img/logo.jpg" height="100px"></p>
            </div>
            <div id="left-menu">
                <div class="menu-group-button">
                    <div class="menu-group-button-left">
                        <p>그룹1</p>
                        <p class="p-group">#가족그룹</p>
                    </div>
                    <div class="menu-group-button-right">
                        <img src="/img/crown_gold.png">
                    </div>
                    <div class="menu-group-button-clear"></div>
                </div>
                <div class="menu-group-button">
                    <div class="menu-group-button-left">
                        <p>그룹2</p>
                        <p class="p-group">#가족그룹</p>
                    </div>
                    <div class="menu-group-button-right">
                        <img src="/img/crown_silver.png">
                    </div>
                    <div class="menu-group-button-clear"></div>
                </div>
                <div class="menu-group-button">
                    <div class="menu-group-button-left">
                        <p>그룹3</p>
                        <p class="p-group">#단체그룹</p>
                    </div>
                    <div class="menu-group-button-right">
                    <img src="/img/human.png"> 
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
                    <p><img src="/img/bell.png"> <img src="/img/mail.png"> <img src="/img/human.png"></p>
                <!-- </div> -->
            </div>
            <!--<div id="gaibu-right-bottom">-->
                <table id="board">
                    <tr height="40px">
                        <td width="21%"></td>
                        <td width="auto" align="center"><p id="board_title">공지사항 : ㅇㅇㅇ공지부분</p></td>
                        <td width="21%" align="right">
                        	<img src="/img/f5.png"> 
                        	<a href="/board/MoveToCalendar"><img src="/img/cal.png"></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="board_List">
                            <a href="">
                                <div class="document-image">
                                    <div class="document-image-bottom">
                                        <p>영수네 집</p>
                                    </div>
                                </div>
                            </a>
                        </td>
                        <td colspan="2" class="board_List">
                            <div class="document-content">
                                <p>3월 19일</p>
                                <p>#내생일 #니생일 #생일빵</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="board_List">
                            <a href="">
                                <div class="document-image">
                                    <div class="document-image-bottom">
                                        <p>PC방</p>
                                    </div>
                                </div>
                            </a>
                        </td>
                        <td colspan="2" class="board_List">
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

