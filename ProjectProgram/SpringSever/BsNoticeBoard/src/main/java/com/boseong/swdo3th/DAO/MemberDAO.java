package com.boseong.swdo3th.DAO;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//import com.sun.media.jfxmedia.logging.Logger;

import com.boseong.swdo3th.Controller.MemberController;
import com.boseong.swdo3th.VO.Board;
import com.boseong.swdo3th.VO.Member;

@Repository
public class MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAO.class);	
	
	@Autowired
	private SqlSession session;

	public Member memberSelectOne (String member_id) {
		logger.info("BoardDAO.java - memberSelectOne 메소드 시작");
		Member member = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.memberSelectOne(member_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("BoardDAO.java - memberSelectOne 리턴 member값 : {}", member);
		return member;
	}

	public int memeberJoin(Member member) {
		int result = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			result = mapper.memeberJoin(member);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}	
	
	public void memberUpdateName(Member member){
	logger.info("BoardDAO.java - memberUpdateName 시작 ");
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.memberUpdateName(member);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("BoardDAO.java - memberUpdateName 종료");
	}

	public void memberUpdateAddress(Member member){
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.memberUpdateAddress(member);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void memberUpdatePassword(Member member){
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.memberUpdatePassword(member);
		}catch(Exception e) {
			e.printStackTrace();
		}		
	}
}
