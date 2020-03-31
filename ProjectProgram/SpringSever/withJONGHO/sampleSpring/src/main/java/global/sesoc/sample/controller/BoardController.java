package global.sesoc.sample.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.sample.dao.BoardDAO;
import global.sesoc.sample.util.FileService;
import global.sesoc.sample.util.PageNavigator;
import global.sesoc.sample.vo.Board;
import global.sesoc.sample.vo.Reply;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	private final String uploadPath = "/uploadFile";
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;
	
	@Autowired
	private BoardDAO dao;
	
	@RequestMapping(value = "/boardList", method=RequestMethod.GET
			, produces = "application/text; charset=utf8")
	public String boardList(Model model
			,@RequestParam(value="currentPage",defaultValue="1") int currentPage
			, @RequestParam(value = "searchText",defaultValue="") String searchText
			, @RequestParam(value = "errMsg",defaultValue="") String errMsg) {
		logger.info("board로 이동");
		if(errMsg != null) {
			logger.info("에러메시지 : {}",errMsg);
		}
		//전체 글 수(범위)
		int totalCount = dao.selectTotalCount(searchText);
		logger.info("({})를 포함한 글 수 : {}",searchText, totalCount);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalCount);
		
		ArrayList<HashMap<String, Object>> list = dao.selectBoardList(navi.getStartRecord(), countPerPage, searchText);
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("searchText", searchText);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("errMsg", errMsg);
		logger.info("board리스트 꺼내옴({})",list);
		
		return "/board/boardList";
	}
	
	@RequestMapping(value = "/boardWriteForm", method=RequestMethod.GET)
	public String boardWriteForm(Board board) {
		logger.info("글쓰러 감");
		return "/board/boardWriteForm";
	}
	
	@RequestMapping(value = "/boardWrite", method=RequestMethod.POST)
	public String boardWrite(Board board, MultipartFile upload
			,HttpSession session, Model model) {
		//파일 유무 체크
		if(!upload.isEmpty()) {
			//있을 경우에 서버에 물리적으로 저장
			String savedfile = FileService.saveFile(upload, uploadPath);
			board.setBoard_savedfile(savedfile);
			board.setBoard_originfile(upload.getOriginalFilename());
		}
		//세션에서 로그인한 사용자 아이디를 받아온다.
		String loginId = (String)session.getAttribute("loginId");
		board.setMember_id(loginId);
		
		int result = dao.insertBoard(board);
		if (result < 1) {
			logger.info("등록 실패({})",result);
			model.addAttribute("errMsg","저장 실패");
		} else {
			logger.info("등록 성공({})",result);
		}
		
		//저장된 파일경로 받아와서 DB에 저장한다.
		return "redirect:/board/boardList";
	}
	
	@RequestMapping(value = "/selectBoardOne", method=RequestMethod.GET)
	public String selectBoardOne(int board_no
			, @RequestParam(value="currentPage", defaultValue="1") int currentPage
			, Model model) {
		logger.info("{}번글 클릭했음",board_no);
		int result = dao.addHits(board_no);
		if (result < 1) {
			logger.info("{}번글 조회수 증가 실패)",board_no);
		} else {
		logger.info("{}번글 조회수 1 증가",board_no);
		}
		HashMap<String,Object> map = dao.selectBoardOne(board_no);
		if (map == null) {
			logger.info("가져온 글 없음");
			model.addAttribute("errMsg","해당하는 글이 없다.");
		} else {
			logger.info("글 가져왔음({})",map);
			model.addAttribute("list",map);
			model.addAttribute("currentPage", currentPage);
		}
		
		ArrayList<HashMap<String,Object>> replyList = dao.replySelect(board_no);
		logger.info("{}번 글 댓글 불러옴. {}",board_no,replyList);
		model.addAttribute("reply",replyList);
		return "/board/boardReadForm";
	}
	
	@RequestMapping(value = "/download", method=RequestMethod.GET)
	public void download(int board_no, HttpServletResponse response) {
		//화면으로 보낼거니까 response
		logger.info("{}번글 다운로드 시도",board_no);
		HashMap<String,Object> map = dao.selectBoardOne(board_no);
		String originFile = (String)map.get("BOARD_ORIGINFILE");
		String savedFile = (String)map.get("BOARD_SAVEDFILE");
		try {
			response.setHeader("Content-Disposition"
					, "attachment;filename="+URLEncoder.encode(originFile, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String fullpath = uploadPath + "/" + savedFile;
		FileInputStream fileIn = null;
		ServletOutputStream servletOut = null;
		//들여오는건 파일이라서 FileInput
		//내보내는건 HTTP라서 ServletOutput
		try {
			fileIn = new FileInputStream(fullpath);
			servletOut = response.getOutputStream();

			//input에서 가져온걸 output으로 복사해주는 copy메소드
			FileCopyUtils.copy(fileIn, servletOut);
			
			//다운로드를 하면 스트림을 닫는다
			fileIn.close();
			servletOut.close();
			logger.info("스트림 닫힘");
		} catch (IOException e) {
			//input스트림 패러미터 값이 없는 경로일 때
			//IO익셉션 발생함
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value = "/boardDelete", method=RequestMethod.GET)
	public String boardDelete(Board board, HttpSession session
			, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		logger.info("삭제 시도 / 글 번호 : ({})",board.getBoard_no());
		String loginId = (String)session.getAttribute("loginId");
		board.setMember_id(loginId);
		
		//파일이 있는지 확인
		HashMap<String, Object> map = dao.selectBoardOne(board.getBoard_no());
		String savedfile = (String)map.get("BOARD_SAVEDFILE");
		int result = dao.deleteBoard(board);
		
		//삭제가 성공했고 첨부파일이 있으면 첨부파일도 삭제한다.
		if( result != 0 && savedfile != null ) {
			String fullPath = uploadPath + "/" + savedfile;
			boolean flag = FileService.deleteFile(fullPath);
			
			if(flag) {
				logger.info("파일 삭제 성공");
			} else {
				logger.info("파일 삭제 실패");
			}
		}
		
		return "redirect:boardList?currentPage="+currentPage;
	}
	
	@RequestMapping(value = "/boardUpdateForm", method=RequestMethod.GET)
	public String boardUpdateForm(int board_no, Model model
			, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		logger.info("{}번 글 수정하러 감",board_no);
		HashMap<String, Object> map = dao.selectBoardOne(board_no);
		model.addAttribute("list", map);
		model.addAttribute("currentPage",currentPage);
		return "board/boardUpdateForm";
	}
	
	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
	public String boardUpdate(Board board, MultipartFile upload, HttpSession session
			,@RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		//세션에서 ID를 가져옴
		String loginId = (String)session.getAttribute("loginId");
		board.setMember_id(loginId);
		
		HashMap<String, Object> oldBoard = dao.selectBoardOne(board.getBoard_no());
		
		String oldSavedFile = (String)oldBoard.get("BOARD_SAVEDFILE");
		//파일이 있음
		if (!upload.isEmpty()) {
			//기존에 파일이 있음
			if (board.getBoard_savedfile() != null) {
				String fullPath = uploadPath + "/" + oldSavedFile;
				FileService.deleteFile(fullPath);
			}
			String savedfile = FileService.saveFile(upload, uploadPath);
			board.setBoard_savedfile(savedfile);
			board.setBoard_originfile(upload.getOriginalFilename());
		
		} 
		
		int result = dao.updateBoard(board);
		if (result > 0) {
			logger.info("수정 성공 ({})",board.getBoard_no());
		} else {
			logger.info("수정 실패 ({})",board.getBoard_no());
		}
		return "redirect:selectBoardOne?board_no="+board.getBoard_no()+"&currentPage="+currentPage;
	}
	
	@RequestMapping(value = "/replyInsert", method=RequestMethod.POST)
	public String replyInsert(Reply reply, HttpSession session) {
		logger.info("reply : {}",reply);
		String member_id = (String)session.getAttribute("loginId");
		reply.setMember_id(member_id);

		int result = dao.replyInsert(reply);
		if(result == 0) {
			logger.info("댓글 작성 실패");
		} else {
			logger.info("댓글 작성 성공");
		}
		return "redirect:selectBoardOne?board_no="+reply.getBoard_no();
	}
	
	@RequestMapping(value = "replyDelete", method=RequestMethod.GET)
	public String replyDelete(Reply reply, HttpSession session) {
		logger.info("replyDelete : {}",reply);
		String member_id = (String)session.getAttribute("loginId");
		reply.setMember_id(member_id);
		int result = dao.replyDelete(reply);
		if(result < 1) {
			logger.info("승재 실패");
		} else {
			logger.info("승재 성공");
		}
		return "redirect:selectBoardOne?board_no="+reply.getBoard_no();
	}
}
