package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.CalenderVO;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.GroupJoin;


public interface DocumentMapper {

	public ArrayList<HashMap<String, Object>> selectDocuments(int group_no);
	
	public int insertDocument(Document writeDocument);
	public int insertCaution(Document caution);
	public int deleteCaution(int group_no);
	public Document selectCaution(int group_no);

	//보성 작성
	public ArrayList<HashMap<String,Object>> selectDocumentsForCalendar(GroupJoin groupCal); //일정출력-풀캘린더 용
	public int selectDocumentNoOne(Document caution);	//1개의 글의 글번호(No)확인 메소드임. 글추가(insertCaution)시 사진도 첨부위해서 글번호 확인용.
	public HashMap<String, Object> selectDocumentOne(int no);//1개의 글을 로드하는데 소속그룹과 글번호필요.
	public void deleteDocumentOne(Document deletelDocument);//1개의 글을 삭제하기 위해 실시. 
	public void updateDocumentOne(Document originalDocument);		
	// 글수정 버튼,풀캘린더내의 변경버튼, 풀캘린더의 드래그&드롭 총 3가지 경우에 작동하도록 수정.
	
	//수환 작성
	//해시태그 검색기
	public ArrayList<String> hashSearch(String hash);
	//추천명소 검색기
    public String sightsSearch(String sights);
}
