package global.sesoc.sample.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.sample.vo.Board;
import global.sesoc.sample.vo.Reply;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession session;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAO.class);
	
	public ArrayList<HashMap<String, Object>> selectBoardList(int startRecord, int countPerPage, String searchText) {
		ArrayList<HashMap<String, Object>> list = null;
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			list = mapper.selectBoardList(rb, searchText);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
		
	public HashMap<String, Object> selectBoardOne(int board_no) {
		logger.info("(DAO)글 하나 선택 ({})",board_no);
		HashMap<String, Object> map = null;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			map = mapper.selectBoardOne(board_no);
			logger.info("(DAO)글 하나 가져옴 ({})",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	public int insertBoard(Board board) {
		int result = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO) insertBoard ({})",board);
			result = mapper.insertBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int addHits(int board_no) {
		int result = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO) addHits ({})",board_no);
			result = mapper.addHits(board_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int selectTotalCount(String searchText) {
		int result = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO) selectTotalCount 검색어 : ({})",searchText);
			result = mapper.selectTotalCount(searchText);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int deleteBoard(Board board) {
		int result = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO) deleteBoard 글 번호 : ({})",board.getBoard_no());
			result = mapper.deleteBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateBoard(Board board) {
		int result = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO) updateBoard 글 번호 : ({})",board.getBoard_no());
			result = mapper.updateBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<HashMap<String,Object>> replySelect(int board_no) {
		ArrayList<HashMap<String, Object>> replyList = null;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			replyList = mapper.replySelect(board_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return replyList;
	}
	
	public int replyInsert(Reply reply) {
		int result = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO) replyInsert 글 번호 : ({})",reply.getBoard_no());
			result = mapper.replyInsert(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int replyDelete(Reply reply) {
		int result = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO) replyDelete 댓글 번호 : ({})",reply.getReply_no());
			result = mapper.replyDelete(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
