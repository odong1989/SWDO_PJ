package net.softsociety.binder.dao;

import java.util.ArrayList;

import net.softsociety.binder.vo.HashTag;


public interface HashTagMapper {

	public ArrayList<HashTag> selectHashTags(String member_id);
}
