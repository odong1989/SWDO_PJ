package com.boseong.swdo3th.Controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boseong.swdo3th.DAO.MemberDAO;
import com.boseong.swdo3th.VO.Member;

//@선언
@Controller
@RequestMapping(value="member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	//0.dao선언
	@Autowired
	MemberDAO dao;
	
	//1.회원가입================================================================================
	//1.1[이동] 회원가입폼으로 이동.
	@RequestMapping(value="memberJoinForm", method=RequestMethod.GET)
	public String memberJoinForm(HttpServletRequest request, Model model)
	{	
		return "/member/memberJoinForm";
	}
	
	//1.2[이동] ID중복체크 폼으로 이동
	@RequestMapping(value="memberidCheckForm", method=RequestMethod.GET)
	public String memberidCheckForm(Model model) {
		logger.info("아이디 중복 체크 폼 이동 ");
		boolean checkFlag = false;
		model.addAttribute("checkFlag", checkFlag);
		return "member/memberIdCheckForm";
	}
	
	//1.3[실행] 회원가입ID중복확인 실시
	@RequestMapping(value="/memberIdCheck", method=RequestMethod.GET)
	public String memberIdCheck(String checkId, Model model) {
		logger.info("checkId : {} ",checkId);

		Member member = dao.memberSelectOne(checkId);

		boolean checkFlag = true;
		logger.info("member : {} ",member);
		model.addAttribute("member", member);
		model.addAttribute("checkId", checkId); 
		model.addAttribute("checkFlag", checkFlag);
		
		return "member/memberIdCheckForm";
	}	

	//1.4[실행] 회원가입실시
	@RequestMapping(value="memberJoin", method=RequestMethod.POST)
	public String memberJoin(Member member) {
		logger.info("회원가입 자료 전달");
		logger.info("member : {}",member);
		dao.memeberJoin(member);
		
		return "redirect:/";
	}
	
	//2.로그인===================================================================================
	
	//2.1로그인폼 페이지 이동 + 쿠키(rId)확인하여 자동로그인
	@RequestMapping(value="memberLoginForm", method=RequestMethod.GET)
	public String memberLoginForm(HttpServletRequest request, Model model)
	{
		Cookie[] cookies = request.getCookies();
	    String rememberId=null;
	    if(cookies != null)
	    {
			for(Cookie c : cookies)
			{//"rId"라는 이름의 쿠키가 있는지를 확인해야 합니다.
				String name = c.getName();
				if(name.equals("rId")) 
				{//로그인 성공시의 계정을 rememberId에게 저장시킵니다.
					rememberId=c.getValue();
				}
			}
		}
		model.addAttribute("rememberId", rememberId);
		return "member/memberLoginForm";
	}
	
	//2.2로그인 
	@RequestMapping(value="memberLoginExe", method=RequestMethod.POST)
	public String memberLoginExe(Member member, String remember,HttpSession session, HttpServletResponse response,Model model) {
		logger.info("로그인 프로세스 시작");
		String errMsg = "";//에러메시지 출력위한 변수.
		
		Member newMember = dao.memberSelectOne(member.getMember_id());
	
		if(newMember != null) {
			logger.info("로그인 프로세스 DB의 저장계정값 newMember : {}",newMember);
			logger.info("로그인 프로세스  사용자의 로그인 정보member : {}",member);
			if(member.getMember_pw().equals(newMember.getMember_pw())) {
				session.setAttribute("loginId", member.getMember_id());
				logger.info("로그인 프로세스 - 성공함. 세션 설정 session : {}",session.getAttribute("loginId"));
				
				if(remember !=null && remember.equals("1")){
					Cookie cookie = new Cookie("rId", member.getMember_id());
					cookie.setMaxAge(60*60*24*365);
					//expiry 파라미터 : 초단위로 저장할 시간을 설정합니다.(int형으로 파라미터 입력받음)
					//60초*60분(1시간)*24시간(1일)*365일 = 1년동안 유지
					response.addCookie(cookie);//response에게 저장할 값을 주어 사용자의 컴퓨터에게 저장하도록 합니다.
				}
			}
			else {//PW가 틀린경우 실시
				errMsg="비밀번호가 틀렸습니다";
				model.addAttribute("errMsg",errMsg);
				return "member/memberLoginForm";
			}
		}else {//ID가 틀린경우 실시.
			errMsg="ID가 틀렸습니다";
			model.addAttribute("errMsg",errMsg);
			return "member/memberLoginForm";
		}
		
		return "redirect:/";
	}
	
	
	//2.3 인터셉션(로그인X상태서 로그인창으로 자동이동)
	@RequestMapping(value="memberLoginAlertPopup", method=RequestMethod.GET)
	public String memberLoginAlertPopup(HttpSession session) {
		logger.info("로거 memberLoginAlertPopup");
		return "member/interceptPopup";
	}
	
	//3.로그아웃===========================================================================================================
	@RequestMapping(value="/memberLogout", method=RequestMethod.GET)
	public String memberLogout(HttpSession session) {
	//세션에 로그읺 할 때 저장했던 값을 지우는 일.	
		logger.info("로그아웃 프로세스 시작");
		session.removeAttribute("loginId");
		logger.info("로그아웃 프로세스 - session의 loginId : {}",session.getAttribute("loginId"));
		return "redirect:/";
	}	
	
	
	//4.MyPage============================================================================================================
	//4.1 마이페이지 이동&계정정보 수신
	@RequestMapping(value="memberMypage", method=RequestMethod.GET)
	public String memberMypage(Member member, String remember,HttpSession session,Model model) {
		logger.info("마이페이지 프로세스 시작");
		Member MemberData = dao.memberSelectOne((String)session.getAttribute("loginId"));
		model.addAttribute("MemberData", MemberData);
		return "/member/memberMypage";
	}		
	
	//4.2 마이페이지-이름변경(#aJax활용할것!)
	@RequestMapping(value="MypageChangeName", method=RequestMethod.POST, produces = "application/text; charset=utf8") 
	@ResponseBody
	public String MypageChangeName(Member member,HttpSession session) {
		logger.info("마이페이지-이름변경 ajax실시");
		member.setMember_id((String)session.getAttribute("loginId"));
		logger.info("member : {}", member);
		dao.memberUpdateName(member);
		String changedName = member.getMember_nm();
		return changedName ;
	}			
	
	
	//4.2 마이페이지-주소변경(#aJax활용할것!)
	@RequestMapping(value="MypageChangeAddress", method=RequestMethod.POST, produces = "application/text; charset=utf8") 
	// produces = "application/text; charset=utf8" utf-8로 인코딩하여 한글이 ???식으로 뜨는 것을 방지./ 출처: https://marobiana.tistory.com/112 [Take Action]
	@ResponseBody
	public String MypageChangeAddress(Member member,HttpSession session) {
		logger.info("마이페이지-주소변경 ajax실시");
		member.setMember_id((String)session.getAttribute("loginId"));
		logger.info("member : {}", member);
		dao.memberUpdateAddress(member);
		String changedAddress = member.getMember_addr();
		return changedAddress ;
	}			
	
	//4.3비밀번호 변경
	@RequestMapping(value="memberMypageChangePwForm", method=RequestMethod.GET)
	public String memberMypageChangePwForm() {
		logger.info("비밀번호 변경페이지 이동");
		return "/member/memberMypageChangePwForm";
	}	
	
	//4.3비밀번호 변경
	@RequestMapping(value="memberMypageChangePassword", method=RequestMethod.POST)
	public String memberMypageChangePassword(Member member,HttpSession session) {
		logger.info("비밀번호 변경 시작");
		member.setMember_id((String)session.getAttribute("loginId"));
		logger.info("member : {}", member);
		dao.memberUpdatePassword(member);

		return "/member/memberMypage";
	}		
	
}