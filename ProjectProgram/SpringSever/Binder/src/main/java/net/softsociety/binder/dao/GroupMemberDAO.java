package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.binder.vo.GroupJoin;


@Slf4j
@Repository
public class GroupMemberDAO {

	@Autowired
	private SqlSession session;
	
	public String selectGroupJoinMemberOne(String memberCheck) {
		String chk = null;
		try {
		GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
			chk = mapper.selectGroupJoinMemberOne(memberCheck);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return chk;
		
	}
	
	public ArrayList<HashMap<String, Object>> selectGroupJoinMember(GroupJoin vo) {
		log.info("selectGroupJoinMember 파라미터 : {}",vo);
		
		ArrayList<HashMap<String, Object>> list = null;
		try {
			GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
			list = mapper.selectGroupJoinMember(vo);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	public int updateGroupMember(GroupJoin vo) {
		// TODO Auto-generated method stub
		int chk= 0;
		try {
		GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
		chk=mapper.updateGroupMember(vo);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return chk;
	}


	public int deleteGMember(GroupJoin vo) {
		// TODO Auto-generated method stub
		int chk= 0;
		try {
			GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
			chk=mapper.deleteGMember(vo);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return chk;
	}
	
	public int insertGroupJoinMaster(GroupJoin vo) {
		// TODO Auto-generated method stub
		int result = 0;
		try {
			GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
			result = mapper.insertGroupJoinMaster(vo);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public GroupJoin selectGroupJoinChkId(GroupJoin vo2) {
		// TODO Auto-generated method stub
		GroupJoin vo  = null;
		try {
			GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
			vo = mapper.selectGroupJoinChkId(vo2);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return vo;
	}
}
