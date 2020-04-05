<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${group_name }</title>
    <link href="<c:url value='/css/basic.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src='http://code.jquery.com/jquery-1.8.3.js'></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
    
    <script>
    function selectGroup(pk) {
    	location.href="<c:url value='/document/group' />?no="+pk;
    }
    function invite(pk) {
    	location.href="<c:url value='/group/groupcode' />?no="+pk;
    }
    </script>
</head>
<body>
    <div id="gaibu-top">
        <span id="gaibu-top-left">
            <a href="<c:url value='/document/mainDocument' />"><img src="<c:url value='/img/logo.png' />"></a>
        </span>
        <span id="gaibu-top-middle">
            
        </span>
        <span id="gaibu-top-right">
            
            <img src="<c:url value='/img/bell.png' />">
			<c:if test="${newNoteCheck eq 'nashi' }">
				<a href="<c:url value='note/noteList' />"><img src="<c:url value='/img/mail.png' />"></a>
			</c:if>
			<c:if test="${newNoteCheck eq 'ari' }">
				<a href="<c:url value='note/noteList' />"><img src="<c:url value='/img/newmail.png' />"></a>
			</c:if>
			<a href="<c:url value='/member/memberMypage' />"><img src="<c:url value='/img/human.png' />" id="usericon">
			<a href="<c:url value='/member/memberLogout' />"><img src="<c:url value='/img/logout.png' />"></a>
        </span>
    </div>
    <div id="gaibu">
        <div id="menu">
        	<c:if test="${groupJoinList.size() == 0 }">
        		<div class="menu-group-button">
	                    <font size="0.9em">가입된 그룹이 없습니다.</font>
	                    <br/><font align="center"><a href=""><b>그룹 생성</b></a></font>
                </div>
        	</c:if>
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
            <center>
            <br/><br/><br/><br/><br/><br/>
            트렌드<br/>
            #AAA<br/>
            #BBB<br/>
            #CCC
            <img alt="로컬이미지 불러오기 확인용 이미지 (c:\uploadFile\2-2-01.jpg)" src="<c:url value='/profile/2-2-01.jpg' />" height="400px">
            </center>
        </div>
        
    </div>
</body>
</html>