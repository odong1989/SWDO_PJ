<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function useId(checkId) {
	//패러미터 전달 받은 ID를 부모창의 ID칸에 입력
	//자식창(본인)을 닫음.
	opener.document.getElementById("member_id").value = checkId;
	this.close();
}
</script>
</head>
<body>

<form action="memberIdCheck" method="post">
<!-- onsubmit으로 입력했는지 체크해야한다. -->
	ID : <input type="text" name="checkId" id="checkId" value="${checkId }"> <br/>
	<input type="submit" value="중복체크">
</form>
<c:if test="${checkFlag }">
	<c:choose>
		<c:when test="${member == null }">
			${checkId }는 사용할 수 잇다
			<input type="button" value="사용" onclick="useId('${checkId}')">
		</c:when>
		<c:otherwise>
			${checkId }는 사용할 수 업다
		</c:otherwise>
	</c:choose>
</c:if>
</body>
</html>