<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="memberLogin" method="post">
	ID : <input type="text" name="member_id" value="${ rememberId}"> <br/>
	PW : <input type="password" name="member_pw"> <br/>
	<input type="hidden" name="target" value="/">
	<label for="fuck" style="cursor:pointer">
		<input type="checkbox" id="fuck" name="remember" /> 아이디 기얻ㄱ하기
	</label>
	<br/>
	<input type="submit" value="로긴">
	</form>
	<c:if test="${errMsg != null }">
		${errMsg }
	</c:if>
</body>
</html>