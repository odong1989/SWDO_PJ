<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
a{text-decoration:none;}
a:link{color:black;}
a:hover{color:red;}
a:action{color:purple;}
</style>
</head>
<body>
<br/>
<div align="center">
<h1><a href="boardList">개시판</a></h1>
<table>
	<tr style="background-color:#E6E6FF;">
	<form action="boardUpdate" method="post" enctype="multipart/form-data">
		<td width="100px">글 재목</td>
		<td width="400px"><input type="text" name="board_title" value="${list.BOARD_TITLE }"  cols="400px"></td>
	</tr>
	<tr>
		<td colspan="2">조회수 : ${list.BOARD_HITS } | 등록일 : ${list.BOARD_INDATE } </td>
	</tr>
	<tr>
		<td>글 래용</td>
		<td><textarea name="board_content" cols="60", rows="10"">${list.BOARD_CONTENT }</textarea></td>
	</tr>
	<tr style="background-color:#E6E6FF">
		<td>덧붙파일</td>
		<td>
			<c:if test="${list.BOARD_SAVEDFILE != null }">
				<a href="javascript:fileDownload('${list.BOARD_NO }')">${list.BOARD_ORIGINFILE }</a>
			</c:if>
			<input type="file" name="upload">
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" name="board_no" value="${list.BOARD_NO }">
			<input type="hidden" name="currentPage" value="${currentPage }">
		</td>
		<td><input type="submit" value="등록금"></td>
	</form>
</table>
</div>
</body>
</html>