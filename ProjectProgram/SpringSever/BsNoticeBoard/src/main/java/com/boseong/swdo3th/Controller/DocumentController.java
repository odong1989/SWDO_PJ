package com.boseong.swdo3th.Controller;

import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boseong.swdo3th.DAO.GroupDAO;
import com.boseong.swdo3th.DAO.MemberDAO;
import com.boseong.swdo3th.VO.Group;
import com.boseong.swdo3th.VO.Member;

//@선언
@Controller
@RequestMapping(value="document")
public class DocumentController {
	//0.dao선언
	@Autowired
	GroupDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);
	@RequestMapping(value="mainDocument", method=RequestMethod.GET)
	public String mainDocument(HttpSession session, Model model)
	{	
		logger.info("mainDocument 이동 및 자료 수신 실시.");
		String member_id = (String) session.getAttribute("loginId");
		logger.info("mainDocument - member_id :{}",member_id);
		
		ArrayList<Group> groupJoinList = dao.selectGroupJoin(member_id);
		model.addAttribute("groupJoinList", groupJoinList);
		logger.info("model에 저장&리턴될 groupJoinList값 : {} ", model);
		return "/document/mainDocument";
		
	}	
}