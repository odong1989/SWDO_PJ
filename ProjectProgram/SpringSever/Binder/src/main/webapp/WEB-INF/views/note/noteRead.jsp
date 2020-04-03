<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 읽기</title>
<style>
	body {
		background-color:white;
	}
	table {
		text-align:center;
	}
	td {
		width:30em;
		border-top:1px dashed black;
		border-bottom:1px dashed black;
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
	function liist() {
		location.href="<c:url value='/note/noteList' />";
	}
</script>
</head>
<body>
	<table>
		<tr>
			<td class="readtd" colspan="3">${note.member_id }</td>
		</tr>
		<tr>
			<td class="readtd" colspan="3">${note.note_title }</td>
		</tr>
		<tr>
			<td class="readtd" colspan="3">${note.note_content }</td>
		</tr>
		<tr>
			<td align="left"><input type="button" value="삭제" onclick="javascript:del('${note.note_no }')"></td>
			<td align="center"><input type="button" value="답장" onclick="javascript:send('${note.member_id }')"></td>
			<td align="right"><input type="button" value="목록" onclick="javascript:liist()"></td>
		</tr>
	</table>
</body>
</html>