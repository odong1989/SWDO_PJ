package net.softsociety.binder.controller;

import java.util.ArrayList;

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

import net.softsociety.binder.dao.GroupDAO;
import net.softsociety.binder.dao.MemberDAO;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.Member;

//@선언
@Controller
@RequestMapping(value="member/")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	//0.dao선언
	@Autowired
	MemberDAO memdao;
	@Autowired
	GroupDAO groupdao;
	
	//1.회원가입================================================================================
	//1.1[이동] 회원가입폼으로 이동.
	@RequestMapping(value="memberJoinForm", method=RequestMethod.GET)
	public String memberJoinForm(HttpServletRequest request, Model model)
	{	
		logger.info("memberJoinForm폼 이동 ");
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
//	@RequestMapping(value="/memberIdCheck", method=RequestMethod.GET)
//	public String memberIdCheck(String checkId, Model model) {
//		logger.info("memberIdCheck메소드 실행. ");
//		logger.info("checkId : {} ",checkId);
//		
//		Member member = memdao.memberSelectOne(checkId);
//		
//		boolean checkFlag = true;
//		logger.info("member : {} ",member);
//		model.addAttribute("member", member);
//		model.addAttribute("checkId", checkId); 
//		model.addAttribute("checkFlag", checkFlag);
//		
//		return "member/memberIdCheckForm";
//	}	
	
	@RequestMapping(value="/memberIdCheck", method=RequestMethod.GET)
	@ResponseBody
	public boolean memberIdCheck(Member member, Model model) {
		logger.info("중복체크 : {}",member);
		boolean str = true;
		Member result = memdao.memberSelectOne(member.getMember_id());
		logger.info("{}",result);
		if (result != null) {
			//이미 사용중인 값이 있다.
			str = false;
			logger.info("false 돌려줌");
			return str;
		} else {
			//사용중이지 않다.
			str = true;
			logger.info("true 돌려줌");
			return str;
		}
	}	
	

	//1.4[실행] 회원가입실시
	@RequestMapping(value="memberJoin", method=RequestMethod.POST)
	public String memberJoin(Member member) {
		logger.info("memberJoin메소드입니다");
		logger.info("회원가입 자료 전달");
		logger.info("member : {}",member);
		member.setMember_birthday("20-04-03");
		memdao.memeberJoin(member);
		
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
	public String memberLoginExe(Member member, HttpSession session, Model model) {
		logger.info("로그인 시도 : {}", member);
		String errMsg = "";//에러메시지 출력위한 변수.
		Member newMember = memdao.memberSelectOne(member.getMember_id());
		
		//ID가 있는 경우
		if(newMember != null) {
			//비밀번호 일치
			if(member.getMember_pw().equals(newMember.getMember_pw())) {
				session.setAttribute("loginId", member.getMember_id());
				logger.info("-성공. 세션 설정 session : {}",session.getAttribute("loginId"));
			} 
			//비밀번호 불일치
			else {
				errMsg="비밀번호가 틀렸습니다";
				model.addAttribute("errMsg",errMsg);
				return "index";
			}
		//ID가 없는 경우
		}else {
			errMsg="존재하지 않는 ID입니다.";
			model.addAttribute("errMsg",errMsg);
			return "index";
		}
		logger.info("-메인페이지로 이동");
		return "redirect:/document/mainDocument";
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
		
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Group> groupJoinList = groupdao.selectGroupJoin(member_id);
		logger.info("-그룹리스트 : {}", groupJoinList);
		model.addAttribute("groupJoinList", groupJoinList);
		
		Member MemberData = memdao.memberSelectOne((String)session.getAttribute("loginId"));
		model.addAttribute("MemberData", MemberData);
		return "member/memberMypage";
	}		
	
	@RequestMapping(value="mypageUpdateProfile", method=RequestMethod.GET)
	public String mypageUpdateProfile(HttpSession session,Model model) {
		logger.info("회원정보 수정페이지로 이동");
		logger.info("memberUpdateExe- 현 로그인 인물 (session세션)",session.getAttribute("loginId"));
		Member MemberData = memdao.memberSelectOne((String)session.getAttribute("loginId"));
		model.addAttribute("MemberData", MemberData);
		return "member/mypageUpdateProfile";
	}	
	
		
	@RequestMapping(value="memberUpdateExe", method=RequestMethod.POST)
	public String memberUpdateExe(Member updateMemberData, HttpSession session, Model model) {
		logger.info("memberUpdateExe 업데이트 실시");
		logger.info("memberUpdateExe- 현 로그인 인물 (session세션) : {} ",session.getAttribute("loginId"));
		String errMsg = "";//에러메시지 출력위한 변수.
		
		updateMemberData.setMember_id((String)session.getAttribute("loginId"));
		logger.info("memberUpdateExe-업데이트할 계정 정보 :{}",updateMemberData);
		
		
		memdao.memberUpdate(updateMemberData);
		logger.info("memberUpdateExe-업데이트결과 계정 정보 :{}",memdao.memberSelectOne((String)session.getAttribute("loginId")));
		
		logger.info("-메인페이지로 이동");
		return "redirect:/document/mainDocument";
	}

}