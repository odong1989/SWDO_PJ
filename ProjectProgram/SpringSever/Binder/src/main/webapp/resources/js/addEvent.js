var eventModal = $('#eventModal');
var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');	

var editTitle = $('#edit-title');	//컨텐츠
var editStart = $('#edit-start');	//시작일
var editEnd = $('#edit-end');		//종료일
var editType = $('#edit-type');		
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');		//장소
var group_no = document.getElementById("groupNum").value;
//alert("group_no :"+group_no);

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
    	//풀캘린더에 표현 역할 담당.
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
            alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;

      //  if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD');
            //render시 날짜표기수정
            eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD');
            //DB에 넣을때(선택)
            realEndDay = moment(eventData.end).format('YYYY-MM-DD');

            eventData.allDay = true;
        //}

        $("#calendar").fullCalendar('renderEvent', eventData, true);
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');
      
        //DB에 저장하기 위한 변수
        var eventSaveData = {
        	group_no : group_no,   						 //그룹번호
        	document_content : eventData.title,  		 //컨텐츠
        	document_regdate : eventData.start, 	     //시작일
        	document_finalday : eventData.end,	 		 //마지막일
        	document_destination : eventData.description //장소
        };
        //alert("eventSaveData.group_no : "+eventSaveData.group_no);
        //alert("eventSaveData.document_regdate : "+ eventSaveData.document_regdate);
        //alert("eventSaveData.document_finalday : "+ eventSaveData.document_finalday);
        //alert("eventSaveData.document_destination : "+eventSaveData.document_destination);
        

        /*data: {"group_no":$("eventSaveData.group_no").val(),
 	   "document_regdate":$("eventSaveData.document_regdate").val(),
 	   "document_finalday":$("eventSaveData.document_finalday").val(),
   	   "document_destination":$("eventSaveData.document_destination").val()   
 },*/
        //새로운 일정 저장
        $.ajax({
            url: "../document/documentInsertTemp",
        	type: "GET",
            data: eventSaveData,
        	success: function (eventSaveData) {
            		alert("일정이저장되었습니다");
            },
            error:function(request, error) {
            	alert("에러가 발생하였습니다.");
            	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    });
};