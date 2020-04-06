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
import org.springframework.web.multipart.MultipartFile;

import net.softsociety.binder.dao.DocumentDAO;
import net.softsociety.binder.dao.GroupDAO;
import net.softsociety.binder.dao.HashTagDAO;
import net.softsociety.binder.dao.NoteDAO;
import net.softsociety.binder.dao.PhotoDAO;
import net.softsociety.binder.util.FileService;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.HashTag;
import net.softsociety.binder.vo.Note;
import net.softsociety.binder.vo.Photo;



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
	
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);
    private final String uploadPath = "/uploadFile";
	
	@RequestMapping(value="mainDocument", method=RequestMethod.GET)
	public String mainDocument(HttpSession session, //Model modelGroupJoinList, Model modelDocumentList, Model modelHashTagList)
			Model model)
	{	
		logger.info("mainDocument 이동");
		String member_id = (String) session.getAttribute("loginId");
		logger.info("mainDocument - member_id :{}",member_id);
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		if (memoCheck.size() == 0){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		
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
		
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		if (memoCheck.size() == 0){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		
		ArrayList<Group> groupJoinList = groupDao.selectGroupJoin(member_id);
		logger.info("-그룹리스트 : {}", groupJoinList);
		model.addAttribute("groupJoinList", groupJoinList);
		
		Document caution = documentDao.selectCaution(no);
		logger.info("-공지사항 : {}", caution);
		model.addAttribute("caution", caution);
		
		ArrayList<HashMap<String, Object>> documentList = documentDao.selectDocuments(no);
		logger.info("-그룹 내 글 : {}",documentList);
		model.addAttribute("documentList", documentList);
		
		ArrayList<HashTag> hashTagList = hashTagDao.selectHashTags(member_id); 
		logger.info("-해시태그");
		model.addAttribute("hashTagList", hashTagList);
		model.addAttribute("group_no", no);
		return "/document/readDocument";
	}
	
	@RequestMapping(value="boardTemp", method=RequestMethod.GET)
	public String boardTemp(HttpSession session )
	{
		logger.info("boardTemp 메소드 실시& 이동");		
		return "/document/boardTemp";
	}	
	
	
	//신규 게시판글(documents) 작성하는 jsp페이지로 이동
	//[*글 및 사진을 DB에 추가하는  "documentInsert"에서 실시합니다.]
	@RequestMapping(value="writeDocument", method=RequestMethod.GET)
	public String writeDocument(HttpSession session, int no ,Model model)
	{	//선택한 그룹의 번호값을 갖고와야한다. //int no :선택한 모임(그룹)의 PK번호
		logger.info("writeDocument 메소드 실시& 이동");	
		String member_id = null;
		member_id = (String) session.getAttribute("loginId");
		logger.info("mainDocument - member_id :{}",member_id);
		logger.info("mainDocument - 그룹의 번호(PK) :{}",no);		
		model.addAttribute("writeDocumentGroup_no", no); //글 작성을 위해서는 소속 그룹의 번호(PK) 필요하기에 넘기고 있습니다.
		
		return "/document/writeDocument";
	}
	
	
	//신규 게시판글(documents)과 첨부사진을 uploadPath에 저장된 경로에 따라 저장한다.
	//uploadPath는 "/uploadFile"으로 설정되어있다.;
	@RequestMapping(value="documentInsert", method=RequestMethod.POST)
	public String documentInsert(HttpSession session, Document writeDocument,MultipartFile upload)
	{	
		logger.info("documentInsert메소드 시작.");
		logger.info("documentInsert메소드 세션계정 : {}",session.getAttribute("loginId"));

		String ErrMsg=""; //만약 업로드 에러 발생시 리턴하여 사용자에게 출력하도록 한다.
		Photo photo = new Photo();
		writeDocument.setMember_id((String)session.getAttribute("loginId"));
		logger.info("documentInsert메소드 기입된 Document 값 : {}",writeDocument);

        //
	     int count = documentDao.insertCaution(writeDocument);
	     logger.info("3.VO를 DB에 INSERT count : {}",count);
	     if(count ==0) {
	            logger.info("등록실패");
	     }
		//게시글(Document) insert 코드 종료.---------------------------------------------------
	     
	    // 
        if(!upload.isEmpty()) { //1.파일업로드 체크 / .isEmpty() : 객체가 비었냐(=파일없냐?)
            //2.업로드된 파일의 경로(파일명)을 photoVO에게 설정(set)
        	//이외에도 도큐먼트번호, 그룹번호도 같이 부여한다.
        	photo.setDocument_no(writeDocument.getDocument_no());
        	photo.setGroup_no(writeDocument.getGroup_no());
            String savedfile = FileService.saveFile(upload, uploadPath);
            photo.setPhoto_savedfile(savedfile); //DB가 사용한 파일의 별명
            photo.setPhoto_originfile(upload.getOriginalFilename());//원본 파일명
            logger.info("photoVO의 정보 : {}",photo);
            
            // 3.photoVO를 DB에 INSERT            
            int count2 = photoDao.photoInsert(photo);
            logger.info("3.VO를 DB에 INSERT count : {}",count);
            if(count2 ==0) {
                   logger.info("등록실패");
            }
        }

	     
		
		logger.info("documentInsert메소드 종료.");
		return "/document/mainDocument";
		//return "/document/readDocument";//readDocument이동시 가입한 그룹들이 출력되지 않음.
		
		/* 신경써야할 자료 목록. 체크 완료시 삭제할 것!
			VO인 document.java의 구조를 준수한다.  			//본 폼에서 담당하는 정보 여부
			private int group_no;					//ㅇ 	
			private int document_no;				//X이건 SQL에서 알아서 nextval로 체크.
			private String member_id;				//X세션의 정보를 준다.
			private String document_content;		//ㅇ id='content'
			private String document_regdate;		//ㅇ id='startDate'
			private String document_finalday;		//ㅇ id='endDate'
			private String document_destination;	//ㅇ id='place'  (장소정보이다. 미입력시 널값으로 처리됨)


			첨부하는 사진은 Photo.java VO를 준수한다.
			private int 	documnet_no;			//X(본 문서의 번호에서 자동퍼오도록 한다	.)
			private String 	photo_originfile;		//O(사용자가 업로드시 사용한 파일의 원래이름
			private String 	photo_savefile;			//X
			private int 	photo_no;				//X 
		 */
		
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
	
	
}