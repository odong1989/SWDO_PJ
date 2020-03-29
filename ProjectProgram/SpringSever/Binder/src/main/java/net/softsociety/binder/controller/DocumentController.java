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

import net.softsociety.binder.dao.DocumentDAO;
import net.softsociety.binder.dao.GroupDAO;
import net.softsociety.binder.dao.HashTagDAO;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.HashTag;

//@선언
@Controller
@RequestMapping(value="document/")
public class DocumentController {

	//0.dao선언
	@Autowired GroupDAO 	groupDao;
	@Autowired DocumentDAO  documentDao;
	@Autowired HashTagDAO   hashTagDao;
	
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);
	
	@RequestMapping(value="mainDocument", method=RequestMethod.GET)
	public String mainDocument(HttpSession session, //Model modelGroupJoinList, Model modelDocumentList, Model modelHashTagList)
			Model model)
	{	
		logger.info("mainDocument 이동");
		String member_id = (String) session.getAttribute("loginId");
		logger.info("mainDocument - member_id :{}",member_id);
		
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		logger.info("-그룹리스트 : {}", groupJoinList);
		model.addAttribute("groupJoinList", groupJoinList);
		
		return "/document/mainDocument";
		
	}	
	
	@RequestMapping(value="group", method=RequestMethod.GET)
	public String group(HttpSession session, int no , Model model)
	{	
		logger.info("mainDocument 이동");
		String member_id = (String) session.getAttribute("loginId");
		logger.info("mainDocument - member_id :{}",member_id);
		
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		logger.info("-그룹리스트 : {}", groupJoinList);
		model.addAttribute("groupJoinList", groupJoinList);
		
		ArrayList<HashMap<String, Object>> documentList = documentDao.selectDocuments(no);
		logger.info("-그룹 내 글 : {}",documentList);
		model.addAttribute("documentList", documentList);
		
		ArrayList<HashTag> hashTagList = hashTagDao.selectHashTags(member_id); 
		logger.info("-해시태그");
		model.addAttribute("hashTagList", hashTagList);
		
		return "/document/mainDocument";
	}	

	@RequestMapping(value="boardTemp", method=RequestMethod.GET)
	public String boardTemp(HttpSession session )
	{
		logger.info("boardTemp 메소드 실시& 이동");		
		return "/document/boardTemp";
	}	
}