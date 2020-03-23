package com.boseong.swdo3th.DAO;

import java.util.ArrayList;

import com.boseong.swdo3th.VO.HashTag;

public interface HashTagMapper {

	public ArrayList<HashTag> selectHashTags(String member_id);
}
