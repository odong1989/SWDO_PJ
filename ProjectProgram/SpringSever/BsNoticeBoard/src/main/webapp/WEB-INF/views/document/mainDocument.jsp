<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <c:choose>
                    	<c:when test="${empty groupJoinList}"> 
							<tr>
								<td>
	                            <p style="color: red">아직 가입한 그룹이 없으시네요! </p>
								</td>
							</tr>
	                    </c:when>
                    
	                    <c:otherwise>
							<c:forEach var="Group" items="${groupJoinList}">
			                    <div class="menu-group-button-left">
									<p>${Group.group_name}</p>
		            		        <p class="p-group">${Group.group_subcategory}</p>
		                    	</div>					
		                    	<div class="menu-group-button-clear"></div>
							    <img src="/img/crown_silver.png">
							</c:forEach>		
    					</c:otherwise>
                    </c:choose>
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
                        	<a href="/calender/calenderMain"><img src="/img/cal.png"></a>
                        </td>
                    </tr>
                    <c:choose>
                    	<c:when test="${empty documentList}"> 
							<tr>
								<td>
	                            <p style="color: red">작성하신 글이 없네요! </p>
								</td>
							</tr>
	                    </c:when>
                    
	                    <c:otherwise>
		                    <c:forEach var="Document" items="${documentList}">		
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
			                                <p>	${Document.document_content }</p>
											<p style="color: red">
												<c:forEach var="HashTag" items="${hashTagList}">
												${HashTag.hash_tag}
												</c:forEach>
			                                </p>
			                            </div>
			                        </td>
			                    </tr>
							</c:forEach>
    					</c:otherwise>
                    </c:choose>
                </table>
            </div>
        </div>

</body>
</html>