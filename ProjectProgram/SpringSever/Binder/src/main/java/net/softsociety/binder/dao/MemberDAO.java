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

	public void memberLastLoginTime(String member_id) {
		logger.info("memberLastLoginTime메소드 시작");
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.memberLastLoginTime(member_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("memberLastLoginTime메소드 종료");
	}

	public void memberWdraw(String member_id){
		logger.info("memberWdraw 메소드 시작");
		logger.info("memberWdraw 메소드 member_id :{}",member_id);
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.memberWdraw(member_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("memberWdraw 메소드 종료");
	}
	
	public Member memberSelectOne3 (Member member) {
		logger.info("memberSelectOne3 메소드 시작");
		Member resultMember = null;
		logger.info("memberSelectOne3 메소드 - 검색위 : {}",member);
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			resultMember = mapper.memberSelectOne3(member);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("memberSelectOne3 메소드-리턴 member값 : {}", resultMember);
		return resultMember;
	}

	
	//
	public void memberUpdate(Member updateMemberData){
		//업데이트 된 정보를 리턴해주어 사용자가 마이페이지에서 바로 확인 되도록 한다.
		logger.info("MemberDAO-memberUpdate 실시");
		logger.info("MemberDAO-수신된 업데이트할 정보 : {}", updateMemberData);
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.memberUpdate(updateMemberData);
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("MemberDAO-memberUpdate 메소드 종료");
	}
	
	
	
	//비밀번호만 랜덤으로 변경+이메일로 고객에게안내
	public void memberUpdatePW(Member updateMemberData) {
		logger.info("memberUpdatePW 메소드 시작");
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
            mapper.memberUpdatePW(updateMemberData);
			logger.info("memberUpdatePW - 비밀번호 변경 완료");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("memberUpdatePW 메소드 완료");
	}

}
