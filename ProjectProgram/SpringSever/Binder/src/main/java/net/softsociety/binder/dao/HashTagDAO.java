package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.HashTag;
//import com.sun.media.jfxmedia.logging.Logger;


@Repository
public class HashTagDAO {
	private static final Logger logger = LoggerFactory.getLogger(HashTagDAO.class);	
	
	@Autowired
	private SqlSession session;
	
	public ArrayList<HashTag> selectHashTags(String member_id){
		ArrayList<HashTag> hashTagList = null;
		try {
			HashTagMapper mapper = session.getMapper(HashTagMapper.class);
			hashTagList = mapper.selectHashTags(member_id);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return hashTagList;
	}
	
	public int insertHash(HashTag hashtag) {
		int result = 0;
		try {
			HashTagMapper mapper = session.getMapper(HashTagMapper.class);
			result = mapper.insertHash(hashtag);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<HashMap<String,Object>> hashRankNow() {
		ArrayList<HashMap<String,Object>> result = null;
		try {
			HashTagMapper mapper = session.getMapper(HashTagMapper.class);
			result = mapper.hashRankNow();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<HashMap<String,Object>> hashRankMonth() {
		ArrayList<HashMap<String,Object>> result = null;
		try {
			HashTagMapper mapper = session.getMapper(HashTagMapper.class);
			result = mapper.hashRankNow();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
}
