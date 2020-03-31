package net.softsociety.binder.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.HashTag;
//import com.sun.media.jfxmedia.logging.Logger;


@Repository
public class HashTagDAO {
	private static final Logger logger = LoggerFactory.getLogger(HashTagDAO.class);	
	
	@Autowired
	private SqlSession session;
	
	public ArrayList<HashTag> selectHashTags(String member_id){
		logger.info("HashTagDAO.java - selectHashTags 메소드 시작");	
		ArrayList<HashTag> hashTagList = null;
		try {
			HashTagMapper mapper = session.getMapper(HashTagMapper.class);
			hashTagList = mapper.selectHashTags(member_id);
			logger.info("HashTagDAO.java - hashTagList의 수신값 : {}",hashTagList);			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("HashTagDAO.java - 최종 리턴되는 hashTagList : {}",hashTagList);			
		logger.info("HashTagDAO.java - selectHashTags 메소드 종료");	
		return hashTagList;
	
	}
}
