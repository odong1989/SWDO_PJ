package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.Document;


public interface DocumentMapper {

	public ArrayList<HashMap<String, Object>> selectDocuments(int group_no);
}
