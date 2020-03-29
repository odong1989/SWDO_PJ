package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.Group;


public interface GroupMapper {

	public ArrayList<Group> selectGroupJoin(String member_id);
	
	public HashMap<String, Object> selectCode(Group group);
	
	public int updateCode(Group group);
}
