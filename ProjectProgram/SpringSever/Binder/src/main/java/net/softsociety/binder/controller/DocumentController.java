package net.softsociety.binder.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.softsociety.binder.dao.DocumentDAO;
import net.softsociety.binder.dao.GroupDAO;
import net.softsociety.binder.dao.GroupMemberDAO;
import net.softsociety.binder.dao.HashTagDAO;
import net.softsociety.binder.dao.NoteDAO;
import net.softsociety.binder.dao.PhotoDAO;
import net.softsociety.binder.dao.ReplyDAO;
import net.softsociety.binder.util.FileService;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.GroupJoin;
import net.softsociety.binder.vo.HashTag;
import net.softsociety.binder.vo.Note;
import net.softsociety.binder.vo.Photo;
import net.softsociety.binder.vo.Reply;

//@선언
@Controller
@RequestMapping(value="document/")
public class DocumentController {

	//0.dao선언
	@Autowired GroupDAO 	groupDao;
	@Autowired DocumentDAO  documentDao;
	@Autowired HashTagDAO   hashTagDao;
	@Autowired NoteDAO 	    noteDao;
	@Autowired PhotoDAO 	photoDao;
	@Autowired GroupMemberDAO groupMemberDao;
	@Autowired ReplyDAO replyDao;
	
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);
    private final String uploadPath = "/uploadFile";
	
	@RequestMapping(value="mainDocument", method=RequestMethod.GET)
	public String mainDocument(HttpSession session, //Model modelGroupJoinList, Model modelDocumentList, Model modelHashTagList)
			Model model)
	{	
		logger.info("mainDocument 이동");
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
		
		return "/document/mainDocument";
		
	}	
	
	@RequestMapping(value="group", method=RequestMethod.GET)
	public String group(HttpSession session, int no , Model model, GroupJoin vo)
	{	
		logger.info("readDocument 이동");
		String member_id = (String) session.getAttribute("loginId");
		
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		if (memoCheck.size() == 0){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		model.addAttribute("groupJoinList", groupJoinList);
		
//		ArrayList<Document> caution = documentDao.selectCaution(no);
		Document caution = documentDao.selectCaution(no);
		logger.info("-공지사항 : {}", caution);
		model.addAttribute("caution", caution);
		
		ArrayList<HashMap<String, Object>> documentList = documentDao.selectDocuments(no);
		model.addAttribute("documentList", documentList);
		
		ArrayList<HashTag> hashTagList = hashTagDao.selectHashTags(member_id); 
		logger.info("-해시태그");
		model.addAttribute("hashTagList", hashTagList);
		model.addAttribute("group_no", no);
		vo.setGroup_no(no);
		logger.info("groupMemberMgr {}",vo);
		ArrayList<GroupJoin> join = groupMemberDao.selectGroupJoinMember(vo);
		logger.info("groupMemberMgr {}",join);
		model.addAttribute("gjoin",join);
		return "/document/readDocument";
	}
	
	@RequestMapping(value="boardTemp", method=RequestMethod.GET)
	public String boardTemp(HttpSession session )
	{
		logger.info("boardTemp 실행");		
		return "/document/boardTemp";
	}	
	
	
	//신규 게시판글(documents) 작성하는 jsp페이지로 이동
	//[*글 및 사진을 DB에 추가하는  "documentInsert"에서 실시합니다.]
	@RequestMapping(value="writeDocument", method=RequestMethod.GET)
	public String writeDocument(HttpSession session, int no ,Model model)
	{	//선택한 그룹의 번호값을 갖고와야한다. //int no :선택한 모임(그룹)의 PK번호
		logger.info("writeDocument 실행");	
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
		model.addAttribute("writeDocumentGroup_no", no); //글 작성을 위해서는 소속 그룹의 번호(PK) 필요하기에 넘기고 있습니다.
		
		return "/document/writeDocument";
	}
	
	
	//신규 게시판글(documents)과 첨부사진을 uploadPath에 저장된 경로에 따라 저장한다.
	//uploadPath는 "/uploadFile"으로 설정되어있다.;
	@RequestMapping(value="documentInsert", method=RequestMethod.POST)
	public String documentInsert(HttpSession session, Document writeDocument,MultipartFile upload, Model model)
	{	
		logger.info("documentInsert 실행");

		String ErrMsg=""; //만약 업로드 에러 발생시 리턴하여 사용자에게 출력하도록 한다.
		Photo photo = new Photo();
		writeDocument.setMember_id((String)session.getAttribute("loginId"));
		logger.info("documentInsert메소드 기입된 Document 값 : {}",writeDocument);

        //
	     int count = documentDao.insertCaution(writeDocument); //insertCaution : Document를 추가하는 메소드입니다.
	     logger.info("3.VO를 DB에 INSERT count : {}",count);
	     if(count ==0) {
	            logger.info("글(document) 등록실패");
	     }
	     else if(count ==1) {
	            logger.info("글(document) 등록성공");
	     }
		//게시글(Document) insert 코드 종료.아래에는 사진추가 메소드가 실시.---------------------------------------------------
	     

        if(upload.isEmpty()) {//case1. 첨부사진이 없는 경우 : 기본사진으로 설정.

        	//1.도큐먼트번호, 그룹번호도 같이 부여한다. 이를 않으면 readDocument.jsp에서 등록한 글 출력않됨.
        	photo.setGroup_no(writeDocument.getGroup_no());//그룹번호 부여
	    	photo.setDocument_no(documentDao.selectDocumentNoOne(writeDocument));//도큐먼트번호 부여

	    	String savedfile = FileService.saveFile(upload, uploadPath, "photo", photo.getGroup_no(), photo.getDocument_no());
	        photo.setPhoto_savedfile("noImageforBinderBasicImage.png"); //DB가 사용한 파일의 별명
	        photo.setPhoto_originfile("noImageforBinderBasicImage.png");//원본 파일명
        	
        
        }
        else {//case2. 본인이 첨부한 사진을 로컬저장&DB에 저장

        	//1.도큐먼트번호, 그룹번호도 같이 부여한다. 이를 않으면 readDocument.jsp에서 등록한 글 출력않됨.
        	photo.setGroup_no(writeDocument.getGroup_no());//그룹번호 부여
	    	photo.setDocument_no(documentDao.selectDocumentNoOne(writeDocument));//도큐먼트번호 부여

            //2.업로드된 파일의 경로(파일명)을 photoVO에게 설정(set)
	    	String savedfile = FileService.saveFile(upload, uploadPath, "photo", photo.getGroup_no(), photo.getDocument_no());
	        photo.setPhoto_savedfile(savedfile); //DB가 사용한 파일의 별명
	        photo.setPhoto_originfile(upload.getOriginalFilename());//원본 파일명
        }
        // logger.info("photoVO의 정보 : {}",photo); 
        
        // 3.photoVO를 DB에 INSERT            
        int count2 = photoDao.photoInsert(photo);
        logger.info("3.VO를 DB에 INSERT count : {}",count);
        if(count2 ==0) {
               logger.info("사진을 HDD저장&사진정보 DB등록 실패");
        }
        else if(count2 ==1) {
            logger.info("사진을 HDD저장&사진정보 DB등록 성공");
        }


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
		
		return "/document/mainDocument";
	}
	
	//신규 게시판글(documents)과 첨부사진을 uploadPath에 저장된 경로에 따라 저장한다.
	//uploadPath는 "/uploadFile"으로 설정되어있다.;
	@RequestMapping(value="documentInsertTemp", method=RequestMethod.GET)
	public void documentInsertTemp(HttpSession session, Document writeDocument)
	{	
		logger.info("documentInsertTemp메소드 시작.");
		logger.info("documentInsertTemp메소드 세션계정 : {}",session.getAttribute("loginId"));

		String ErrMsg=""; //만약 업로드 에러 발생시 리턴하여 사용자에게 출력하도록 한다.
		Photo photo = new Photo();
		writeDocument.setMember_id((String)session.getAttribute("loginId"));
		logger.info("documentInsert메소드 기입된 Document 값 : {}",writeDocument);

        //
	     int count = documentDao.insertCaution(writeDocument); //insertCaution : Document를 추가하는 메소드입니다.
	     logger.info("3.VO를 DB에 INSERT count : {}",count);
	     if(count ==0) {
	            logger.info("글(document) 등록실패");
	     }
	     else if(count ==1) {
	            logger.info("글(document) 등록성공");
	     }
		//게시글(Document) insert 코드 종료.아래에는 사진추가 메소드가 실시.---------------------------------------------------
	
		logger.info("documentInsertTemp메소드 종료.");
	
	}
	
	
	@RequestMapping(value="editDocument", method=RequestMethod.GET)
	public String editDocument(HttpSession session, Model model, int no)
	{	
		String member_id = (String) session.getAttribute("loginId");
		logger.info("editDocument 이동, {}",member_id);
				
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		model.addAttribute("groupJoinList", groupJoinList);
		
		ArrayList<HashMap<String, Object>> map = documentDao.selectDocuments(no);
		model.addAttribute("doc", map);
		
		return "/document/editDocument";
		
	}
	//그룹멤버확인 초대코드아이디로 보낼때
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
	//그룹회원 부매니저로 전환
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
	//그룹회원 일반회원 전환
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
	//그룹회원삭제
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
	//공지사항 등록
	@RequestMapping(value="insertCaution", method=RequestMethod.GET)
	@ResponseBody
	public String insertCaution(Document vo, String caution, HttpSession session, int gno) {
		
		logger.info("insertCaution {}",caution);
		String member_id = (String) session.getAttribute("loginId");
		vo.setMember_id(member_id);
		vo.setGroup_no(gno);
		vo.setDocument_content(caution);
		int chkdel = documentDao.deleteCaution(gno);
		logger.info("insertCaution - deleteCaution {}",chkdel);
		
		int chknum = documentDao.insertCaution(vo);
		
		String chk = null;
		if (chknum != 0) {
			chk = "true";
		} else {
			chk = "false";
		}
		return chk;
	}
	//초대코드 이메일로 보내기
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
	
	@RequestMapping(value="readContentDocument", method=RequestMethod.GET)
	public String readContentDocument(HttpSession session, int no , Model model) {
		logger.info("readContent {}", no);
		
		String member_id = (String) session.getAttribute("loginId");
		
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		if (memoCheck.size() == 0){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		
		model.addAttribute("documentno", no);
		model.addAttribute("loginId", member_id);
		
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		model.addAttribute("groupJoinList", groupJoinList);
		
		ArrayList<HashMap<String, Object>> documentList = documentDao.selectDocuments(no);
		model.addAttribute("documentList", documentList);
		
		ArrayList<HashTag> hashTagList = hashTagDao.selectHashTags(member_id); 
		logger.info("-해시태그");
		model.addAttribute("hashTagList", hashTagList);
		
		model.addAttribute("Reply", new Reply());
	
		return "document/readContentDocument";
	}
	
	@RequestMapping(value="writeReply", method=RequestMethod.POST)
	@ResponseBody
	public String writeReply(Reply vo) {
		logger.info("writeReply 시작{}", vo);
		int replychk = replyDao.insertReply(vo);
		String chk;
		if(replychk == 1) {
			logger.info("writeReply 성공 {}", replychk);
			chk ="true";
		}else {
			chk="false";
		}
		return chk;
	}
	@RequestMapping(value="getReply", method=RequestMethod.POST)
	@ResponseBody
	public ArrayList<Reply> getReply(int no){
		logger.info("getReply 시작 {}", no);
		ArrayList<Reply> replyList = replyDao.selectReply(no);
		logger.info("getReply 확인 {}", replyList);
		return replyList;
	}
}