<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<style>
/* CSS 초기화 시작 */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
}

/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
    display: block;
}
html {
	height:100%;
}
body {
    line-height: 1;
    height:inherit;
}
ol, ul {
    list-style: none;
}
blockquote, q {
    quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
    content: '';
    content: none;
}
table {
    border-collapse: collapse;
    border-spacing: 0;
}

/* CSS 초기화 끝 */

a:link{
    color:inherit;
    text-decoration: none;
}
a:active{
    color:inherit;
    text-decoration: none;
}
a:hover{
    text-decoration: none;
}
a:visited{
    text-decoration: none;
    color:inherit;
}
	table#notetable {
		width:550px;
		text-align:center;
		margin: 0 auto;
		border-collapse: separate;
		border-spacing: 1px;
	}
	.tr12 {
		height: 1.6em;
	}
	.tdtop {
		height: 1.5em;
		background-color: lightblue;
	}
	.tdno {
		width: 3em;
	}
	.tddate {
		width: 6em;
	}
	.tdsender {
		width: 7em;
	}
	.tdclass {
		height: 1.5em;
	}
	.tdbottom {
		border-top: 1px solid lightblue;
		height: 2em;
		padding-top: 10px;
	}
</style>
<script>
	function send(pk) {
		location.href="<c:url value='/note/noteWrite' />?id="+pk;
	}
	function read(pk) {
		location.href="<c:url value='/note/noteRead' />?no="+pk;
	}
	function directsend() {
		location.href="<c:url value='/note/noteWrite' />";
	}
</script>
</head>
<body>
	쪽지함</br>
	<table id="notetable">
		<tr class="tr12">
			<th class="tdtop tdno">번호</th>
			<th class="tdtop">제목</th>
			<th class="tdtop tdsender">보낸이</th>
			<th class="tdtop tddate">날짜</th>
		</tr>
		<c:forEach var="nlist" items="${nlist}" varStatus="status">
			<tr class="tr12">
				<td class="tdmid">${noteCnt - status.index}</td>
				<c:if test="${nlist.note_read == 0 }">
					<td class="tdmid" style="font-weight:bold;"><a href="javascript:read('${nlist.note_no }')">${nlist.note_title }</a></td>
				</c:if>
				<c:if test="${nlist.note_read == 1 }">
					<td class="tdmid"><a href="javascript:read('${nlist.note_no }')">${nlist.note_title }</a></td>
				</c:if>
				<c:if test="${!nlist.member_id.equals('system') }">
					<td class="tdmid"><a href="javascript:send('${nlist.member_id }')">${nlist.member_id }</a></td>
				</c:if>
				<c:if test="${nlist.member_id.equals('system') }">
					<td class="tdmid" style="font-weight:bold;">System</td>
				</c:if>
				<td class="tdmid tddate">${fn:substring(nlist.note_date, 2, 11) }</td>
			</tr>
		</c:forEach>
		<tr><td colspan="4"></td></tr>
		<tr>
			<td colspan="2" align="left" class="tdbottom">
				<input type="button" value="닫기" onclick="javascript:window.close();" style="background-color:black; color:white;">
			</td>
			<td colspan="2" align="right" class="tdbottom">
				<input type="button" value="쪽지보내기" onclick="javascript:directsend();" style="background-color:white;">
			</td>
		</tr>
	</table>
</body>
</html>