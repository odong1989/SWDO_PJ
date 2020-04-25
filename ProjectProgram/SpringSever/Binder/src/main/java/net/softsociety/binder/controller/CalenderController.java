package net.softsociety.binder.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.softsociety.binder.dao.DocumentDAO;
import net.softsociety.binder.dao.GroupDAO;
import net.softsociety.binder.dao.GroupJoinDAO;
import net.softsociety.binder.dao.GroupMemberDAO;
import net.softsociety.binder.dao.NoteDAO;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.GroupJoin;
import net.softsociety.binder.vo.Note;
import net.softsociety.binder.vo.CalenderVO;

//@선언
@Controller
@RequestMapping(value="calender")
public class CalenderController {

	@Autowired GroupDAO 	groupDao;
	@Autowired NoteDAO 	    noteDao;
	@Autowired DocumentDAO documentDao;
	@Autowired GroupJoinDAO groupJoinDao;
	@Autowired GroupMemberDAO groupMemberDao;
	private static final Logger logger = LoggerFactory.getLogger(CalenderController.class);

	@RequestMapping(value="calenderMain", method=RequestMethod.GET)
	public String calenderMain(String group_no ,HttpSession session, int no , Model model, GroupJoin vo){
		
		logger.info("calenderMain 이동");
		//모든 페이지에 있어야 하는 출력데이터
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		if (memoCheck.size() == 0){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		model.addAttribute("groupJoinList", groupJoinList);
		//공통 데이터 종료
		Document caution = documentDao.selectCaution(no);
		logger.info("-공지사항 : {}", caution);
		model.addAttribute("caution", caution);
		//공지사항 가져오는 코드		
		model.addAttribute("groupNumber", no); 
		//캘린더의 일정을 뽑아오기 위해 pk값(소속그룹번호)를 넘기고 있습니다.
		vo.setGroup_no(no);
		vo.setMember_id(member_id);
		GroupJoin memberjoin = groupMemberDao.selectGroupJoinChkId(vo);
		model.addAttribute("memberJoin", memberjoin);
		logger.info("groupMemberMgr {}",vo);
		ArrayList<HashMap<String, Object>> join = groupMemberDao.selectGroupJoinMember(vo);
		logger.info("groupMemberMgr {}",join);
		model.addAttribute("gjoin",join);
		//그룹 멤버현황 가져오기 위한 코드
				
		return "/calender/calenderMain";
	}
	
	/*오라클DB로부터 일정데이터를 수신(일정추가/삭제/수정은 모두 DocumentController.java에서 실시.)
	  getUserSchedule은 오로지 일정을 받아오기만 실시한다.*/
	@RequestMapping(value="getUserSchedule", method=RequestMethod.POST)
	@ResponseBody
	public ArrayList<HashMap<String,Object>> getUserSchedule(String group_no ,HttpSession session)
	{	
		logger.info("calenderMain-getUserSchedule 메소드 시작");
		//스텝1 : 정상적으로 값 수신되었는지 확인.
		//스텝2 :	DocumentDAO에서 아래의 메소드를 활용한다.
		GroupJoin groupCal = new GroupJoin();
		
		groupCal.setMember_id((String) session.getAttribute("loginId"));
		groupCal.setGroup_no(Integer.parseInt(group_no));
		logger.info("calenderMain -GroupJoin groupCal : {}",groupCal);
		
		ArrayList<HashMap<String,Object>> documentList = null;
		documentList = documentDao.selectDocumentsForCalendar(groupCal);		
		
		logger.info("getUserSchedule 메소드 - documentList : {}",documentList);
		return documentList;	
	}
	
	
	@RequestMapping(value="insertCaution", method=RequestMethod.GET)
	@ResponseBody
	public String insertCautionC(Document vo, String caution, HttpSession session, int gno) {
		logger.info("insertCautionC {}",caution);
		String member_id = (String) session.getAttribute("loginId");
		vo.setMember_id(member_id);
		vo.setGroup_no(gno);
		vo.setDocument_content(caution);
		int chkdel = documentDao.deleteCaution(gno);
		logger.info("insertCautionC- deleteCaution {}",chkdel);
		
		int chknum = documentDao.insertCaution(vo);
		
		String chk = null;
		if (chknum != 0) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
}