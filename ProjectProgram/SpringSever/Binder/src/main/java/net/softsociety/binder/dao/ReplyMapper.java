package net.softsociety.binder.dao;


import java.util.ArrayList;

import net.softsociety.binder.vo.Reply;


public interface ReplyMapper {

	public ArrayList<Reply> selectReply(int no);
	public int insertReply(Reply vo);
	public int updateReply(Reply vo);
	public int deleteReply(Reply vo);
	
}
