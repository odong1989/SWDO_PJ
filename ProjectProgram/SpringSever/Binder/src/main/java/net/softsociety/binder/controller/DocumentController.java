package net.softsociety.binder.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.softsociety.binder.dao.DocumentDAO;
import net.softsociety.binder.dao.GroupDAO;
import net.softsociety.binder.dao.GroupMemberDAO;
import net.softsociety.binder.dao.HashTagDAO;
import net.softsociety.binder.dao.MemberDAO;
import net.softsociety.binder.dao.NoteDAO;
import net.softsociety.binder.dao.PhotoDAO;
import net.softsociety.binder.dao.ReplyDAO;
import net.softsociety.binder.util.FileService;
import net.softsociety.binder.util.PageNavigator;
import net.softsociety.binder.util.ReplyPage;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.GroupJoin;
import net.softsociety.binder.vo.HashTag;
import net.softsociety.binder.vo.Member;
import net.softsociety.binder.vo.Note;
import net.softsociety.binder.vo.Photo;
import net.softsociety.binder.vo.Reply;

//@선언
@Controller
@RequestMapping(value="document/")
public class DocumentController {

	//0.dao선언
	@Autowired MemberDAO memdao;
	@Autowired GroupDAO 	groupDao;
	@Autowired DocumentDAO  documentDao;
	@Autowired HashTagDAO   hashTagDao;
	@Autowired NoteDAO 	    noteDao;
	@Autowired PhotoDAO 	photoDao;
	@Autowired GroupMemberDAO groupMemberDao;
	@Autowired ReplyDAO replyDao;
	
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);
    private final String uploadPath = "/uploadFile";
    private final String noUploadPath = "/img"; // /img/noImage.png를 불러오기 위한 용도. 
    private int countPerPage = 10;
    private int pagePerGroup = 10;

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
		
		Member MemberData = memdao.memberSelectOne((String)session.getAttribute("loginId"));
		model.addAttribute("MemberData", MemberData);
		logger.info("model 값 : {}",model);		
		
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
		vo.setMember_id(member_id);
		logger.info("groupMemberMgr {}",vo);
		ArrayList<HashMap<String, Object>> join = groupMemberDao.selectGroupJoinMember(vo);
		logger.info("groupMemberMgr {}",join);
		GroupJoin memberjoin = groupMemberDao.selectGroupJoinChkId(vo);
		model.addAttribute("memberJoin", memberjoin);
		model.addAttribute("gjoin",join);
		return "/document/readDocument";
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

	//신규글을 DB에 추가하는 2개의 메소드 중 1개입니다.(writeDocument.jsp 전용입니다.)
	@RequestMapping(value="documentInsert", method=RequestMethod.POST)
	public String documentInsert(HttpSession session, Document writeDocument,MultipartFile upload, Model model)
	{	
		logger.info("documentInsert 실행");
		//신규 게시판글(documents)과 첨부사진을 uploadPath에 저장된 경로에 따라 저장한다.
		//uploadPath는 "/uploadFile"으로 설정되어있다.;
		
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

	    	
	    	String savedfile = FileService.saveFile(upload, noUploadPath, "photo", photo.getGroup_no(), photo.getDocument_no());
	    										 //	   	              저장경로,														
	    	photo.setPhoto_savedfile("noImage.png"); //DB가 사용한 파일의 별명
	        photo.setPhoto_originfile("noImage.png");//원본 파일명
        	
        
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
               logger.info("첨부사진없음/기본제공인 noImage로 대체");
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


	//신규글을 DB에 추가하는 2개의 메소드 중 나머지 1개입니다.(calenderMain.jsp 전용입니다.)
	@RequestMapping(value="documentInsertTemp", method=RequestMethod.GET)
	@ResponseBody
	public void documentInsertTemp(HttpSession session, Document writeDocument,MultipartFile upload)
	{	
		//신규 게시판글(documents)과 첨부사진을 uploadPath에 저장된 경로에 따라 저장한다.
		//uploadPath는 "/uploadFile"으로 설정되어있다.;

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

	     //1.도큐먼트번호, 그룹번호도 같이 부여한다. 이를 않으면 readDocument.jsp에서 등록한 글 출력않됨.
	        	photo.setGroup_no(writeDocument.getGroup_no());//그룹번호 부여
		    	photo.setDocument_no(documentDao.selectDocumentNoOne(writeDocument));//도큐먼트번호 부여

		    	String savedfile = FileService.saveFile(upload, uploadPath, "photo", photo.getGroup_no(), photo.getDocument_no());
		        photo.setPhoto_savedfile("noImageforBinderBasicImage.png"); //DB가 사용한 파일의 별명
		        photo.setPhoto_originfile("noImageforBinderBasicImage.png");//원본 파일명
	        		        
	        
	        // 3.photoVO를 DB에 INSERT            
	        int count2 = photoDao.photoInsert(photo);
	        logger.info("3.VO를 DB에 INSERT count : {}",count);
	        if(count2 ==0) {
	               logger.info("첨부사진없음/기본제공인 noImage로 대체함.");
	        }
	        else if(count2 ==1) {
	            logger.info("사진을 HDD저장&사진정보 DB등록 성공");
	        }
	        
		logger.info("documentInsertTemp메소드 종료.");
	}
	
	
	//댓글기능
	@RequestMapping(value="readContentDocument", method=RequestMethod.GET)
	public String readContentDocument(HttpSession session, int no , Model model) {
		logger.info("readContent {}", no);
		String member_id = (String) session.getAttribute("loginId");
		
		//사용자가 작성한 글 1개만 로드 시작-----------------------------------------------
		Document caution=null;
		caution = documentDao.selectDocumentOne(no); 
		model.addAttribute("document", caution);
		logger.info("readContentDocument - 출력될 글 정보 : {}",caution);
		//사용자가 작성한 글 1개만 로드 종료-----------------------------------------------

		//사용자가 작성한 위의 글과 도큐먼트 번호가 같은 사진의 정보를 받기 시작.----------------------------
		//도큐먼트(Document caution)는 사진정보를 담을 수 있는 칼럼이 없기 때문이다.
		Photo cautionPhoto =null;
		cautionPhoto = photoDao.selectPhotoOne(no);
		model.addAttribute("cautionPhoto", cautionPhoto);
		logger.info("readContentDocument - 출력할 사진  : {}", cautionPhoto);
		//사용자가 작성한 위의 글과 도큐먼트 번호가 같은 사진의 정보를 받기 종료.----------------------------		

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
	
		return "document/readContentDocument";
	}
	
	
	@RequestMapping(value="deleteDocument",method=RequestMethod.GET)
	@ResponseBody
	public void deleteDocument(HttpSession session, Document deletelDocument)
	{
		logger.info("deleteDocument-기존 글(Document) 삭제 작업시작합니다.");
		logger.info("deleteDocument-현 로그인 계정 : {}",session.getAttribute("loginId"));

		String member_id = (String) session.getAttribute("loginId");
		deletelDocument.setMember_id(member_id);
		logger.info("deleteDocument-삭제할 글의 정보 : {}",deletelDocument);
		
		documentDao.deleteDocumentOne(deletelDocument); //글 삭제 메소드 실시.
	}
	
	
	//글 내용 수정 메소드로 활용하기로 결정.(글 변경페이지는 readContentDocument메소드를 참고하십시오)
	@RequestMapping(value="editDocument", method=RequestMethod.GET)
	public String editDocument(HttpSession session, int no, Model model)
	{	
		logger.info("editDocument 메소드 시작.");
		logger.info("읽을 문서번호 : {}", no);
		
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
		
		
		//사용자가 작성한 글 1개만 로드 시작-----------------------------------------------
		Document caution=null;
		caution = documentDao.selectDocumentOne(no); 
		model.addAttribute("document", caution);
		logger.info("readContentDocument - 출력될 글 정보 document : {}",caution);
		//사용자가 작성한 글 1개만 로드 종료-----------------------------------------------

		//사용자가 작성한 위의 글과 도큐먼트 번호가 같은 사진의 정보를 받기 시작.----------------------------
		//도큐먼트(Document caution)는 사진정보를 담을 수 있는 칼럼이 없기 때문이다.
		Photo cautionPhoto =null;
		cautionPhoto = photoDao.selectPhotoOne(no);
		model.addAttribute("cautionPhoto", cautionPhoto);
		logger.info("readContentDocument - 출력할 사진  cautionPhoto : {}", cautionPhoto);
		//사용자가 작성한 위의 글과 도큐먼트 번호가 같은 사진의 정보를 받기 종료.----------------------------		
		
		
		logger.info("editDocument 메소드 종료 & editDocument.jsp로 이동");
		return "/document/editDocument";
	}
	
	//그룹멤버확인 초대코드아이디로 보낼때
	@RequestMapping(value="selectGJM", method=RequestMethod.GET)
	@ResponseBody
	public String selectGJM(String memberCheck, HttpSession session, int no, HttpServletRequest request, Model model) {
		String memberCheck2 = groupMemberDao.selectGroupJoinMemberOne(memberCheck);
		logger.info("selectGJM {}",memberCheck2);
		logger.info("selectGJM {}",no);
		String chk = null;
		
		//memberCheck 유저의 존재여부에 따라 분기처리
		if (memberCheck2 != null) {
			chk = "true";
			
			//System메시지 전송
			String member_id = (String)session.getAttribute("loginId");
			//전달될 내용
			Note note = new Note();
			String code = null;
			String date7 = null;
			note.setMember_id("system");
			note.setNote_receiver(memberCheck);
			note.setNote_title(member_id + "님의 초대 메시지입니다.");

			//도메인 및 포트 가져오기
			String addr = request.getScheme() + "://" + request.getServerName()+":"+request.getServerPort() + request.getContextPath();
			
			//코드 생성 or 코드 가져오기
			Group group = new Group();
			group.setGroup_no(no);
			HashMap<String, Object> oldgroup = groupDao.selectCode(group);
			
			//기존 코드가 존재
			if (oldgroup != null) {
				logger.info("이미 코드가 존재 {},{}", oldgroup);
				code = (String) oldgroup.get("GROUP_CODE");
				date7 = (String) oldgroup.get("GROUP_CODEDATE7");
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
					code = (String) oldgroup.get("GROUP_CODE");
					date7 = (String) oldgroup.get("GROUP_CODEDATE7");
				} else {
					logger.info("코드 업데이트 실패");
				}
			}
			StringBuffer content = new StringBuffer(); 
			content.append("아래 링크를 클릭하면 가입 안내 페이지로 이동합니다.</br>");
			content.append("<p class='codeOpen'>" + addr + "/group/groupjoin?code=" + code + "</p></br>");
			content.append("<font color='red'>유효기간 : ~" + date7 + "</font>");
			
			note.setNote_content(content.toString());
			
			//쪽지 전송
			noteDao.insertNote(note);
		} else {
			chk = "false";
		}
		return chk;
	}
	
	//그룹회원 매니저권한 부여
	@RequestMapping(value="updateGJMM", method=RequestMethod.GET)
	@ResponseBody
	public String memberUpdateM(GroupJoin vo, String memberid, int groupno, HttpSession session) {
		vo.setMember_id(memberid);
		vo.setGroup_no(groupno);
		vo.setMember_level(1);
		logger.info("updateGJMM {}",vo);
		int memberUpdate = groupMemberDao.updateGroupMember(vo);
		String chk = null;
		if (memberUpdate == 1) {
			chk = "true";
			String login_id = (String)session.getAttribute("loginId");
			vo.setMember_id(login_id);
			vo.setGroup_no(groupno);
			vo.setMember_level(2);
			int memberU = groupMemberDao.updateGroupMember(vo);
			
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
		vo.setMember_level(2);
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
		vo.setMember_level(3);
		logger.info("updateGJMC {}",vo);
		int memberUpdate = groupMemberDao.updateGroupMember(vo);
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
		
		
		//from 수환
		//공지사항 여부를 확인하는 컬럼에 1이 담기지 않고 있음
		//수정바람
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
	
	@RequestMapping(value="writeReply", method=RequestMethod.POST)
	@ResponseBody
	public String writeReply(int document_no, String member_id, String reply_content) {
		Reply vo = new Reply();
		vo.setDocument_no(document_no);
		vo.setMember_id(member_id);
		vo.setReply_content(reply_content);
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
	
	@RequestMapping(value="updateReply", method=RequestMethod.POST)
	@ResponseBody
	public String updateReply(int reply_no, String reply_content) {
		Reply vo = new Reply();
		vo.setReply_no(reply_no);
		vo.setReply_content(reply_content);
		logger.info("updateReply 시작{}", vo);
		int replychk = replyDao.updateReply(vo);
		String chk;
		if(replychk == 1) {
			logger.info("updateReply 성공 {}", replychk);
			chk ="true";
		}else {
			chk="false";
		}
		return chk;
	}
	@RequestMapping(value="deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public String deleteReply(int reply_no) {
		Reply vo = new Reply();
		vo.setReply_no(reply_no);
		logger.info("deleteReply 시작{}", vo);
		int replychk = replyDao.deleteReply(vo);
		String chk;
		if(replychk == 1) {
			logger.info("deleteReply 성공 {}", replychk);
			chk ="true";
		}else {
			chk="false";
		}
		return chk;
	}
	@RequestMapping(value="getReply", method=RequestMethod.POST)
	@ResponseBody
	public ReplyPage getReply(int document_no, @RequestParam(value="currentPage",defaultValue="1")int currentPage){
		logger.info("no {}" , document_no);
		logger.info("page {}",currentPage);
		logger.info("getReply 시작 {}", document_no);
		int totalCount = replyDao.totalCount(document_no);
		PageNavigator page = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalCount);
		ArrayList<Reply> replyList = replyDao.selectReply(document_no, page.getStartRecord(), countPerPage);
		logger.info("getReply 확인 {}", replyList);
		ReplyPage rpage = new ReplyPage(totalCount, replyList, page);
		logger.info("ReplyPage 값 {}",rpage);
		return rpage;
	}
}