package com.boseong.swdo3th.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import com.boseong.swdo3th.VO.Board;
import com.boseong.swdo3th.VO.Reply;

public interface BoardMapper {

	public int	                              insertBoard(Board board);

	public HashMap<String, Object>            selectBoardOne(int board_no);
	public int					   			  selectTotalCount(String searchText);
	public ArrayList<HashMap<String, Object>> selectBoardList(RowBounds rb ,String searchText); //페이징까지 처리
	
	public int 								  boardDelete(Board board);
	public void 							  boardUpdate(Board board);
	
	public void 						  	  replyInsert(Reply reply);
	public ArrayList<Reply>					  selectReply(int board_no);
	public void 							  replyDelete(Reply reply);

	public void 							  replyUpdate(Reply reply);
	public void 							  updateHits(int board_no);
}
