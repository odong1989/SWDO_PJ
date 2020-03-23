package com.boseong.swdo3th.DAO;

import java.util.ArrayList;

import com.boseong.swdo3th.VO.Document;

public interface DocumentMapper {

	public ArrayList<Document> selectDocuments(String member_id);
}
