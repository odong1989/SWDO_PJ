package net.softsociety.binder.dao;

import net.softsociety.binder.vo.Member;

public interface MemberMapper {
	
	public Member memberSelectOne (String member_id);
	public Member memberSelectOne2 (Member member);	
	//비번,ID 수정위해 2개 이상의 값을 갖고 오기 위해 변경.
	//public Member memberSelectOne (String member_id);를 대체 할필요성 논의 할것.
	
	public int	  memeberJoin(Member member);
	public void   memberUpdate(Member member);

	public void   memberWdraw(String member_id);
	
	//마지막 로그인 시간 업데이트
	public void memberLastLoginTime(String member_id);
}
