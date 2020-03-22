package com.boseong.swdo3th.Controller;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.boseong.swdo3th.DAO.DocumentDAO;
import com.boseong.swdo3th.DAO.GroupDAO;
import com.boseong.swdo3th.DAO.HashTagDAO;
import com.boseong.swdo3th.VO.Document;
import com.boseong.swdo3th.VO.Group;
import com.boseong.swdo3th.VO.HashTag;

//@선언
@Controller
@RequestMapping(value="document")
public class DocumentController {

	//0.dao선언
	@Autowired GroupDAO 	groupDao;
	@Autowired DocumentDAO  documentDao;
	@Autowired HashTagDAO   hashTagDao;
	
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);
	@RequestMapping(value="mainDocument", method=RequestMethod.GET)
	public String mainDocument(HttpSession session, Model modelGroupJoinList, Model modelDocumentList, Model modelHashTagList)
	{	
		logger.info("mainDocument 이동 및 자료 수신 실시.");
		String member_id = (String) session.getAttribute("loginId");
		logger.info("mainDocument - member_id :{}",member_id);
		
		logger.info("mainDocument - 수신데이터1 : 가입한 그룹");
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		modelGroupJoinList.addAttribute("groupJoinList", groupJoinList);
		logger.info("modelGroupJoinList 에 저장&리턴될 groupJoinList값 : {} ", modelGroupJoinList);

		logger.info("mainDocument - 수신데이터2 : 작성한 글(Document)");
		ArrayList<Document> documentList = documentDao.selectDocuments(member_id);
		modelDocumentList.addAttribute("documentList", documentList);
		logger.info("modelDocumentList에 저장되어 있는 값 : {} ", modelDocumentList);
		
		logger.info("mainDocument - 수신데이터3 : 작성한 글(Document)에 대한 해시태그");
		ArrayList<HashTag> hashTagList = hashTagDao.selectHashTags(member_id); 
		modelHashTagList.addAttribute("hashTagList", hashTagList);		
		return "/document/mainDocument";
		
	}	
}