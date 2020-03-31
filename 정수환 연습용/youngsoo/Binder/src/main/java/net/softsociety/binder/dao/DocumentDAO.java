package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.Document;

//import com.sun.media.jfxmedia.logging.Logger;


@Repository
public class DocumentDAO {
	private static final Logger logger = LoggerFactory.getLogger(DocumentDAO.class);	
	
	@Autowired
	private SqlSession session;

	public ArrayList<HashMap<String, Object>> selectDocuments(int group_no){
		logger.info("DocumentDAO.java - selectDocuments({})",group_no);	
		ArrayList<HashMap<String, Object>> documentList = null;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			documentList = mapper.selectDocuments(group_no);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - selectDocuments 메소드종료");	
		return documentList;
		
		}
	}