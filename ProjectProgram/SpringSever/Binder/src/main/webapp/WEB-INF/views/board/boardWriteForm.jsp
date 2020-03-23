<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/resources/css/style_ver3.css">	
<script src="<c:url value='/resources/js/jquery-3.4.1.js' /> "> </script>
<script>
</script>
</head>
<body>
<h1>[ 글등록폼(boardWriteForm) ]</h1>

<form action="boardWrite" method="post" enctype="multipart/form-data">
	글 제목    : <input type="text" name ="board_title" > <br/>
	글 내용    : <input type="text" name = "board_content"> <br/>
	첨부파일  : <input type="file" name = "upload"> <br/>
	<input type="submit" value="글 등록">
</form>


</body>
</html>