package net.softsociety.binder.dao;

import net.softsociety.binder.vo.Member;

public interface MemberMapper {
	
	//1.회원가입------------------------------------
	public int	  memeberJoin(Member member);
	
	
	//2.회원검색
	public Member memberSelectOne (String member_id); //id확인에 사용
	public Member memberSelectOne2 (Member member);	  //memberVO속성 2개이상의 파라미터 받을시 사용.
	//비번,ID 수정위해 2개 이상의 값을 갖고 오기 위해 변경.
	//public Member memberSelectOne (String member_id);를 대체 할필요성 논의 할것.
	
	//3.업데이트
	//3.1 회원정보 수정
	public void   memberUpdate(Member member);

	//3.2 마지막 로그인 시간 업데이트
	public void memberLastLoginTime(String member_id);
	
	//3.3 회원탈퇴 처리
	public void   memberWdraw(String member_id);

}
