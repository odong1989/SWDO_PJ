<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${group_name }</title>

	<link href="<c:url value='/css/basic.css' />" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/vendor/css/fullcalendar.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/select2.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/vendor/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/css/main.css'/>" >
    <link href="<c:url value='/css/modal.css' />" rel="stylesheet">
    <link href="<c:url value='/css/readDocuStyle.css' />" rel="stylesheet">
    
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<script>
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
	 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트입니다.------------------------------
    $(function() {
        $("#imgInp").on('change', function(){
            readURL(this);
        });
    });
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
                $('#previewImg').attr('src', e.target.result);
            }
          reader.readAsDataURL(input.files[0]);
        }
    }
 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트 종료.----------------------------
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
				changeToFullCalendar +='<!-- 일자 클릭시 메뉴오픈 -->';
				changeToFullCalendar += '<div id="contextMenu" class="dropdown clearfix">';
				changeToFullCalendar +=      '<ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"style="display:block;position:static;margin-bottom:5px;">';
				changeToFullCalendar +=     	'<li><a tabindex="-1" href="#">일정등록</a></li>';
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
				
														<!--새로운일정 등록 모달팝업창 -사진등록-모달바디 -->				
				changeToFullCalendar +=                 '<div class="row">';
				changeToFullCalendar +=                    '<div class="col-xs-12">';
				changeToFullCalendar +=                         '<label class="col-xs-4" for="edit-type">사진등록</label>';
				changeToFullCalendar +=                         '<input type="file" class="inputModal" name="upload" id="imgInp">';
				changeToFullCalendar +=  				    '    <img id="previewImg" src="#" width="250" height="250" alt="프사 미리보기" />';
				changeToFullCalendar +=                    '</div>';
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
							
                changeToFullCalendar +=   '</div>';
                changeToFullCalendar +=   '<!-- /.container -->';
				console.log(changeToFullCalendar);
						
				document.getElementById('right-body').innerHTML=changeToFullCalendar;
				//==========================================
				var eventModal = $('#eventModal');

var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
//var editType = $('#edit-type'); //원래는 이거지만 사진등록으로 바꾼다.
//var imgInp = $('#imgInp');		  //기존의 #edit-type에서 변경하였다. 필요할까?
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');


/* ****************
 *  새로운 일정 생성
 * ************** */
var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김

    modalTitle.html('새로운 일정');
    editType.val(eventType).prop('selected', true);
    editTitle.val('');
    editStart.val(start);
    editEnd.val(end);
    editDesc.val('');
    
    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');

    /******** 임시 RAMDON ID - 실제 DB 연동시 삭제 **********/
    var eventId = 1 + Math.floor(Math.random() * 1000);
    /******** 임시 RAMDON ID - 실제 DB 연동시 삭제 **********/

    //새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
