<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/resources/css/style_ver3.css">	
<script src="<c:url value='/resources/js/jquery-3.4.1.js' /> "> </script>
<script>
	function fileDownLoad(board_no){
		location.href = "download?board_no="+board_no;
			//board_no값도 전달하기 위해 ?를 활용 쿼리스트링
		//다운로드라는 요청을 보내는데,이때 board_no값을 보냅니다. (#컨트롤러가 수신함.)
	}
</script>
</head>
<body>
<h1>[ 글수정폼 ]</h1>
<form action="boardUpdate" method="post" enctype="multipart/form-data">
<table>	
	<tr>
		<td>글 제목    : </td>
		<td><input type="text" name ="board_title" value="${board.BOARD_TITLE}"></td>
	</tr>
	<tr>
		<td>글 내용    : </td>
		<td><textarea name = "board_content">${board.BOARD_CONTENT } </textarea> </td>
	</tr>
	<tr>
		<td>조회수     :</td>
		<td>${board.BOARD_HITS}</td>
	</tr>
	<tr>
		<td>등록일     :</td>
		<td>${board.BOARD_INDATE}</td>
	</tr>
	<tr>
		<td>첨부파일  : </td>
		<td><input type="file" name = "upload"></td>
	</tr>
	<tr>
		<td>첨부파일  : </td>
		<td> <c:if test="${board.BOARD_SAVEDFILE !=null}">
				<a href="javascript:fileDownLoad(${board.BOARD_NO})">
				${board.BOARD_ORIGINFILE } </a>
			</c:if>		</td>
	</tr>	
</table>	

	
	<!-- 글번호  value="${board_no.BOARD_NO}"가 있어야 SQL은 어떤 글을삭제할지정할수 있다.-->
	<input type="hidden" name="board_no" value="${board.BOARD_NO}">	
	<input type="submit" value="글 수정">

</form>



</body>
</html>