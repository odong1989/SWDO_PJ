package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.HashTag;


public interface HashTagMapper {

	public ArrayList<HashTag> selectHashTags(String member_id);
	
	public int insertHash(HashTag hashtag);
	
	public ArrayList<HashMap<String,Object>> hashRankNow();

	public ArrayList<HashMap<String,Object>> hashRankMonth();
}
