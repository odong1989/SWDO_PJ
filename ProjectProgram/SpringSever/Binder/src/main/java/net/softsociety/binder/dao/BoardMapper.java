package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import net.softsociety.binder.vo.Board;
import net.softsociety.binder.vo.Reply;

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
