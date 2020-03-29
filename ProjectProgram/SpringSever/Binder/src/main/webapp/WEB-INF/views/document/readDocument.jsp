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
                        <td width="21%" align="right"><img src="<c:url value='/img/f5.png' />"> <img src="<c:url value='/img/cal.png' />"></td>
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