package global.sesoc.sample.dao;

import global.sesoc.sample.vo.Member;

public interface MemberMapper {
	
	public Member memberSelectOne(String member_id);
	
	public int memberJoin(Member member);
	
	public String nameCheck(String member_id);
}
