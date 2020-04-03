package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.GroupJoin;

//import com.sun.media.jfxmedia.logging.Logger;


@Repository
public class GroupJoinDAO {
	private static final Logger logger = LoggerFactory.getLogger(GroupJoinDAO.class);	
	
	@Autowired
	private SqlSession session;
	
	public ArrayList<GroupJoin> selectGroupJoinMember(GroupJoin vo){
	logger.info("GroupJoinDAO.java - selectGroupJoinMember 메소드 시작");	
	ArrayList<GroupJoin> groupJoinList = null;
	try {
		GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
		groupJoinList = mapper.selectGroupJoinMember(vo);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	logger.info("GroupJoinDAO.java - selectGroupJoinMember 리턴값 :{} ",groupJoinList);
	logger.info("GroupJoinDAO.java - selectGroupJoinMember 메소드 종료");
	return groupJoinList;	
}
//	public String selectGroupJoinMemberOne(String memberCheck) {}

//	public int updateGroupMember(GroupJoin vo) {}
//	public int updateGroupMember2(GroupJoin vo) {}
//	public int deleteGMember(GroupJoin vo){}
	
	/*
	public ArrayList<Group> selectGroupJoin(String member_id){
	logger.info("GroupDAO.java - selectGroupJoin 메소드 시작");	
	ArrayList<Group> groupJoinList = null;
	try {
		GroupMapper mapper = session.getMapper(GroupMapper.class);
		groupJoinList = mapper.selectGroupJoin(member_id);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	logger.info("GroupDAO.java - selectGroupJoin 메소드 종료");
	return groupJoinList;
	}
	
	public HashMap<String, Object> selectCode(Group group) {
		logger.info("GroupDAO.java - selectCode 메소드 시작");	
		HashMap<String, Object> oldgroup = null;
		try {
			GroupMapper mapper = session.getMapper(GroupMapper.class);
			oldgroup = mapper.selectCode(group);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("GroupDAO.java - selectCode 메소드 종료");
		return oldgroup;
	}
	
	public int updateCode(Group group){
		logger.info("GroupDAO.java - updateCode 메소드 시작");	
		int result = 0;
		try {
			GroupMapper mapper = session.getMapper(GroupMapper.class);
			result = mapper.updateCode(group);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("GroupDAO.java - updateCode 메소드 종료");
		return result;
	}
	
	public Group codeMemberChk(String code, String member_id){
		logger.info("GroupDAO.java - codeMemberChk 메소드 시작");	
		Group result = null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("group_code",code);
		map.put("member_id", member_id);
		try {
			GroupMapper mapper = session.getMapper(GroupMapper.class);
			result = mapper.codeMemberChk(map);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("GroupDAO.java - codeMemberChk 메소드 종료");
		return result;
	}
	*/
}
