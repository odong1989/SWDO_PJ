package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.GroupJoin;


public interface GroupMapper {

	public ArrayList<Group> selectGroupJoin(String member_id);
	
	public HashMap<String, Object> selectCode(Group group);
	
	public int updateCode(Group group);
	
	public Group codeMemberChk(HashMap<String, Object> map);
	
	public int insertGroup(Group group);
	
	public int selectGroupNo(String group_name);
	
	public String selectGroupName(int group_no);
	
	public int joinTrue(GroupJoin gjoin);
}
