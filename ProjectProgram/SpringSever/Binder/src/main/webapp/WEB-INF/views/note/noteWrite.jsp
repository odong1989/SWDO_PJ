<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지보내기</title>
<style>
	table {
	    background-color: lightblue;
	    margin-left: 50px;
	    text-align: center;
	}
	tr td {
    	border-bottom: 1px solid white;
	}
	textarea {
		height: 20em;
		width: 24em;
	}
	input[type=text] {
		width: 24em;
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
</head>
<body>
쪽지보내기
	<form action="<c:url value='/note/noteSend' />" method="post">
		<table>
			<tr>
				<td class="td3">받는이</td>
				<c:choose>
					<c:when test="${receiver == null }">
						<td class="td3"><input type="text" name="note_receiver"></td>
					</c:when>
					<c:otherwise>
					<td class="td3">${receiver }</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="note_title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="note_content"></textarea>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="취소" onclick="javascript:history.go(-1)"></td>
				<td align="right"><input type="submit" value="보내기"></td>
			</tr>
		</table>
	</form>
</body>
</html>