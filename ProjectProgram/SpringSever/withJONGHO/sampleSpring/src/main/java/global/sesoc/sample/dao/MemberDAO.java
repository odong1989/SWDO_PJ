package global.sesoc.sample.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.sample.vo.Member;

/**
 * 개인정보 관련 DB처리를 담당
 */
@Repository
public class MemberDAO {
	@Autowired
	private SqlSession session;

	private Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	public Member memberSelectOne(String member_id) {
		logger.info("셀렉트원({})", member_id);
		Member member = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.memberSelectOne(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
	public int memberJoin(Member member) {
		logger.info("멤버조인({})", member);
		int result = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			result = mapper.memberJoin(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String nameCheck(String member_id) {
		logger.info("이름 체크 시도({})", member_id);
		String member_nm = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member_nm = mapper.nameCheck(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member_nm;
	}
}
