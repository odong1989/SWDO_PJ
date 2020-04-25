/* ****************
 *  일정 편집
 * ************** */
var editEvent = function (event, element, view) {
	console.log(event);
    //삭제메소드가 실행되기 위해서 전송할 데이터를 정의&값 할당으로 추정.
	$('#deleteEvent').data('id', event._id); //클릭한 이벤트 ID
	
	$('#deleteEvent').data('document_no', event.document_no);
	$('#deleteEvent').data('document_content',event.titleSS);
	$('#deleteEvent').data('document_regdate',event.start._i);
	$('#deleteEvent').data('photo_originfile',event.photo_originfile);
	
	if (event.end == null){
		$('#deleteEvent').data('document_finalday',event.start);		
		event.end=event.start;
	}
	else{ 
		$('#deleteEvent').data('document_finalday',event.end);
	}
	
	$('#deleteEvent').data('document_destination',event.description);	
	//---------------------------------------------------------------------
	
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
      //editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'));
    	editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD'));
    } else {
        //editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
        editEnd.val(event.end.format('YYYY-MM-DD'));
    }

    modalTitle.html('일정 수정');
    editTitle.val(event.title);
    //editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
    editStart.val(event.start.format('YYYY-MM-DD'));
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

        if (editTitle.val() === '') {
            alert('일정명은 필수입니다.')
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
    
        //DB에 저장하기 위한 변수. 계정정보는 http세션통해 전송.
        var eventSaveData = {
        	group_no : group_no,   						//그룹번호
        	document_no : event.document_no,  			//글의 번호
        	document_content : event.title,		  		//컨텐츠
        	document_regdate : event.start,				//시작일
        	document_finalday : event.end, 				//마지막일
        	document_destination : event.description, 	//장소
        	photo_originfile : event.photo_originfile
        };
        
        //일정 업데이트
        $.ajax({
            type: "get",
            url: "../document/editDocument",
            data : eventSaveData,
            success: function (eventSaveData) {
                alert('수정되었습니다.');
            },
            error:function(request, error) {
            	alert("에러가 발생하였습니다.");
            	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    });
};

// 삭제버튼
//$('#deleteEvent').on('click', function () { //오리지널
    $(document).on('click','#deleteEvent',function(){ //ajax통해 로딩되기에 재로딩 실시
    $('#deleteEvent').unbind();
    $("#calendar").fullCalendar('removeEvents', $(this).data('id'));
    eventModal.modal('hide');


	//DB에 저장하기 위한 변수. 계정정보는 http세션통해 전송.
    var eventSaveData = {
    	group_no : group_no,   									//그룹번호
    	document_no : $(this).data('document_no'),  			//글의 번호
    	document_content : $(this).data('document_content'),  	//컨텐츠
    	document_regdate : $(this).data('document_regdate'),	//시작일
    	document_finalday : $(this).data('document_finalday'), 	//마지막일
    	document_destination : $(this).data('document_destination') //장소
    };
    
    //삭제시
    $.ajax({
        type: "get",
        url: "../document/deleteDocument",
        data : eventSaveData,
        success: function (eventSaveData) {
            alert('삭제되었습니다.');
        },
        error:function(request, error) {
        	alert("에러가 발생하였습니다.");
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });

});
   