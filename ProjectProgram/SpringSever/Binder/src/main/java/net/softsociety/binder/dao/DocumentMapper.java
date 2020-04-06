package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.GroupJoin;


public interface DocumentMapper {

	public ArrayList<HashMap<String, Object>> selectDocuments(int group_no);
	public ArrayList<HashMap<String, Object>> selectDocumentsForCalendar(GroupJoin groupCal);
	public int insertCaution(Document caution);
	public int deleteCaution(int group_no);
	public Document selectCaution(int group_no);
}
