<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" contents="width=device-width, initial-scale=1.0">
<title>${group_name}</title>
    <link rel="stylesheet" href="<c:url value='/vendor/css/fullcalendar.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >

<link href="<c:url value='/css/basic.css' />" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
var temp = '';
function selectGroup(pk) {
	location.href="<c:url value='/document/group' />?no="+pk;
}
function invite(pk) {
	location.href="<c:url value='/group/groupcode' />?no="+pk;
}
function edit(pk) {
	location.href="<c:url value='/document/editDocument' />?no="+pk;
}
function write(pk) {
	location.href="<c:url value='/document/writeDocument' />?no="+pk;
}
function groupMgr(pk) {
	location.href="<c:url value='/group/groupMemberMgr' />?no="+pk;
}

//btn1 : 게시판->캘린더로 변경
$(document).on("click","#btn1",function(){
	$.ajax({
			data:{"group_no":${group_no}},
			url:"<c:url value='/calender/calenderMain'/>",
			type:"get",
			success:function(documentList){
				var tempDocumentList = documentList[0].DOCUMENT_FINALDAY;
				console.log(documentList);
			//	alert("일정데이터 documentList(자료형 : ArrayList<HashMap<String, Object>>)만 수신합니다. ");
			//	alert("일정데이터 documentList시작일날짜정보 : "+ '${documentList[0].DOCUMENT_REGDATE}');
			//	alert("일정데이터 documentList마지막날짜정보 : "+ '${documentList[0].DOCUMENT_FINALDAY}');
				alert("tempDocumentList : "+ documentList[0].DOCUMENT_FINALDAY);
			var temp = "<div id='calendar'></div>";
				document.getElementById('right-body').innerHTML=temp;
				var calendar = $('#calendar').fullCalendar({
					events: [
					    { title: '${documentList[0].DOCUMENT_DESTINATION}',
						  start: '${documentList[0].DOCUMENT_REGDATE}',
					      end  : tempDocumentList, 
					      imageurl :'<c:url value="/img/bell.png" />' 
					      //imageurl :'/${documentList[0].PHOTO_SAVEDFILE}'
					    },
					    { title: '${documentList[1].DOCUMENT_DESTINATION}',
						  start: '${documentList[1].DOCUMENT_REGDATE}',
						    end: documentList[1].DOCUMENT_FINALDAY
						}
				    /*events: [
					    { 
					    	title: '풀캘린더 기본입력형입니다.', 
					        start: '2020-04-01',
					        end: '2020-04-02'
					    },
					    { 
					    	title: 'JSTL-foreach로도 가능할까요?', 
					        start: '2020-04-05',
					        end: '2020-04-09'
					    }
					  ]*/
					  ]
		          , eventRender:function(event, eventElement) {
		                if(event.imageurl) {
		                    eventElement.find("span.fc-title").prepend("<center><img src='" + event.imageurl + "'><center>");
		                }}
					})
			},
			error:function(){alert("캘린더 로드 중 에러가 발생되었습니다.")}
	});
});
//btn2 : 캘린더->게시판으로 변경
$(document).on("click","#btn2",function(){
	$.ajax({
			url:"<c:url value='/document/boardTemp' />",
			type:"get",
			success:function(data){		
				document.getElementById('right-body').innerHTML=temp;
				document.getElementById('right-body').innerHTML=data;
			},
			error:function(){alert("게시판(document) 로드 중 에러가 발생되었습니다.")}
	});
});
</script>

    <link href="<c:url value='/css/basic.css' />" rel="stylesheet">
