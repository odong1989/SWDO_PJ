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

}
