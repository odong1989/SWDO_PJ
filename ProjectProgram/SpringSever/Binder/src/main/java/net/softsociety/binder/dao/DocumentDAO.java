package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.CalenderVO;
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
	public ArrayList<HashMap<String,Object>> selectDocumentsForCalendar(GroupJoin groupCal){
		logger.info("DocumentDAO.java - selectDocumentsForCalendar시작 & 그룹번호 : {})",groupCal);	
		ArrayList<HashMap<String,Object>> documentList = null;
		int colorCNT = 0;
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

	//글작성
	public int insertDocument(Document document) {
		int cau = 0;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			cau = mapper.insertDocument(document);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cau;
	}
	
	//공지작성
	public int insertCaution(Document caution) {
		logger.info("DocumentDAO.java - insertCaution({})", caution);
		int cau = 0;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			cau = mapper.insertCaution(caution);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - insertCaution 메소드 종료 ({})", cau);
		return cau;
	}
	
	//1개의 글을 로드하는데 소속그룹과 글번호필요하여 작성함.
	public Document selectDocumentOne(int no) {
		logger.info("DocumentDAO.java - selectDocumentOne메소드 파라미터 데이터 : ({})", no);
		Document resultDocument=null;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			resultDocument = mapper.selectDocumentOne(no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - selectDocumentOne 메소드 종료");
		return resultDocument;
	}
	
	public int deleteCaution(int group_no) {
		logger.info("DocumentDAO.java - insertCaution({})", group_no);
		int cau = 0;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			cau = mapper.deleteCaution(group_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return cau;
	}
	
//	public ArrayList<Document> selectCaution(int group_no) {
	public Document selectCaution(int group_no) {
	logger.info("DocumentDAO.java - selectCaution({})", group_no);
		Document vo = null;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			vo = mapper.selectCaution(group_no);
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return vo;
	}

	public int selectDocumentNoOne(Document caution){	//글추가(insertCaution)시 사진도 첨부위해서 글번호 확인용. 
		logger.info("DocumentDAO.java - selectDocumentNoOne 메소드 시작");
		logger.info("DocumentDAO.java - selectDocumentNoOne : {}", caution); 
		//그룹번호,작성자계정,작성한컨텐츠 이 3가지를 조건으로 리턴
		int docNumber = 0;
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
			docNumber = mapper.selectDocumentNoOne(caution);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - selectDocumentNoOne 메소드 종료");
		return docNumber;
	}
	
	//1개의 글을 삭제하기 위해 실시.
	public void deleteDocumentOne(Document deletelDocument){
		logger.info("DocumentDAO.java - deleteDocumentOne 메소드 시작");
		logger.info("DocumentDAO.java - deleteDocumentOne 삭제할 글 정보 : {}", deletelDocument); 
		//그룹번호,작성자계정,작성한컨텐츠 이 3가지를 조건으로 리턴
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
		    mapper.deleteDocumentOne(deletelDocument);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - deleteDocumentOne(1개의 글 삭제) 메소드  종료");
	}
	
	public void updateDocumentOne(Document originalDocument) {
		logger.info("DocumentDAO.java - updateDocumentOne 메소드 시작");
		logger.info("DocumentDAO.java - updateDocumentOne 수정할 글 정보 : {}", originalDocument); 
		//그룹번호,작성자계정,작성한컨텐츠 이 3가지를 조건으로 리턴
		try {
			DocumentMapper mapper = session.getMapper(DocumentMapper.class);
		    mapper.updateDocumentOne(originalDocument);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		logger.info("DocumentDAO.java - updateDocumentOne(1개의 글 수정) 메소드  종료");
	}
	
}

