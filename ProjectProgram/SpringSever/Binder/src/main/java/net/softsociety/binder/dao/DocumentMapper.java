package net.softsociety.binder.dao;

import java.util.ArrayList;

import net.softsociety.binder.vo.Document;


public interface DocumentMapper {

	public ArrayList<Document> selectDocuments(String member_id);
}
