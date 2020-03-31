package net.softsociety.binder.dao;

import java.util.ArrayList;

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
		GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
		return mapper.selectGroupJoinMemberOne(memberCheck);
		
	}
	
	public ArrayList<GroupJoin> selectGroupJoinMember(GroupJoin vo) {
		log.info("selectGroupJoinMember 파라미터 : {}",vo);
		
		ArrayList<GroupJoin> list = null;
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
	public int updateGroupMember2(GroupJoin vo) {
		// TODO Auto-generated method stub
		int chk= 0;
		try {
			GroupJoinMapper mapper = session.getMapper(GroupJoinMapper.class);
			chk=mapper.updateGroupMember2(vo);
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

}
