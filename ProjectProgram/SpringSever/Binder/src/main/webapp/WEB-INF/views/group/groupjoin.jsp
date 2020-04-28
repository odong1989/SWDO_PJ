<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

		<div id="right-body">
			<center><div style="background-color:#EEE; width:20em; padding:1em; margin-top:150px; border:1px solid">
			<table>
				<c:if test="${codebool eq 'ari' }">
				<tr>
					<td colspan="2" align="center">
						<br/><b style="font-weight:bold;">${code.GROUP_NAME }</b> 그룹에</br>가입하시겠습니까?
					</td>
				</tr>
				<tr>
					<td align="center" style="height:3em; vertical-align:middle;"><input id="join" type="button" value="예" style="background-color:white; color:black;"></td>
					<td align="center" style="height:3em; vertical-align:middle;"><input type="button" value="돌아가기" onclick="javascript:history.back()" style="background-color:white; color:black;"></td>
				</tr>
				</c:if>	
				<c:if test="${codebool eq 'nashi' }">
					<tr>
						<td>
							<br/><font color="red">유효하지 않은 초대코드입니다.</font>
						</td>
					</tr>
					<tr>
						<td align="center">
							<input type="button" value="돌아가기" onclick="javascript:history.back()">
						</td>
					</tr> 
				</c:if>
			</table>
			<input type="hidden" id="groupno" value="${groupno }">
			</div></center>
		</div>
	</div>
	<script>
		$(function() {
			$(document).on('click','#join',function(){
				gno = $('#groupno').val();
				$(location).attr('href','joinTrue?gno=' + gno);
			})
		})
	</script>
</body>
</html>