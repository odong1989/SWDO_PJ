package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.GroupJoin;

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
	
	//캘린더의 출력을 위해 마지막날짜등을 추가로 받도록 실시.
	public ArrayList<HashMap<String, Object>> selectDocumentsForCalendar(GroupJoin groupCal){
		logger.info("DocumentDAO.java - selectDocumentsForCalendar시작 & 그룹번호 : {})",groupCal);	
		ArrayList<HashMap<String, Object>> documentList = null;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			documentList = mapper.selectDocumentsForCalendar(groupCal);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - selectDocumentsForCalendar 메소드종료");	
		return documentList;	
	}

	
	public int insertCaution(Document caution) {
		logger.info("DocumentDAO.java - insertCaution({})", caution);
		int cau = 0;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			cau = mapper.insertCaution(caution);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - insertCaution 메소드 종료");
		return cau;
		}
	
	public int deleteCaution(int group_no) {
		logger.info("DocumentDAO.java - insertCaution({})", group_no);
		int cau = 0;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return cau;
	}

}