//    $('#save-event').on('click', function () {
    $(document).on('click','#save-event',function(){
    //    alert('일정명은 필수입니다.');
        var eventData = {
            _id: eventId,
            title: editTitle.val(),
            start: editStart.val(),
            end: editEnd.val(),
            description: editDesc.val(),
            type: editType.val(),
            username: '사나',
            backgroundColor: editColor.val(),
            textColor: '#ffffff',
            allDay: false
        };

        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title == '') {
         //   alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;

        if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD');
            //render시 날짜표기수정
            eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD');
            //DB에 넣을때(선택)
            realEndDay = moment(eventData.end).format('YYYY-MM-DD');

            eventData.allDay = true;
        }

        $("#calendar").fullCalendar('renderEvent', eventData, true);
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');

        //새로운 일정 저장
        $.ajax({
            type: "get",
            url: "",
            data: {
                //.....
            },
            success: function (response) {
                //DB연동시 중복이벤트 방지를 위한
                //$('#calendar').fullCalendar('removeEvents');
                //$('#calendar').fullCalendar('refetchEvents');
            }
        });
    });
};

				 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트입니다.------------------------------
				        $(function() {
				            $("#imgInp").on('change', function(){
				                readURL(this);
				            });
				        });
				        function readURL(input) {
				            if (input.files && input.files[0]) {
				            var reader = new FileReader();
				            reader.onload = function (e) {
				                    $('#previewImg').attr('src', e.target.result);
				                }
				              reader.readAsDataURL(input.files[0]);
				            }
				        }
				 //이미지를 첨부할 경우 자동으로 html상에서 보여주는 기능의 자바스크립트 종료.----------------------------

 				//===========================================
				//[3]addEvent.js start
				/* ****************
				 *  일정 편집
				 * ************** */
				var editEvent = function (event, element, view) {
				    $('#deleteEvent').data('id', event._id); //클릭한 이벤트 ID
				    $('.popover.fade.top').remove();
				    $(element).popover("hide");
				    if (event.allDay === true) {
				        editAllDay.prop('checked', true);
				    } else {
				        editAllDay.prop('checked', false);
				    }
				    if (event.end === null) {
				        event.end = event.start;
				    }
				    if (event.allDay === true && event.end !== event.start) {
				        editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
				    } else {
				        editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
				    }
				    modalTitle.html('일정 수정');
				    editTitle.val(event.title);
				    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
				    editType.val(event.type);
				    editDesc.val(event.description);
				    editColor.val(event.backgroundColor).css('color', event.backgroundColor);
				    addBtnContainer.hide();
				    modifyBtnContainer.show();
				    eventModal.modal('show');
				
				    //업데이트 버튼 클릭시
				    $('#updateEvent').unbind();
				    $('#updateEvent').on('click', function () {
				
				        if (editStart.val() > editEnd.val()) {
				            alert('끝나는 날짜가 앞설 수 없습니다.');
				            return false;
				        }
				
				        if (editTitle.val() == '') {
				          //  alert('일정명은 필수입니다.')
				            return false;
				        }
				
				        var statusAllDay;
				        var startDate;
				        var endDate;
				        var displayDate;
				
				        if (editAllDay.is(':checked')) {
				            statusAllDay = true;
				            startDate = moment(editStart.val()).format('YYYY-MM-DD');
				            endDate = moment(editEnd.val()).format('YYYY-MM-DD');
				            displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
				        } else {
				            statusAllDay = false;
				            startDate = editStart.val();
				            endDate = editEnd.val();
				            displayDate = endDate;
				        }
				
				        eventModal.modal('hide');
				
				        event.allDay = statusAllDay;
				        event.title = editTitle.val();
				        event.start = startDate;
				        event.end = displayDate;
				        event.type = editType.val();
				        event.backgroundColor = editColor.val();
				        event.description = editDesc.val();
				
				        $("#calendar").fullCalendar('updateEvent', event);
				
				        //일정 업데이트
				        $.ajax({
				            type: "get",
				            url: "",
				            data: {
				                //...
				            },
				            success: function (response) {
				                alert('수정되었습니다.')
				            }
				        });
				
				    });
				};
				
				// 삭제버튼
				$('#deleteEvent').on('click', function () {
				    
				    $('#deleteEvent').unbind();
				    $("#calendar").fullCalendar('removeEvents', $(this).data('id'));
				    eventModal.modal('hide');
				
				    //삭제시
				    $.ajax({
				        type: "get",
				        url: "",
				        data: {
				            //...
				        },
				        success: function (response) {
				            alert('삭제되었습니다.');
				        }
				    });
				
				});
				
				
				//[3]addEvent.js end
				//============================================
				
				//============================
				//[1] main.js
				var draggedEventIsAllDay;
var activeInactiveWeekends = true;

function getDisplayEventDate(event) {

  var displayEventDate;

  if (event.allDay == false) {
    var startTimeEventInfo = moment(event.start).format('HH:mm');
    var endTimeEventInfo = moment(event.end).format('HH:mm');
    displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;
  } else {
    displayEventDate = "하루종일";
  }

  return displayEventDate;
}

