<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div id="idFind">
      <table>
          <tr>
              <td>아이디 찾기</td>
          </tr>
              <td>ID 확인결과입니다.
              </td>
              <tr style="text-align: center;">
                  <td style="width:110px; text-align:left;">
				<c:choose>
					<c:when test="${not empty resultMemberData.member_id}">
						<p>귀하의 ID는 ${resultMemberData.member_id}</p>				
					</c:when>
					<c:otherwise>
						<p>${errMsg}</p>				
					</c:otherwise>				
				</c:choose>
	         </td>
        </tr>
     </table>
  </div>
</body>
</html>