package com.boseong.swdo3th.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//import com.sun.media.jfxmedia.logging.Logger;

import com.boseong.swdo3th.VO.Document;

@Repository
public class DocumentDAO {
	private static final Logger logger = LoggerFactory.getLogger(DocumentDAO.class);	
	
	@Autowired
	private SqlSession session;

	public ArrayList<Document> selectDocuments(String member_id){
		logger.info("DocumentDAO.java - selectDocuments 메소드 시작");	
		logger.info("DocumentDAO.java - 수신된 회원Id : {}",member_id);	
		ArrayList<Document> documentList = null;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			documentList = mapper.selectDocuments(member_id);
			logger.info("GroupDAO.java - groupJoinList의 수신값 : {}",documentList);			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("GroupDAO.java - 최종 리턴되는 groupJoinList : {}",documentList);			
		logger.info("DocumentDAO.java - selectDocuments 메소드종료");	
		return documentList;
		
		}
	}