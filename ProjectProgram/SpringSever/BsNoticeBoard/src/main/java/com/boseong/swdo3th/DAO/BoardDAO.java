package com.boseong.swdo3th.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//import com.sun.media.jfxmedia.logging.Logger;

import com.boseong.swdo3th.VO.Board;
import com.boseong.swdo3th.VO.Reply;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSession session;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAO.class);
	
	public ArrayList<HashMap<String, Object>> selectBoardList(int startRecord, int countPerPage, String searchText){
		ArrayList<HashMap<String, Object>> list = null;
		try {
			RowBounds rb =new RowBounds(startRecord, countPerPage);
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			list = mapper.selectBoardList(rb, searchText);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	
	public int insertBoard(Board board) {
		int count =0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			count = mapper.insertBoard(board);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
			
		return count;
		}
	
	

	
	
	public HashMap<String, Object> selectBoardOne(int board_no){
		HashMap<String, Object> result = null;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			logger.info("(DAO)board_no ({})",board_no);
			result = mapper.selectBoardOne(board_no);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("(DAO)result ({})",result);
		return result;
	}
	
	public int	selectTotalCount(String searchText) {
		int totalCount = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			//logger.info("(DAO)board_no ({})",board_no);
			totalCount = mapper.selectTotalCount(searchText);
		}catch(Exception e) {
			e.printStackTrace();
		}
	//	logger.info("(DAO)result ({})",result);
		return totalCount;
	}
	
	public int boardDelete(Board board) {
		int result_delete=0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			result_delete = mapper.boardDelete(board);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	//	logger.info("(DAO)result ({})",result);
	
		return result_delete;
	}
	
	public void boardUpdate(Board board) {
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.boardUpdate(board);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	//	logger.info("(DAO)result ({})",result);	
	}
	
	
	
	//20.02.12
	public void replyInsert(Reply reply) {
		logger.info("BoardDAO - replyInsert 시작 ");
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.replyInsert(reply);
			
		}catch(Exception e) {
			logger.info("BoardDAO - replyInsert - 예외처리 발생 ");
			e.printStackTrace();
		}
	}
	public ArrayList<Reply> selectReply(int board_no){
		ArrayList<Reply> replyList = null;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			replyList=mapper.selectReply(board_no);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return replyList;
	}
	
	public void replyDelete(Reply reply) {
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.replyDelete(reply);
			
		}catch(Exception e) {
			e.printStackTrace();
		}		
	}
	
	public void replyUpdate(Reply reply) {

		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.replyUpdate(reply);
		}catch(Exception e) {
			
			e.printStackTrace();
		}			
	}
	
	public void updateHits(int board_no) {
		try {
			logger.info("updateHits 메소드 실시.");
			logger.info("(DAO)board_no :  {} ",board_no);
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		mapper.updateHits(board_no);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
