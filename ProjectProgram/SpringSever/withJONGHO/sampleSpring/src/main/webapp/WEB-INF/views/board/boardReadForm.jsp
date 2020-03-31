<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
a{text-decoration:none;}
a:link{color:black;}
a:hover{color:red;}
a:action{color:purple;}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function boardList(cp) {
	location.href="boardList?currentPage="+cp;
}

function fileDownload(board_no) {
	location.href="download?board_no="+board_no;
}
function boardDelete(board_no) {
	if(confirm("ㄹㅇ루 지울거임??")) {
		var cpformDel = document.getElementById("cpformDel");
		var bnoDel = document.getElementById("bnoDel");

		bnoDel.value = board_no;
		cpformDel.submit();
		//location.href="boardDelete?board_no="+board_no+"&currentPage="+cp;
	}
}
function boardUpdateForm(board_no) {
var cpformUp = document.getElementById("cpformUp");
var bnoUp = document.getElementById("bnoUp");

bnoUp.value = board_no;
cpformUp.submit();
	//location.href="boardUpdateForm?board_no="+board_no+"&currentPage="+cp;
}

function replyCheck() {
	var reply_content = document.getElementById("reply_content");
	if (reply_content.value.length < 1) {
		alert("댓글을 입력해주십시오");
		return false;
	}
	return true;
}

function replyDelete(reply_no, board_no) {
	location.href="replyDelete?reply_no="+reply_no+"&board_no="+board_no;
}
</script>
</head>
<body>
<br/>
<div align="center">
<a href="boardList"><h1>개시판</h1></a>
<table>
	<tr style="background-color:#E6E6FF;">
		<td colspan="3"><p></p></td>
	</tr>
	<tr>
		<td width="500px" colspan="2">
			${list.BOARD_TITLE }<br/>
			${list.MEMBER_NM } | ${list.BOARD_INDATE }
		</td>
		<td width="100px">조회 ${list.BOARD_HITS }</td>
	</tr>
	<tr style="background-color:#E6E6FF;">
		<td colspan="3"></td>
	</tr>
	<tr>
		<td colspan="3" height="150px" width="300px">${list.BOARD_CONTENT }</td>
	</tr>
	<tr style="background-color:#E6E6FF;">
		<td width="100px">첨부파일</td>
		<td width="400px" colspan="2">
			<c:if test="${list.BOARD_SAVEDFILE != null }">
				<a href="javascript:fileDownload('${list.BOARD_NO }')"><img src="/resources/img/floppy_disk.png">${list.BOARD_ORIGINFILE }</a>
			</c:if>
			<c:if test="${list.BOARD_SAVEDFILE == null }">
				없음
			</c:if>
		</td>
	</tr>
		<tr>
			<td colspan="2">
				<c:if test="${list.MEMBER_ID == sessionScope.loginId }">
					<input type="button" value="수정" onclick="boardUpdateForm('${list.BOARD_NO}')">
					<input type="button" value="삭재" onclick="boardDelete('${list.BOARD_NO}')">
				</c:if>
			</td>
			<td>
				<input type="button" value="목록" onclick="boardList('${currentPage}')">
			</td>
		<tr>
</table>
<table>
	<tr>
		<td>
			<form action="replyInsert" method="post" onsubmit="return replyCheck();">
				<input type="text" name="reply_content" id="reply_content">
				<input type="hidden" name="board_no" value="${list.BOARD_NO }">
				<input type="submit" value="입력">
			</form>
		</td>
	</tr>
</table>
<table>
	<c:forEach items="${reply }" var="reply" varStatus="status">
		<tr>
			<td>
			<c:if test="${status.count <= 3 }">
				${status.count }등!
			</c:if>
			</td>
			<td>
				${reply.MEMBER_NM }
			</td>
			<td>
				${reply.REPLY_CONTENT }
			</td>
			<td>
				<input type="button" value="크리스탈">
				<input type="button" value="승재" onclick="replyDelete('${reply.REPLY_NO}','${reply.BOARD_NO }')">
			</td>
		</tr>
	</c:forEach>
</table>

</div>
<form action="boardDelete" method="get" id="cpformDel">
	<input type="hidden" id="cpDel" name="currentPage" value="${currentPage }">
	<input type="hidden" id="bnoDel" name="board_no">
</form>
<form action="boardUpdateForm" method="get" id="cpformUp">
	<input type="hidden" id="cpUp" name="currentPage" value="${currentPage }">
	<input type="hidden" id="bnoUp" name="board_no">
</form>
</body>
</html>