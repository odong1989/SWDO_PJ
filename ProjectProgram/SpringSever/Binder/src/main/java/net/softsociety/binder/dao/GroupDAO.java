package net.softsociety.binder.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.Group;

//import com.sun.media.jfxmedia.logging.Logger;


@Repository
public class GroupDAO {
	private static final Logger logger = LoggerFactory.getLogger(GroupDAO.class);	
	
	@Autowired
	private SqlSession session;

	public ArrayList<Group> selectGroupJoin(String member_id){
	logger.info("GroupDAO.java - selectGroupJoin 메소드 시작");	
	ArrayList<Group> groupJoinList = null;
	try {
		GroupMapper mapper = session.getMapper(GroupMapper.class);
		groupJoinList = mapper.selectGroupJoin(member_id);
		logger.info("GroupDAO.java - groupJoinList의 수신값 : {}",groupJoinList);			
	}
	catch(Exception e){
		e.printStackTrace();
	}
	logger.info("GroupDAO.java - 최종 리턴되는 groupJoinList : {}",groupJoinList);			
	logger.info("GroupDAO.java - selectGroupJoin 메소드 종료");	
	return groupJoinList;
	
	}
}
