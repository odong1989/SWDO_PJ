package net.softsociety.binder.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

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
import net.softsociety.binder.dao.GroupMemberDAO;
import net.softsociety.binder.dao.HashTagDAO;
import net.softsociety.binder.dao.NoteDAO;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.GroupJoin;
import net.softsociety.binder.vo.HashTag;
import net.softsociety.binder.vo.Note;



//@선언
@Controller
public class GroupController {

	//0.dao선언
	@Autowired GroupDAO 	groupDao;
	@Autowired DocumentDAO  documentDao;
	@Autowired HashTagDAO   hashTagDao;
	@Autowired GroupMemberDAO groupMemberDao;
	@Autowired NoteDAO  noteDao;
	
	private static final Logger logger = LoggerFactory.getLogger(GroupController.class);
	
	@RequestMapping(value="/group/groupcode", method=RequestMethod.GET)
	public String groupcode(HttpSession session, int no , Model model)
	{	
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		logger.info("-그룹리스트 : {}", groupJoinList);
		model.addAttribute("groupJoinList", groupJoinList);
		
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		if (memoCheck == null){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		
		logger.info("코드 생성 시도");
		Group group = new Group();
		group.setGroup_no(no);
		HashMap<String, Object> oldgroup = groupDao.selectCode(group);
		
		//기존 코드가 존재
		if (oldgroup != null) {
			logger.info("이미 코드가 존재 {},{}", oldgroup);
			model.addAttribute("codebool", "ari");
			model.addAttribute("code", oldgroup);
			return "group/groupcode";
		} else {
			//코드를 새로 생성
			logger.info("코드를 새로 생성");
			StringBuffer temp = new StringBuffer();
			Random rnd = new Random();
			for (int i = 0; i < 5; i++) {
			    int rIndex = rnd.nextInt(3);
			    switch (rIndex) {
			    case 0:
			        // a-z
			        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
			        break;
			    case 1:
			        // A-Z
			        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
			        break;
			    case 2:
			        // 0-9
			        temp.append((rnd.nextInt(10)));
			        break;
			    }
			}
			logger.info("코드 생성완료 {}", temp);
			Group updategroup = new Group();
			updategroup.setGroup_code(temp.toString());
			updategroup.setGroup_no(no);
			int result = groupDao.updateCode(updategroup);
			updategroup.setGroup_code(null);
			if (result != 0) {
				logger.info("코드 업데이트 성공");
				oldgroup = groupDao.selectCode(updategroup);
				model.addAttribute("codebool","nashi");
				model.addAttribute("code", oldgroup);
				return "group/groupcode";
			} else {
				logger.info("코드 업데이트 실패");
			}
		}
		return "group/groupcode";
		
	}
	
	@RequestMapping(value="/group/groupjoin", method=RequestMethod.GET)
	public String groupjoin(HttpSession session, String code , Model model)
	{	
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		logger.info("-그룹리스트 : {}", groupJoinList);
		model.addAttribute("groupJoinList", groupJoinList);
		
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		if (memoCheck == null){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		
		logger.info("코드 접근 시도 ({})", code);
		Group group = new Group();
		group.setGroup_code(code);
		HashMap<String, Object> oldgroup = groupDao.selectCode(group);
		
		//코드가 유효
		if (oldgroup != null) {
			Group codeMemberChk = groupDao.codeMemberChk(code, member_id);
			model.addAttribute("codebool", "ari");
			model.addAttribute("code", oldgroup);
			return "group/groupjoin";
		} else {
			//유효하지 않은 코드
			logger.info("유효하지 않은 코드에 접근");
			model.addAttribute("codebool", "nashi");
		}
		return "group/groupjoin";
	}
	
	@RequestMapping(value="/groupMemberMgr", method=RequestMethod.GET)
	public String vuelist(GroupJoin vo, HttpSession session, Model model) {
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		logger.info("-그룹리스트 : {}", groupJoinList);
		model.addAttribute("groupJoinList", groupJoinList);
		
		int groupno = 1;
		vo.setGroup_no(groupno);
		logger.info("groupMemberMgr {}",vo);
		ArrayList<GroupJoin> join = groupMemberDao.selectGroupJoinMember(vo);
		logger.info("groupMemberMgr {}",join);
		model.addAttribute("gjoin",join);
		return "group/groupMemberMgr";
	}
	
	@RequestMapping(value="selectGJM", method=RequestMethod.GET)
	@ResponseBody
	public String selectGJM(String memberCheck) {
		
		String memberCheck2 = groupMemberDao.selectGroupJoinMemberOne(memberCheck);
		logger.info("selectGJM {}",memberCheck2);
		String chk = null;
		if (memberCheck2 != null) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
	
	@RequestMapping(value="updateGJMS", method=RequestMethod.GET)
	@ResponseBody
	public String memberUpdate(GroupJoin vo, String memberid, int groupno) {
		vo.setMember_id(memberid);
		vo.setGroup_no(groupno);
		logger.info("updateGJMS {}",vo);
		int memberUpdate = groupMemberDao.updateGroupMember(vo);
		String chk = null;
		if (memberUpdate == 1) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
	@RequestMapping(value="updateGJMC", method=RequestMethod.GET)
	@ResponseBody
	public String memberUpdate2(GroupJoin vo, String memberid, int groupno) {
		vo.setMember_id(memberid);
		vo.setGroup_no(groupno);
		logger.info("updateGJMC {}",vo);
		int memberUpdate = groupMemberDao.updateGroupMember2(vo);
		String chk = null;
		if (memberUpdate == 1) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
	@RequestMapping(value="deleteGMember", method=RequestMethod.GET)
	@ResponseBody
	public String gmemberDelete(GroupJoin vo, String memberid, int groupno) {
		vo.setMember_id(memberid);
		vo.setGroup_no(groupno);
		logger.info("deleteGMember {}",vo);
		int memberUpdate = groupMemberDao.deleteGMember(vo);
		String chk = null;
		if (memberUpdate == 1) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
	
	@RequestMapping(value="insertCaution", method=RequestMethod.GET)
	@ResponseBody
	public String insertCaution(Document vo, String caution, HttpSession session) {
		
		logger.info("insertCaution {}",caution);
		String member_id = (String) session.getAttribute("loginId");
		vo.setMember_id(member_id);
		vo.setGroup_no(1);
		vo.setDocument_content(caution);
		int chknum = documentDao.insertCaution(vo);

		String chk = null;
		if (chknum != 0) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
	
	@RequestMapping(value="sendEmail", method=RequestMethod.GET)
	@ResponseBody
	public String sendEmail(String email) {
		logger.info("email {}",email);
		
		
		String chk = null;
		if (email != null) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
	
	
}