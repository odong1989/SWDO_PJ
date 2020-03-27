package net.softsociety.binder.dao;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//import com.sun.media.jfxmedia.logging.Logger;

import net.softsociety.binder.controller.MemberController;
import net.softsociety.binder.vo.Member;

@Repository
public class MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAO.class);	
	
	@Autowired
	private SqlSession session;

	public Member memberSelectOne (String member_id) {
		logger.info("MemberController-Mypage 프로세스 - memberSelectOne 메소드 시작");
		Member member = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.memberSelectOne(member_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("MemberController-Mypage 프로세스 - 리턴 member값 : {}", member);
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
	
	
	public Member memberSelectOne2 (Member member) {
		logger.info("MemberController-Mypage 프로세스 - memberSelectOne2 메소드 시작");
		Member resultMember = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			resultMember = mapper.memberSelectOne2(member);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("MemberController-Mypage 프로세스 - 리턴 member값 : {}", resultMember);
		return resultMember;
		
		
	}

/*	
	public Member memberUpdate(Member updateMemberData){
		//업데이트 된 정보를 리턴해주어 사용자가 마이페이지에서 바로 확인 되도록 한다.
		logger.info("MemberDAO-memberUpdate 실시");
		logger.info("MemberDAO-수신된 업데이트할 정보 : {}", updateMemberData);
		Member resultMemberData=null;	
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			resultMemberData = mapper.memberUpdate(updateMemberData);
			resultMemberData = mapper.memberUpdate(updateMemberData);
			logger.info("MemberDAO-업데이트 결과&리턴할 값 : {}",resultMemberData);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("MemberDAO-memberUpdate 메소드 종료");
		return resultMemberData;	
	}
	*/

	public void memberUpdate(Member updateMemberData){
		//업데이트 된 정보를 리턴해주어 사용자가 마이페이지에서 바로 확인 되도록 한다.
		logger.info("MemberDAO-memberUpdate 실시");
		logger.info("MemberDAO-수신된 업데이트할 정보 : {}", updateMemberData);
		Member resultMemberData=null;	
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.memberUpdate(updateMemberData);
			logger.info("MemberDAO-업데이트 결과&리턴할 값 : {}",resultMemberData);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("MemberDAO-memberUpdate 메소드 종료");
	}



}