function filtering(event) {
  var show_username = true;
  var show_type = true;

  var username = $('input:checkbox.filter:checked').map(function () {
    return $(this).val();
  }).get();
  var types = $('#type_filter').val();

  show_username = username.indexOf(event.username) >= 0;

  if (types && types.length > 0) {
    if (types[0] == "all") {
      show_type = true;
    } else {
      show_type = types.indexOf(event.type) >= 0;
    }
  }

  return show_username && show_type;
}

function calDateWhenResize(event) {

  var newDates = {
    startDate: '',
    endDate: ''
  };

  if (event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  } else {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

function calDateWhenDragnDrop(event) {
  // 드랍시 수정된 날짜반영
  var newDates = {
    startDate: '',
    endDate: ''
  }

  // 날짜 & 시간이 모두 같은 경우
  if(!event.end) {
    event.end = event.start;
  }

  //하루짜리 all day
  if (event.allDay && event.end === event.start) {
    console.log('1111')
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = newDates.startDate;
  }

  //2일이상 all day
  else if (event.allDay && event.end !== null) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  }

  //all day가 아님
  else if (!event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

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
					        .append('<p><strong>:</strong> ' + event.type + '</p>')
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
					    { title: '${documentList[0].DOCUMENT_DESTINATION}',
						  start: '${documentList[0].DOCUMENT_REGDATE}',
					      end  : tempDocumentList, 
					      imageurl :'<c:url value="/img/bell.png" />' 
					      //imageurl :'/${documentList[0].PHOTO_SAVEDFILE}'
					    }
					 /*   { title: '${documentList[1].DOCUMENT_DESTINATION}',
						  start: '${documentList[1].DOCUMENT_REGDATE}',
						    end: documentList[1].DOCUMENT_FINALDAY
						}*/
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
				//[1]main.js END

				
				//========================================
				//[2] editEvent.js
				// 일정 편집
				var editEvent = function (event, element, view) {

				    $('#deleteEvent').data('id', event._id); //클릭한 이벤트 ID

				    $('.popover.fade.top').remove();
				    $(element).popover("hide");

				    if (event.allDay === true) {
				        editAllDay.prop('checked', true);
				    } else {
				        editAllDay.prop('checked', false);
				    }

				    if (event.end === null) {
				        event.end = event.start;
				    }

				    if (event.allDay === true && event.end !== event.start) {
				        editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
				    } else {
				        editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
				    }

				    modalTitle.html('일정 수정');
				    editTitle.val(event.title);
				    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
				    editType.val(event.type);
				    editDesc.val(event.description);
				    editColor.val(event.backgroundColor).css('color', event.backgroundColor);

				    addBtnContainer.hide();
				    modifyBtnContainer.show();
				    eventModal.modal('show');

				    //업데이트 버튼 클릭시
				    $('#updateEvent').unbind();
				    $('#updateEvent').on('click', function () {

				        if (editStart.val() > editEnd.val()) {
				            alert('끝나는 날짜가 앞설 수 없습니다.');
				            return false;
				        }

				        if (editTitle.val() == '') {
				         //   alert('일정명은 필수입니다.')
				            return false;
				        }

				        var statusAllDay;
				        var startDate;
				        var endDate;
				        var displayDate;

				        if (editAllDay.is(':checked')) {
				            statusAllDay = true;
				            startDate = moment(editStart.val()).format('YYYY-MM-DD');
				            endDate = moment(editEnd.val()).format('YYYY-MM-DD');
				            displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
				        } else {
				            statusAllDay = false;
				            startDate = editStart.val();
				            endDate = editEnd.val();
				            displayDate = endDate;
				        }

				        eventModal.modal('hide');

				        event.allDay = statusAllDay;
				        event.title = editTitle.val();
				        event.start = startDate;
				        event.end = displayDate;
				        event.type = editType.val();
				        event.backgroundColor = editColor.val();
				        event.description = editDesc.val();

				        $("#calendar").fullCalendar('updateEvent', event);

				        //일정 업데이트
				        $.ajax({
				            type: "get",
				            url: "",
				            data: {
				                //...
				            },
				            success: function (response) {
				                alert('수정되었습니다.')
				            }
				        });
				    });
				};
				// 삭제버튼
				$('#deleteEvent').on('click', function () {
				    
				    $('#deleteEvent').unbind();
				    $("#calendar").fullCalendar('removeEvents', $(this).data('id'));
				    eventModal.modal('hide');
				    //삭제시
				    $.ajax({
				        type: "get",
				        url: "",
				        data: {
				            //...
				        },
				        success: function (response) {
				            alert('삭제되었습니다.');
				        }
				    });
				});
			},error:function(){alert("캘린더 로드 중 에러가 발생되었습니다.")}
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
	<style>
	 .wirteDocForm.table {
	    width: 100%;
	    border-top: 1px solid #444444;
	    border-collapse: collapse;
	  }
	  th{
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	  }
	  td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	  }	  
	  
	</style>

</head>
<body>
	<div id="gaibu-top">
		<span id="gaibu-top-left"> 
			<a href="<c:url value='/document/mainDocument' />">
			<img src="<c:url value='/img/logo.png' />"></a>
		</span> <span id="gaibu-top-middle"> </span> <span id="gaibu-top-right">

            <img src="<c:url value='/img/bell.png' />">
			<img src="<c:url value='/img/mail.png' />">
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
							<img src="<c:url value='/img/crown_gold.png' />">
						</c:if>
						<c:if test="${glist.MEMBER_LEVEL == 2 }">
							<img src="<c:url value='/img/crown_silver.png' />">
						</c:if>
					</div>
					<div class="menu-group-button-clear"></div>
				</div>
			</c:forEach>
		</div>
		<div id="right-body">
		<!-- 기존의 공지사항 및 초대코드등 메뉴들 코드 시작 -->
			<table id="document-body">
		<!-- 기존의 공지사항 및 초대코드등 메뉴들 코드 종료 -->

		<!-- 신규글 추가 코드 시작 -->	
		 	<form action="documentInsert" method="POST" enctype="multipart/form-data"> 
			<table class="wirteDocForm">		
			     	<tr>
				        <td width=15%> <p id='currentDate' style="display:inline;"></p> </td>
				        <td width=25%> <input type="text" placeholder="장소" id='place' name="document_destination" > </td>
				        <td width=30%> <input type='date' id='startDate' name='document_regdate'  style="display:inline;"/> 부터  </td>
				   		<td width=30%> <input type='date' id='endDate' name='document_finalday'  style="display:inline;"/> 까지   </td>
					</tr>
				        
				    <tr>
						<td colspan=3>

       					    <img id="previewImg" src="<c:url value='/img/preViewImage.png' />" width="300" height="300" alt="첨부사진 미리보기" ><br> 
					        <input type='file' id="imgInp" name="upload" />
				        </td>
				    	<td>	
				    		<textarea rows="15" width="300" style="resize: none" 
				    		          id='content' name="document_content" placeholder="기록하고 싶은 내용을 적으세요">
				    		</textarea> 
				    	</td> 
				   	</tr>     
				   	           
				   	<tr border="0px">
				   		<td colspan="4" border="0"> 
				   			<input type="text" placeholder="#해시태그를 입력해주세요" style="width:400px;"> 
				   		</td>
				   	</tr>
           </table>
           <div style="text-align: center;">
					<input type="submit" value="등록">
			   		<input type="button" value="취소">
		   </div>
           </form>
			     <script>
			  	        document.getElementById('currentDate').innerHTML = new Date().toISOString().substring(0, 10);
			            document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
			            document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
			    </script>
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
    <script>
		var groupnoh='';
		var memberidh='';
		var msg; // 데이터 받아올 var
		
		Vue.component('modal', {
			  template: `
				  <transition name="modal">
				    <div class="modal-mask" @click.self="$emit('close')">
				      <div class="modal-wrapper">
				        <div class="modal-container">
				          
						<div class="modal-header">
				            <slot name="header">
				              default header
				            </slot>
				          </div>
		
				          <div class="modal-body">
				            <slot name="body">
				              default body
				            </slot>
				          </div>
		
				          <div class="modal-footer">
				            <slot name="footer">
				              default footer
				              <button class="modal-default-button" @click="$emit('close')">
				                	close
				              </button>		
				            </slot>
				          </div>
				        </div>
				      </div>
				    </div>
				  </transition>
				  `
		})
		//앱시작1
		new Vue({
	  el: '#app1',
	  data: 
		{
	    showModal: false,    
		},
	  methods: {
			openModal(){
				this.showModal = true
			},
			closeModal(){
				this.showModal = false
			},
			deleteMember(memberidh){
				groupnoh = document.getElementById("groupnoh").value;
				$.ajax({
					url:"deleteGMember",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
							history.go(0);
						}else {
							alert("실패")
						}
					}
				})
	  		},
			subManager(memberidh){
	  			groupnoh = document.getElementById("groupnoh").value;
				$.ajax({
					url:"updateGJMS",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
							history.go(0);
						}else {
							alert("실패")
						}
					}
				})
			},
			commonMember(memberidh){
	  			groupnoh = document.getElementById("groupnoh").value;
				$.ajax({
					url:"updateGJMC",
					type:"get",
					data:{"memberid" : memberidh,
						 "groupno" : groupnoh},
					success:
						function(result){
						if(result == "true"){
							alert("성공")
							history.go(0);
						}else {
							alert("실패")
						}
					}
				})
			}
	 	}
	})
		//앱시작2
			new Vue({
				el: '#app2',
				data: function(){
				return {
				  	showModal2: false,
				   	message: '',
				   	memberid: ''
					 }
				 },
				methods: {
					openModal(){
						this.showModal2 = true
					},
				showMember(){
					if(this.memberid.length > 0) {
					var mid = this.memberid;
					$.ajax({
						url:"selectGJM",
						type:"get",
						data:{"memberCheck" : mid},
						success:
							function(result){
							if(result == "true"){
								alert("성공")
							}else {
								alert("존재안함")
							}
						}
					})
					this.memberid = ''
					this.closeModal()
					}
					else {
							alert("아이디입력필요")
						}
					},
					closeModal(){
						this.showModal2 = false
					},
					doSend(){
						if (this.message.length > 0) {
				// 		이메일로 보내기
						$.ajax({
						url:"sendEmail",
						type:"get",
						data:{"email" : this.message},
						success:
							function(result){
							if(result == "true"){
								alert("성공")
							}else {
								alert("실패")
							}
						}
					})
						this.message =''
						this.closeModal()
						}
						else {
							alert('이메일 입력필요')
						}
					}
				}
			})
			//앱시작3
			new Vue({
			  el: '#app3',
			  data: function(){
			    return {
			    	showModal3: false,
			    	message: '',
				 }
			  },
			  methods: {
					openModal(){
						this.showModal3 = true
						
					},
					closeModal(){
						this.showModal3 = false
					},
					doSend(){
						if (this.message.length > 0) {
							var msg = this.message
							groupnoh = document.getElementById("gno").value;
							$.ajax({
								url:"insertCaution",
								type:"get",
								data:{"caution" : msg,
									"gno" : groupnoh
									},
								success:
								function(result){
									if(result == "true"){
										alert("성공")
										history.go(0);
									}else {
										alert("실패")
									}
								}
							})
							this.message =''
							this.closeModal()
						}else {
							alert('텍스트 입력필요')
						}
					}
			  }
			})
	</script>
</body>
</html>