</head>
<body>
	<div id="gaibu-top">
		<span id="gaibu-top-left"> 
			<a href="<c:url value='/document/mainDocument' />">
			<img src="<c:url value='/img/logo.png' />"></a>
		</span> <span id="gaibu-top-middle"> </span> <span id="gaibu-top-right">

            <img src="<c:url value='/img/bell.png' />">
			<c:if test="${newNoteCheck eq 'nashi' }">
				<a href="javascript:noteList()"><img src="<c:url value='/img/mail.png' />"></a>
			</c:if>
			<c:if test="${newNoteCheck eq 'ari' }">
				<a href="javascript:noteList()"><img src="<c:url value='/img/newmail.png' />"></a>
			</c:if>
			<a href="<c:url value='/member/memberMypage' />"><img src="<c:url value='/img/human.png' />" id="usericon">
			<a href="<c:url value='/member/memberLogout' />"><img src="<c:url value='/img/logout.png' />"></a>
		</span>
	</div>
	<div id="gaibu">
		<div id="menu">
			<c:forEach var="glist" items="${groupJoinList }">
				<div class="menu-group-button">
					<div class="menu-group-button-left">
						<a href="javascript:selectGroup(${glist.GROUP_NO })"><p>${glist.GROUP_NAME }</p></a>
						<p class="p-hash">#${glist.GROUP_SUBCATEGORY }</p>
					</div>
					<div class="menu-group-button-right">
						<c:if test="${glist.MEMBER_LEVEL == 1 }">
							<a href="javascript:groupMgr(${glist.GROUP_NO })">관리</a>
							<img src="<c:url value='/img/crown_gold.png' />">
						</c:if>
						<c:if test="${glist.MEMBER_LEVEL == 2 }">
							<a href="javascript:groupMgr(${glist.GROUP_NO })">관리</a>
							<img src="<c:url value='/img/crown_silver.png' />">
						</c:if>
					</div>
					<div class="menu-group-button-clear"></div>
				</div>
			</c:forEach>
		</div>
		<div id="right-body">
			<table id="document-body">
				<tr height="40px">
					<td width="21%">
						<a href="javascript:invite(${group_no })">
							<img src="<c:url value='/img/invite.png' />">
						</a>
						<a href="javascript:write(${group_no})">
							<img src="<c:url value='/img/pencil.png' />">
						</a>
					</td>
					<td width="auto" align="center"><p id="notice">공지사항 :
					<c:if test="${caution.document_content != '' }">
							${caution.document_content }
					</c:if>
							</p></td>
					<td width="21%" align="right">
						<img src="<c:url value='/img/f5.png' />">
						<img src="<c:url value='/img/cal.png' />" id="btn1">
					</td>
				</tr>
				<c:forEach var="dlist" items="${documentList }">
					<tr>
						<td class="document-one">
								<a href="javascript:edit(${dlist.DOCUMENT_NO })">
									<div class="document-image" style="background-image:url(<c:url value='/profile/${dlist.PHOTO_SAVEDFILE }'/>);">
										<div class="document-image-bottom">
											<p>${dlist.DOCUMENT_DESTINATION }</p>
										</div>
									</div>
								</a>
						</td>
						<td colspan="2" class="document-one">
							<div class="document-content">
								<p>${dlist.DOCUMENT_REGDATE }</p>
								<p class="p-hash">#해시 table join 점검하세요</p>
							</div>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
    <script src="<c:url value='/vendor/js/moment.min.js' />"></script>
    <script src="<c:url value='/vendor/js/jquery.min.js' />"></script>
    <script src="<c:url value='/vendor/js/fullcalendar.min.js' />"></script>
    <script src="<c:url value='/vendor/js/bootstrap.min.js' />"></script>
 	<script src="<c:url value='/vendor/js/ko.js' />"></script>
    <script src="<c:url value='/vendor/js/select2.min.js' />"></script>
    <script src="<c:url value='/vendor/js/bootstrap-datetimepicker.min.js' />"></script>
    <script src="<c:url value='/js/main.js' />"></script>
    <script src="<c:url value='/js/addEvent.js' />"></script>
    <script src="<c:url value='/js/editEvent.js' />"></script>
    <script src="<c:url value='/js/etcSetting.js' />"></script>
</body>
</html>