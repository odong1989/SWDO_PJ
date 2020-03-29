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
    <script type="text/javascript">
		function selectGroup(pk) {
			location.href="group?no="+pk;
		}
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
	                        <a href="javascript:selectGroup(${glist.group_no })"><p>${glist.group_name }</p></a>
	                        <p class="p-group">#${glist.group_subcategory }</p>
	                    </div>
	                    <div class="menu-group-button-right">
	                    	<c:if test="${abc == 1 }">
                        		<img src="<c:url value='/img/crown_gold.png' />">
                        	</c:if>
                        	<c:if test="${abc == 2 }">
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
            <br/><br/><br/><br/>
                <c:if test="${codebool eq 'ari' }">
	                <br/><strong>${code.GROUP_NAME }</strong> 그룹에 가입하시겠습니까? 
                </c:if>
                <c:if test="${codebool eq 'nashi' }">
	                <br/><font color="red">유효하지 않은 초대코드입니다.</font> 
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>