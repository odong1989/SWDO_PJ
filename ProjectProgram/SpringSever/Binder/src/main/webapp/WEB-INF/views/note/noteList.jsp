<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<style>
	table {
		text-align:center;
	}
	.td1 {
		width:2em;
	}
	.td2 {
		width:12em;
	}
	.td3 {
		width:7em;
	}
</style>
<link href="<c:url value='/css/basic.css?id=2' />" rel="stylesheet">
<script>
	function send(pk) {
		location.href="<c:url value='/note/noteWrite' />?id="+pk;
	}
	function read(pk) {
		location.href="<c:url value='/note/noteRead' />?no="+pk;
	}
	function directsend() {
		location.href="<c:url value='/note/noteWrite' />";
	}
</script>
</head>
<body>
	쪽지함</br>
	<table>
		<tr>
			<th class="td1">번호</th>
			<th class="td2">내용</th>
			<th class="td3">보낸이</th>
		</tr>
		<c:forEach var="nlist" items="${nlist}" varStatus="status">
			<c:if test="${nlist.note_read == 0 }">
				<tr>
					<td>${noteCnt - status.index}</td>
					<td style="font-weight:bold;"><a href="javascript:read('${nlist.note_no }')">${nlist.note_title }</a></td>
					<td><a href="javascript:send('${nlist.member_id }')">${nlist.member_id }</a></td>
				</tr>
			</c:if>
			<c:if test="${nlist.note_read == 1 }">
				<tr>
					<td>${noteCnt - status.index}</td>
					<td><a href="javascript:read('${nlist.note_no }')">${nlist.note_title }</a></td>
					<td><a href="javascript:send('${nlist.member_id }')">${nlist.member_id }</a></td>
				</tr>
			</c:if>
		</c:forEach>
		<tr>
			<td colspan="2" align="right"><input type="button" value="쪽지보내기" onclick="javascript:directsend();"></td>
		</tr>
	</table>
</body>
</html>