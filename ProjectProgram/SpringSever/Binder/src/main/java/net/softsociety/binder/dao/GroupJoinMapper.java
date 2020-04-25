package net.softsociety.binder.dao;

import java.util.ArrayList;

import net.softsociety.binder.vo.GroupJoin;



public interface GroupJoinMapper {
	public ArrayList<GroupJoin> selectGroupJoinMember(GroupJoin vo);
	
	public String selectGroupJoinMemberOne(String memberCheck);
	
	public int updateGroupMember(GroupJoin vo);
	
	public int deleteGMember(GroupJoin vo);
	
	public int insertGroupJoinMaster(GroupJoin vo);

	public GroupJoin selectGroupJoinChkId(GroupJoin vo2);
}
