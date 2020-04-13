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

	<link href="<c:url value='/css/basic.css' />" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/vendor/css/fullcalendar.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/css/main.css'/>" >

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
//아래의 3가지 방식을 통하여 HTMl의 변경이 되었다면 최후에 자신들이 갖고 있는 내용적용시기키도록 한다.
/* window.onload = function() {
	????
}
$(document).ready(function() {
	???
});
$(function() {
	???
}); */
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



				var changeToFullCalendar ='<div class="container">';
				changeToFullCalendar +='<div class="container">';
				changeToFullCalendar +='<!-- 일자 클릭시 메뉴오픈 -->';
				changeToFullCalendar += '<div id="contextMenu" class="dropdown clearfix">';
				changeToFullCalendar +=      '<ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"style="display:block;position:static;margin-bottom:5px;">';
				changeToFullCalendar +=     	'<li><a tabindex="-1" href="#">카테고리1</a></li>';
				changeToFullCalendar +=      	'<li><a tabindex="-1" href="#">카테고리2</a></li>';
				changeToFullCalendar +=      	'<li><a tabindex="-1" href="#">카테고리3</a></li>';
				changeToFullCalendar +=       	'<li><a tabindex="-1" href="#">카테고리4</a></li>';
				changeToFullCalendar +=       	'<li class="divider"></li>';
				changeToFullCalendar +=      	'<li><a tabindex="-1" href="#" data-role="close">Close</a></li>';
				changeToFullCalendar +=    '</ul>';
				changeToFullCalendar += '</div>';
							
				changeToFullCalendar += '<div id="wrapper">';
				changeToFullCalendar +=    '<div id="loading"></div>';
				changeToFullCalendar +=    '<div id="calendar"></div>';
				changeToFullCalendar += '</div>';
							
							
				changeToFullCalendar +=<!-- 일정 추가 MODAL -->
				changeToFullCalendar += '<div class="modal fade" tabindex="-1" role="dialog" id="eventModal">';
				changeToFullCalendar +=    '<div class="modal-dialog" role="document">';
				changeToFullCalendar +=        '<div class="modal-content">';
				changeToFullCalendar +=        '<div class="modal-header">';
				changeToFullCalendar +=        '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
				changeToFullCalendar +=        '<h4 class="modal-title"></h4>';
				changeToFullCalendar +=     '</div>';   
				changeToFullCalendar += '<div class="modal-body">';
							
				changeToFullCalendar +=              '<div class="row">';
				changeToFullCalendar +=              	'<div class="col-xs-12">';
				changeToFullCalendar +=                 	'<label class="col-xs-4" for="edit-allDay">하루종일</label>';
				changeToFullCalendar +=                 	'<input class="allDayNewEvent" id="edit-allDay" type="checkbox"></label>';
				changeToFullCalendar +=                 '</div>';
				changeToFullCalendar +=              '</div>';
							
				changeToFullCalendar +=                 '<div class="row">';
				changeToFullCalendar +=                     '<div class="col-xs-12">';
				changeToFullCalendar +=                         '<label class="col-xs-4" for="edit-title">일정명</label>';
				changeToFullCalendar +=                        '<input class="inputModal" type="text" name="edit-title" id="edit-title" required="required" />';                          
				changeToFullCalendar +=                   '</div>';
				changeToFullCalendar +=                 '</div>';
				changeToFullCalendar +=                 '<div class="row">';
				changeToFullCalendar +=                     '<div class="col-xs-12">';
				changeToFullCalendar +=                         '<label class="col-xs-4" for="edit-start">시작</label>';
				changeToFullCalendar +=                         '<input class="inputModal" type="text" name="edit-start" id="edit-start" />';
				changeToFullCalendar +=                      '</div>';
				changeToFullCalendar +=               '</div>';
				changeToFullCalendar +=                '<div class="row">';
				changeToFullCalendar +=                     '<div class="col-xs-12">';
				changeToFullCalendar +=                          '<label class="col-xs-4" for="edit-end">끝</label>';
				changeToFullCalendar +=                      '<input class="inputModal" type="text" name="edit-end" id="edit-end" />';
				changeToFullCalendar +=                     '</div>';
				changeToFullCalendar +=               '</div>';
				changeToFullCalendar +=                 '<div class="row">';
				changeToFullCalendar +=                    '<div class="col-xs-12">';
				changeToFullCalendar +=                         '<label class="col-xs-4" for="edit-type">구분</label>';
				changeToFullCalendar +=                          '<select class="inputModal" type="text" name="edit-type" id="edit-type">';
				changeToFullCalendar +=                             '<option value="카테고리1">카테고리1</option>';
				changeToFullCalendar +=                             '<option value="카테고리2">카테고리2</option>';
				changeToFullCalendar +=                                '<option value="카테고리3">카테고리3</option>';
				changeToFullCalendar +=                               '<option value="카테고리4">카테고리4</option>';
				changeToFullCalendar +=                       '</select>';
				changeToFullCalendar +=                       '</div>';
				changeToFullCalendar +=                 '</div>';
				changeToFullCalendar +=                '<div class="row">';
				changeToFullCalendar +=                    '<div class="col-xs-12">';
				changeToFullCalendar +=                         '<label class="col-xs-4" for="edit-color">색상</label>';
				changeToFullCalendar +=                           '<select class="inputModal" name="color" id="edit-color">';
				changeToFullCalendar +=                               '<option value="#D25565" style="color:#D25565;">빨간색</option>';
				changeToFullCalendar +=                                '<option value="#9775fa" style="color:#9775fa;">보라색</option>';
				changeToFullCalendar +=                                '<option value="#ffa94d" style="color:#ffa94d;">주황색</option>';
				changeToFullCalendar +=                                 '<option value="#74c0fc" style="color:#74c0fc;">파란색</option>';
				changeToFullCalendar +=                                 '<option value="#f06595" style="color:#f06595;">핑크색</option>';
				changeToFullCalendar +=                                 '<option value="#63e6be" style="color:#63e6be;">연두색</option>';
				changeToFullCalendar +=                               '<option value="#a9e34b" style="color:#a9e34b;">초록색</option>';
				changeToFullCalendar +=                              '<option value="#4d638c" style="color:#4d638c;">남색</option>';
				changeToFullCalendar +=                             '<option value="#495057" style="color:#495057;">검정색</option>';
				changeToFullCalendar +=                         '</select>';
				changeToFullCalendar +=                    '</div>';
				changeToFullCalendar +=                    '</div>';
				changeToFullCalendar +=                  '<div class="row">';
				changeToFullCalendar +=                       '<div class="col-xs-12">';
				changeToFullCalendar +=                             '<label class="col-xs-4" for="edit-desc">설명</label>';
				changeToFullCalendar +=                         '<textarea rows="4" cols="50" class="inputModal" name="edit-desc"id="edit-desc"></textarea>';
				changeToFullCalendar +=                     '</div>';
				changeToFullCalendar +=                  '</div>';
				changeToFullCalendar +=             '</div>';
				changeToFullCalendar +=               '<div class="modal-footer modalBtnContainer-addEvent">';
				changeToFullCalendar +=                   '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';
				changeToFullCalendar +=                   '<button type="button" class="btn btn-primary" id="save-event">저장</button>';
				changeToFullCalendar +=               '</div>';
				changeToFullCalendar +=                '<div class="modal-footer modalBtnContainer-modifyEvent">';
				changeToFullCalendar +=                 '<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>';
				changeToFullCalendar +=                  '<button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>';
				changeToFullCalendar +=                  '<button type="button" class="btn btn-primary" id="updateEvent">저장</button>';
				changeToFullCalendar +=                   '</div>';
				changeToFullCalendar +=             '</div><!-- /.modal-content -->';
				changeToFullCalendar +=       '</div><!-- /.modal-dialog -->';
				changeToFullCalendar +=   '</div><!-- /.modal -->';
							
				changeToFullCalendar +=   '<div class="panel panel-default">';
							
				changeToFullCalendar +=    '<div class="panel-heading">';
				changeToFullCalendar +=         '<h3 class="panel-title">필터</h3>';
				changeToFullCalendar +=     '</div>';
							
				changeToFullCalendar +=     '<div class="panel-body">';
							
				changeToFullCalendar +=        '<div class="col-lg-6">';
				changeToFullCalendar +=              '<label for="calendar_view">구분별</label>';
				changeToFullCalendar +=              '<div class="input-group">';
				changeToFullCalendar +=                   '<select class="filter" id="type_filter" multiple="multiple">';
		        changeToFullCalendar +=                     '<option value="카테고리1">카테고리1</option>';
		        changeToFullCalendar +=                       '<option value="카테고리2">카테고리2</option>';
		        changeToFullCalendar +=                      '<option value="카테고리3">카테고리3</option>';
		        changeToFullCalendar +=                      '<option value="카테고리4">카테고리4</option>';
		        changeToFullCalendar +=                  '</select>';
		        changeToFullCalendar +=              '</div>';
		        changeToFullCalendar +=          '</div>';
							
		        changeToFullCalendar +=       '<div class="col-lg-6">';
		        changeToFullCalendar +=          '<label for="calendar_view">등록자별</label>';
		        changeToFullCalendar +=              '<div class="input-group">';
		        changeToFullCalendar +=                   '<label class="checkbox-inline"><input class="filter" type="checkbox" value="정연"checked>정연</label>';
		        changeToFullCalendar +=                  '<label class="checkbox-inline"><input class="filter" type="checkbox" value="다현"checked>다현</label>';
		        changeToFullCalendar +=                   '<label class="checkbox-inline"><input class="filter" type="checkbox" value="사나"checked>사나</label>';
		        changeToFullCalendar +=                  '<label class="checkbox-inline"><input class="filter" type="checkbox" value="나연"checked>나연</label>';
                changeToFullCalendar +=                 '<label class="checkbox-inline"><input class="filter" type="checkbox" value="지효"checked>지효</label>';
                changeToFullCalendar +=               '</div>';
                changeToFullCalendar +=           '</div>';
                changeToFullCalendar +=       '</div>';
                changeToFullCalendar +=   '</div>';
                changeToFullCalendar +=   '<!-- /.filter panel -->';
                changeToFullCalendar +=   '</div>';
                changeToFullCalendar +=   '<!-- /.container -->';
				console.log(changeToFullCalendar);
						
				document.getElementById('right-body').innerHTML=changeToFullCalendar;
				var calendar = $('#calendar').fullCalendar({

						//------------------------------------------
				
					  eventRender: function (event, element, view) {
					    //일정에 hover시 요약
					    element.popover({
					      title: $('<div />', {
					        class: 'popoverTitleCalendar',
					        text: event.title
					      }).css({
					        'background': event.backgroundColor,
					        'color': event.textColor
					      }),
					      content: $('<div />', {
					          class: 'popoverInfoCalendar'
					        }).append('<p><strong>등록자:</strong> ' + event.username + '</p>')
					        .append('<p><strong>구분:</strong> ' + event.type + '</p>')
					        .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
					        .append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.description + '</div>'),
					      delay: {
					        show: "800",
					        hide: "50"
					      },
					      trigger: 'hover',
					      placement: 'top',
					      html: true,
					      container: 'body'
					    });

					    return filtering(event);

					  },

					  //주말 숨기기 & 보이기 버튼
					  customButtons: {
					    viewWeekends: {
					      text: '주말',
					      click: function () {
					        activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
					        $('#calendar').fullCalendar('option', {
					          weekends: activeInactiveWeekends
					        });
					      }
					    }
					  },

					  header: {
					    left: 'today, prevYear, nextYear, viewWeekends',
					    center: 'prev, title, next',
					    right: 'month,agendaWeek,agendaDay,listWeek'
					  },
					  views: {
					    month: {
					      columnFormat: 'dddd'
					    },
					    agendaWeek: {
					      columnFormat: 'M/D ddd',
					      titleFormat: 'YYYY년 M월 D일',
					      eventLimit: false
					    },
					    agendaDay: {
					      columnFormat: 'dddd',
					      eventLimit: false
					    },
					    listWeek: {
					      columnFormat: ''
					    }
					  },

					
					  
					  // 일정 받아옴 
					events: [
					    {
						  title: '${documentList[0].DOCUMENT_DESTINATION}',
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
					  ],

					    //저장된 이미지를 불러오기  
					   eventRender:function(event, eventElement) {
		                if(event.imageurl) {
		                    eventElement.find("span.fc-title").prepend("<center><img src='" + event.imageurl + "'><center>");
		                }},
					  //일정 리사이즈
					  eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
					    $('.popover.fade.top').remove();

					    //리사이즈시 수정된 날짜반영. 하루를 빼야 정상적으로 반영됨.
					    var newDates = calDateWhenResize(event);

					    //리사이즈한 일정 업데이트
					    $.ajax({
					      type: "get",
					      url: "",
					      data: {
					        //id: event._id,
					        //....
					      },
					      success: function (response) {
					        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
					      }
					    });

					  },

					  eventDragStart: function (event, jsEvent, ui, view) {
					    draggedEventIsAllDay = event.allDay;
					  },

					  //일정 드래그앤드롭
					  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
					    $('.popover.fade.top').remove();

					    //주,일 view일때 종일 <-> 시간 변경불가
					    if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
					      if (draggedEventIsAllDay !== event.allDay) {
					        alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
					        location.reload();
					        return false;
					      }
					    }

					    // 드랍시 수정된 날짜반영
					    var newDates = calDateWhenDragnDrop(event);

					    //드롭한 일정 업데이트
					    $.ajax({
					      type: "get",
					      url: "",
					      data: {
					        //...
					      },
					      success: function (response) {
					        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
					      }
					    });

					  },

					  select: function (startDate, endDate, jsEvent, view) {

					    $(".fc-body").unbind('click');
					    $(".fc-body").on('click', 'td', function (e) {

					      $("#contextMenu")
					        .addClass("contextOpened")
					        .css({
					          display: "block",
					          left: e.pageX,
					          top: e.pageY
					        });
					      return false;
					    });

					    var today = moment();

					    if (view.name == "month") {
					      startDate.set({
					        hours: today.hours(),
					        minute: today.minutes()
					      });
					      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
					      endDate = moment(endDate).subtract(1, 'days');

					      endDate.set({
					        hours: today.hours() + 1,
					        minute: today.minutes()
					      });
					      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
					    } else {
					      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
					      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
					    }

					    //날짜 클릭시 카테고리 선택메뉴
					    var $contextMenu = $("#contextMenu");
					    $contextMenu.on("click", "a", function (e) {
					      e.preventDefault();

					      //닫기 버튼이 아닐때
					      if ($(this).data().role !== 'close') {
					        newEvent(startDate, endDate, $(this).html());
					      }

					      $contextMenu.removeClass("contextOpened");
					      $contextMenu.hide();
					    });

					    $('body').on('click', function () {
					      $contextMenu.removeClass("contextOpened");
					      $contextMenu.hide();
					    });

					  },

					  //이벤트 클릭시 수정이벤트
					  eventClick: function (event, jsEvent, view) {
					    editEvent(event);
					  },

					  locale: 'ko',
					  timezone: "local",
					  nextDayThreshold: "09:00:00",
					  allDaySlot: true,
					  displayEventTime: true,
					  displayEventEnd: true,
					  firstDay: 0, //월요일이 먼저 오게 하려면 1
					  weekNumbers: false,
					  selectable: true,
					  weekNumberCalculation: "ISO",
					  eventLimit: true,
					  views: {
					    month: {
					      eventLimit: 12
					    }
					  },
					  eventLimitClick: 'week', //popover
					  navLinks: true,
					  //defaultDate: moment('2019-05'), //실제 사용시 삭제
					  timeFormat: 'HH:mm',
					  defaultTimedEventDuration: '01:00:00',
					  editable: true,
					  minTime: '00:00:00',
					  maxTime: '24:00:00',
					  slotLabelFormat: 'HH:mm',
					  weekends: true,
					  nowIndicator: true,
					  dayPopoverFormat: 'MM/DD dddd',
					  longPressDelay: 0,
					  eventLongPressDelay: 0,
					  selectLongPressDelay: 0

				});//seccess END
				$(document).ready(function() {
					alert("리로딩을 합니다.")
				    <script src="<c:url value='/js/addEvent.js' />"></script>
				    <script src="<c:url value='/js/editEvent.js' />"></script>
				    <script src="<c:url value='/js/etcSetting.js' />"></script>
				});
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