<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	a{text-decoration:none; color:black;}
	.atag:link{color:black; text-decoration:none;}
	.atag:hover{color:red;}
	.atag:visited{text-decoration:none;}
	.atag:active{text-decoration:none; color:purple;}
	.overtd:hover{background-color:#EEEEEE;}
</style>
<script type="text/javascript">
function boardWriteForm() {
	location.href="boardWriteForm";
}
function selectBoardOne(pkey) {
	var pk = document.getElementById("pk");
	var currentPage = document.getElementById("currentPage");
	var cpform = document.getElementById("cpform");
	
	pk.value=pkey;
	cpform.submit();
	//location.href="selectBoardOne?board_no="+pk+"&currentPage="+cp;
}
function paging(page) {
	var pagingForm = document.getElementById("pagingForm");
	var currentPage = document.getElementById("currentPage");
	currentPage.value = page;
	pagingForm.submit();
}
function login(cp) {
	var div = document.getElementById("logindiv");
	var str = "";
		str += "<form action='../member/memberLogin' method='post'>";
		str += "ID : <input type='text' name='member_id'> <br/>";
		str += "PW : <input type='password' name='member_pw'> <br/>";
		str += "<input type='hidden' name='target' value='/board/boardList?currentPage=";
		str += cp+"'>";
		str += "<input type='submit' value='로그인'>";
		str += "</form>";
	div.innerHTML = str;
}
function logout(cp) {
	location.href="../member/memberLogout?target="+"/board/boardList?currentPage="+cp;
}
</script>
</head>
<body>
<div align="center">

<!-- 로그인 x -->
<c:if test="${sessionScope.loginId == null }">
	<p>로그인 후 이용 가능합니다.</p>
	<c:if test="${errMsg != null }">
		<font color="red">${errMsg }</font>
	</c:if>
	<table>
		<form action='../member/memberLogin' method='post'>
		<tr>
			<td>ID</td>
			<td><input type='text' name='member_id'></td>
		<tr>
			<td>PW</td>
			<td><input type='password' name='member_pw'></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type='hidden' name='target' value='/board/boardList?currentPage=${navi.currentPage }'>
				<input type='submit' value='로그인'>
			</td>
		</tr>
		</form>
	</table>
</c:if>

<!-- 로그인 o -->
<c:if test="${sessionScope.loginId != null }">
	<a href="javascript:logout('${navi.currentPage }')">로그아웃</a><br/>

	<div id="logindiv">
	
	</div>
<a href="boardList"><h1>개시판</h1></a>
<table>
	<tr style="background-color:#E6E6FF;">
		<th>번호</th>
		<th style="width:100px;">작성자</th>
		<th style="width:350px;">제목</th>
		<th>작성일</th>
		<th>조회수</th>
		<th>첨부</th>
	</tr>
	<c:choose>
		<c:when test="${list.size() == 0 }">
			<tr>
				<td colspan="6">작성된 글이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${list }" var="list" varStatus="status">
				<tr class="overtd">
					<td style="text-align:center;">${(totalCount - status.index) - ( (navi.currentPage - 1)  *  navi.countPerPage ) }</td>
					<td style="text-align:center;">${list.MEMBER_NM }</td>
					<td><a href="javascript:selectBoardOne('${list.BOARD_NO }')" class="atag">${list.BOARD_TITLE }</a></td>
					<td style="text-align:center;">${list.BOARD_INDATE }</td>
					<td style="text-align:center;">${list.BOARD_HITS }</td>
					<td style="text-align:center;">
						<c:if test="${list.BOARD_SAVEDFILE != null }">
						<img src="/resources/img/floppy_disk.png">
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="6" style="text-align:center;">
			<c:if test="${navi.currentPage > navi.pagePerGroup }"><a href="javascript:paging('${navi.currentPage - navi.pagePerGroup }')" class="atag">◀</a></c:if>
			<c:if test="${navi.currentPage != 1 }"><a href="javascript:paging('${navi.currentPage - 1 }')" class="atag">◁</a></c:if>
			<c:forEach begin="${navi.startPageGroup}" end="${navi.endPageGroup}" var="num">
				<c:if test="${num == navi.currentPage }">
					<b>${num }</b>	
				</c:if>
				<c:if test="${num != navi.currentPage }">
					<a href="javascript:paging('${num }')" class="atag">${num }</a>
				</c:if>
			</c:forEach>
			<c:if test="${navi.currentPage != navi.totalPageCount }"><a href="javascript:paging('${navi.currentPage + 1 }')" class="atag">▷</a></c:if>
			<c:if test="${navi.currentPage < (
				navi.totalPageCount - (navi.totalPageCount % navi.pagePerGroup == 0 ?
				  navi.pagePerGroup : navi.totalPageCount%navi.pagePerGroup)
				  + 1)}">
				<a href="javascript:paging('${navi.currentPage + navi.pagePerGroup }')" class="atag">▶</a></c:if>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="등록금" onclick="boardWriteForm()">
		</td>
		<td colspan="4" style="text-align:right;">
			<form action="boardList" method="get" id="pagingForm">
				<input type="hidden" name="currentPage" id="currentPage">
				죄목 : <input type="text" id="searchText" name="searchText" value="${searchText }" placeholder="검색어">
				<input type="button" value="검색" onclick="paging(1)">
			</form>
		</td>
	</tr>
</table>
</c:if>
</div>	
<form action="selectBoardOne" method="get" id="cpform">
	<input type="hidden" id="pk" name="board_no">
	<input type="hidden" name="currentPage" value="${navi.currentPage }">
</form>
</body>
</html>