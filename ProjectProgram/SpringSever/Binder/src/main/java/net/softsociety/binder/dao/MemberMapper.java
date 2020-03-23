package net.softsociety.binder.dao;

import net.softsociety.binder.vo.Member;

public interface MemberMapper {
	
	public Member memberSelectOne (String member_id);
	public int	  memeberJoin(Member member);
	public void   memberUpdateName(Member member);
	public void   memberUpdateAddress(Member member);
	public void   memberUpdatePassword(Member member);
}
