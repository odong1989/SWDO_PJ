package net.softsociety.binder.dao;

import java.util.ArrayList;

import net.softsociety.binder.vo.Group;


public interface GroupMapper {

	public ArrayList<Group> selectGroupJoin(String member_id);
}
