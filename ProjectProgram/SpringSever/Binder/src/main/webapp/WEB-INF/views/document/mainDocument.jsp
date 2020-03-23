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
</head>
<body>
    <div id="gaibu">
        <div id="gaibu-left">
            <div id="gaibu-left-top">
            <p><img src="http://erines.kr/cat.jpg" height="100px"></p>
            </div>
            <div id="left-menu">
                <div class="menu-group-button">
                    <div class="menu-group-button-left">
                        <p>그룹1</p>
                        <p class="p-group">#가족그룹</p>
                    </div>
                    <div class="menu-group-button-right">
                        <img src="<c:url value='/img/crown_gold.png' />">
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
                        <!-- <img src="human.png"> -->
                    </div>
                    <div class="menu-group-button-clear"></div>
                </div>
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
                        <td width="21%" align="right"><img src="<c:url value='/img/f5.png' />"> <img src="<c:url value='/img/cal.png' />"></td>
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