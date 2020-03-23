package com.boseong.swdo3th.DAO;

import java.util.ArrayList;

import com.boseong.swdo3th.VO.Group;

public interface GroupMapper {

	public ArrayList<Group> selectGroupJoin(String member_id);
}
