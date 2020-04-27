package net.softsociety.binder.dao;


import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import net.softsociety.binder.vo.Reply;


public interface ReplyMapper {

	public ArrayList<Reply> selectReply(int no, RowBounds rb);
	public int insertReply(Reply vo);
	public int updateReply(Reply vo);
	public int deleteReply(Reply vo);
	public int totalCount(int document_no);
	
}
