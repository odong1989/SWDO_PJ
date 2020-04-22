package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.CalenderVO;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.GroupJoin;


public interface DocumentMapper {

	public ArrayList<HashMap<String, Object>> selectDocuments(int group_no);
	
	public ArrayList<HashMap<String,Object>> selectDocumentsForCalendar(GroupJoin groupCal);
	//	public ArrayList<HashMap<String, Object>> selectDocumentsForCalendar(GroupJoin groupCal);
	public int insertCaution(Document caution);
	public int deleteCaution(int group_no);
	
	public Document selectCaution(int group_no);
	public Document selectDocumentOne(Document caution); //1개의 글을 로드하는데 소속그룹과 글번호필요.
	
	public int selectDocumentNoOne(Document caution);	//1개의 글의 글번호(No)확인 메소드임. 글추가(insertCaution)시 사진도 첨부위해서 글번호 확인용. 
	public int updateDocument(Document caution);		//글 수정 <update id="updateDocument" parameterType="document">
}
