<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- A태그 밑줄제거 -->
<style type="text/css">
.atag{text-decoration:none;}
.atag:link{color:black;}
.atag:hover{color:blue;}
</style>

</head>
<body>

	<!-- ◀는 첫번째 그룹이 아닐 때만 출력
	     (그룹당 페이지 수보다 현재 페이지가 작을 경우에만 출력)	-->
	<c:if test="${navi.currentPage > navi.pagePerGroup }"><a href="javascript:paging('${navi.currentPage - navi.pagePerGroup }')" class="atag">◀</a></c:if>
	
	
	
	<!-- ◁는 현재 페이지가 1페이지가 아닐 때만 출력 -->
	<c:if test="${navi.currentPage != 1 }"><a href="javascript:paging('${navi.currentPage - 1 }')" class="atag">◁</a></c:if>
	
	
	
	
	<!-- 실제 숫자가 출력되는 부분 -->
	<c:forEach begin="${navi.startPageGroup}" end="${navi.endPageGroup}" var="num">
		<c:if test="${num == navi.currentPage }">
			<b>${num }</b>	
		</c:if>
		<c:if test="${num != navi.currentPage }">
			<a href="javascript:paging('${num }')" class="atag">${num }</a>
		</c:if>
	</c:forEach>
	
	
	
	<!-- ▷는 현재 페이지가 마지막 페이지가 아닐 때만 출력 -->
	<c:if test="${navi.currentPage != navi.totalPageCount }"><a href="javascript:paging('${navi.currentPage + 1 }')" class="atag">▷</a></c:if>
	
	
	
	<!-- ▶는 마지막 그룹이 아닐 때만 출력
	마지막페이지 - 그룹당 페이지 수 (마지막 페이지를 그룹당 페이지로 나눈 값이 0일 때)
				 - 마지막페이지를 그룹당 페이지 수로 나눈 나머지 (마지막 페이지를 그룹당 페이지로 나눈 값이 0이 아닐 때)
				 + 1			-->
	<c:if test="${navi.currentPage < (
		navi.totalPageCount - (navi.totalPageCount % navi.pagePerGroup == 0 ?
		  navi.pagePerGroup : navi.totalPageCount%navi.pagePerGroup)
		  + 1)}">
		<a href="javascript:paging('${navi.currentPage + navi.pagePerGroup }')" class="atag">▶</a></c:if>
</body>
</html>