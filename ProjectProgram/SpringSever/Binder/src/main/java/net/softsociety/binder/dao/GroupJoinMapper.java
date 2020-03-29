package net.softsociety.binder.dao;

import java.util.ArrayList;

import net.softsociety.binder.vo.GroupJoin;



public interface GroupJoinMapper {
	public GroupJoin selectGroupJoinMember(GroupJoin vo);
	public String selectGroupJoinMemberOne(String memberCheck);
}
