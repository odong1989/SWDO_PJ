package global.sesoc.sample.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.sample.vo.Board;
import global.sesoc.sample.vo.Reply;

public interface BoardMapper {
	
	public ArrayList<HashMap<String, Object>> selectBoardList(RowBounds rb, String searchText);
	
	public HashMap<String, Object> selectBoardOne(int board_no);
	
	public int insertBoard(Board board);
	
	public int addHits(int board_no);
	
	public int selectTotalCount(String searchText);
	
	public int deleteBoard(Board board);
	
	public int updateBoard(Board board);
	
	public ArrayList<HashMap<String,Object>> replySelect(int board_no);
	
	public int replyInsert(Reply reply);
	
	public int replyDelete(Reply reply);
}
