<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>
		
		<div id="right-body">
			<div id="right-body-menuWrap"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->
			<table id="document-body">
				<tr><td><input type="hidden" id='groupNumber' value="${groupNumber}"></td></tr>
				<tr height="40px">
					<td width="21%">
						<a href="javascript:write(${groupNumber})">
							<img src="<c:url value='/img/pencil.png' />" title="글쓰기"> 
						</a>
						<%@ include file="../includes/membermodal.jsp" %>					
						<a href="javascript:selectGroup(${groupNumber})">
						<img src="<c:url value='/img/cal.png' />" title="목록으로전환">
						</a>
					</td>
				</tr>
			</table>
			</div>
			<!-- Fullcalendar 위한 별도의 div -->
			<div id="right-body-FullcalendarWrap" style="background-color:white; padding:30px;"><!-- right-body내의 2개의 테이블이 각자의 div내에 포함된다.-->
				<div id="wrapper">
		            <div id="loading"></div>
		            <div id="calendar"></div>
		        </div>
		</div>
	</div>
	
	  <!-- 일자 클릭시 메뉴오픈 -->
        <div id="contextMenu" class="dropdown clearfix">
            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
                style="display:block;position:static;margin-bottom:5px;">
                <li><a tabindex="-1" href="#">일정추가하기</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
            </ul>
        </div>
        
	    <!-- 일정 추가 MODAL -->
        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    
                    <div class="modal-body">
                        <div class="row">
                           <div class="col-xs-12">
                                <label class="col-xs-4" for="groupNum"></label>
                                <input class="inputModal" type="hidden" name="groupNum" id="groupNum" value="${groupNumber}"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input class="inputModal" type="text" name="edit-title" id="edit-title" required="required" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">장소</label>
                                <input class="inputModal" type="text" name="edit-desc" id="edit-desc" required="required" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">시작일</label>
                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">종료일</label>
                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
                            </div>
                        </div>
                        
                        <div class="row" style="display:none"><!-- 첨부않는방향이므로 숨김처리 실시. -->
                            <div class="col-xs-12">
                                <label class="col-xs-4">사진</label>
                                <input class="inputModal" type="file" name="upload" />
                            </div>
                        </div>
                 
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

  
  		<!-- 패널부분을 삭제하면 풀 캘린더에 일정이 나오지 않더라. 아직은 아래의 패널쪽 div들은 지우지 말것. -->
        <div class="panel panel-default" style="display:none;">
          <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나" checked>사나</label>
		</div>
	    <!-- /.container -->
    
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
    
   	<%@ include file="../includes/vuemodal.jsp" %>
   	
</body>
</html>