<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

<style>
#right-body{
	padding:30px;
}
table {
	margin:auto;
    border-collapse: collapse;
    width:350px; 
}
table, td, th {
    border: solid 1px #cccccc;
    text-align: center;
    vertical-align : middle;
}
tr {
    height:40px;
}
td, th {
    padding: 5px; 
}
#dataTitle {
    background-color: #5f90de;
    font-weight: bold;
}
#table_title {
    height:30px;
    background-color: #eeeeee;
}
#col1, #col4 {
    width: 90px;
}

#buttonWrap{
	margin: 30px;
}

</style>
	<div id="right-body">
		<table>
			<tr>
				<td id="dataTitle">아이디 </td>
				<td>${MemberData.member_id}</td>
			</tr>
			<tr>
				<td id="dataTitle">이름 </td>
				<td>${MemberData.member_name}</td>
			</tr>
			<tr>
				<td id="dataTitle">이메일 </td>
				<td>${MemberData.member_mail}</td>
			</tr>
	
			<tr>
				<td id="dataTitle">프로필 사진 </td>
				<c:choose>
					<c:when test="${empty MemberData.member_photo}">
						<td>
						<img src="<c:url value='/img/human.png' />" 
							 style="width:200px; height: 200px;" /> 
						</td>
					</c:when>
					<c:otherwise>
						<td>
						<img src="<c:url value='/profile/${MemberData.member_photo}' />" style="width:200px; height: 200px;"/>
						</td>
					</c:otherwise>
				</c:choose>

			</tr>
			<tr>
				<td id="dataTitle">생일  </td>
				<td>${MemberData.member_birthday}</td>
			</tr>
			<tr>
				<td id="dataTitle">결혼여부 </td>
				<c:choose>
					<c:when test="${MemberData.member_married eq '0'}">
						<td>미혼입니다.</td>
					</c:when>
					<c:otherwise>
						<td>결혼하였습니다.</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td id="dataTitle">결혼일 </td>
				<c:choose>
					<c:when test="${empty MemberData.member_weddingday}">
						<td>미혼입니다.</td>
					</c:when>
					<c:otherwise>
						<td>${MemberData.member_weddingday}</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td id="dataTitle">회원가입일 </td>
				<td>${MemberData.member_regdate}</td>
			</tr>
		</table>	
	
		<div id="buttonWrap" style="text-align: center">
			<a href="<c:url value='/member/mypageUpdateProfile' />">
			<input type="button" value="회원정보수정"></a>
			<input type="button" value="회원탈퇴" onclick="Withdrawal()"> 
		</div>
    </div>
</body>
</html>