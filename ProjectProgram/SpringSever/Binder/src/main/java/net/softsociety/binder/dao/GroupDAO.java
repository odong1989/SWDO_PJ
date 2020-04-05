package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.softsociety.binder.vo.Group;

//import com.sun.media.jfxmedia.logging.Logger;


@Repository
public class GroupDAO {
	private static final Logger logger = LoggerFactory.getLogger(GroupDAO.class);	
	
	@Autowired
	private SqlSession session;

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
	
	public int insertGroup(Group group){
		logger.info("insertGroup 시작");	
		int result = 0;
		try {
			GroupMapper mapper = session.getMapper(GroupMapper.class);
			result = mapper.insertGroup(group);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("insertGroup 종료");
		return result;
	}
	
	public int selectGroupNo(String group_name){
		logger.info("insertGroup 시작");	
		int result = 0;
		try {
			GroupMapper mapper = session.getMapper(GroupMapper.class);
			result = mapper.selectGroupNo(group_name);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		logger.info("insertGroup 종료");
		return result;
	}
}
