<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
<script>
function firstCheck(){
	var checkId = document.getElementById("checkId"); 
	// checkId :유효성검사 및 DB측의 중복여부를 확인중인 ID. 
	// member_id : 유효성 검사 및 DB중복확인 완료된 ID.

	if(checkId.value.length < 4 || checkId.value.length>10 ){
		alert("ID는 4~10글자로 해주세요");
		return false;
	}
	return true;	
}
/*
function useId(checkId){
	opener.document.getElementById("member_id").value=checkId; 
	this.close();
}
*/
function popupClose(){
	this.close();
}
</script>
</head>

<body>
<h1>Binder-ID중복체크입니다.</h1>

<form action="memberIdCheck" method="get" onsubmit="return firstCheck()">
<table class="IdCheckPopupTable">
	<tr>
		<td>ID :<input type="text" name="checkId" id="checkId" placeholder="ID는 4~10글자로 해주세요"></td>
	</tr>
	<tr id="buttonAlign">
		<td> <input type="submit" value="ID중복체크"> 
			 <input type="button" value="취소" onclick="popupClose();">
		</td>
	</tr>
</table>
</form>

<c:if test="${checkFlag}">
	<c:choose>
		<c:when test="${member == null}">   
			"${checkId}는 사용할 수 있습니다."
		<input type="submit" value="전송하기" onclick='useId("${checkId}")'>
		</c:when>
		<c:otherwise>
			"${checkId}는 사용할 수 없습니다. 다른계정을 넣어주세요"		
		</c:otherwise>
	</c:choose>
</c:if>	

<script type="text/javascript">
function useId(checkId){
      opener.document.getElementById("member_id").value=checkId;
      //오픈한 창 memberJoinForm.jsp을의미합니다.
      this.close();
}
</script>
</body>
</html>