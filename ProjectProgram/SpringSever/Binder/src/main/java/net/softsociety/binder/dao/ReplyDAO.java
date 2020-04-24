package net.softsociety.binder.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//import com.sun.media.jfxmedia.logging.Logger;
import net.softsociety.binder.vo.Reply;


@Repository
public class ReplyDAO {
	private static final Logger logger = LoggerFactory.getLogger(ReplyDAO.class);	
	
	@Autowired
	private SqlSession session;
	
	public ArrayList<Reply> selectReply(int no) {
		logger.info("댓글기능 불러오기 {}", no);
		ArrayList<Reply> rep = null;
		try {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			rep = mapper.selectReply(no);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return rep;
	}
	
	public int insertReply(Reply vo) {
		int chk = 0;
		try {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			chk = mapper.insertReply(vo);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return chk;
	}
}