package global.sesoc.sample.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.sample.dao.MemberDAO;
import global.sesoc.sample.vo.Member;

/**
 * 사용자 입력을 받아 처리
 */
@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@RequestMapping(value="/memberJoinForm", method=RequestMethod.GET)
	public String memberJoinForm() {
		logger.info("멤바조인폼");
		return "member/memberJoinForm";
	}
	
	@RequestMapping(value = "/memberIdCheckForm", method=RequestMethod.GET)
	public String memberIdCheckForm(Model model) {
		logger.info("아이디췍폼");
		boolean checkFlag = false;
		model.addAttribute("checkFlag", checkFlag);
		return "member/memberIdCheckForm";
	}
	
	@RequestMapping(value = "/memberIdCheck", method=RequestMethod.POST)
	public String memberIdCheck(String checkId, Model model) {
		logger.info("아이디췍({})",checkId);
		Member member = dao.memberSelectOne(checkId);
		logger.info("아이디있나?({})",member!=null);
		boolean checkFlag = true;
		model.addAttribute("checkId", checkId);
		model.addAttribute("member", member);
		model.addAttribute("checkFlag", checkFlag);
		return "member/memberIdCheckForm";
	}
	
	
	@RequestMapping(value = "/memberJoin", method=RequestMethod.POST)
	public String memberJoin(Member member) {
		logger.info("회원가입 시작({})",member);
		int result = dao.memberJoin(member);
		if (result < 1) {
			logger.info("회갑실패({})",result);
		} else {
			logger.info("회갑성공({})",result);
		}
		return "home";
	}
	
	@RequestMapping(value = "/memberLoginForm", method=RequestMethod.GET)
	public String memberLoginForm(HttpServletRequest request, Model model) {
		logger.info("로그인하러 이동");
		Cookie[] cookies = request.getCookies();
		String rememberId = null;
		if(cookies != null) {
			for(Cookie c : cookies) {
				String name = c.getName();
				if(name.equals("rId")) {
					rememberId = c.getValue();
				}
			}
		}
		model.addAttribute("rememberId", rememberId);
		logger.info("로그인 완료 (rememberId : {})",rememberId);
		return "member/memberLoginForm";
	}
	
	@RequestMapping(value = "/memberLogin", method=RequestMethod.POST)
	public String memberLogin(Member member, String remember
			, HttpSession session, HttpServletResponse response, Model model
			, @RequestParam(value = "target", defaultValue = "false") String target) {
		logger.info("memberLogin target값 : {}",target);
		String move = null;
		if (target.equals("false")) {
			move = "/member/memberLoginForm";
		} else {
			move = target;
		}
		//저장된 세션 제거(로그아웃)
		session.removeAttribute("loginId");
		session.removeAttribute("loginName");
		
		//전달받은 ID와 PW를 가지고 DB로 이동해서
		//실제 정보와 비교해서 정확한 내용인지 파악
		//select 쿼리를 실행, 결과가 있으면 로그인 처리
		//결과가 null이면 로그인x
		String errMsg = null;
		Member newMember = dao.memberSelectOne(member.getMember_id());
		if(newMember != null) {
			if(member.getMember_pw().equals(newMember.getMember_pw())) {
				//정확하다고 판단되면 로그인 처리
				//세션에 아이디, 이름을 저장
				session.setAttribute("loginId", member.getMember_id());
				session.setAttribute("loginName", newMember.getMember_nm());
				//이때 체크박스가 체크되어 있었다면 ID를 기억
				if(remember != null && remember.equals("1")) {
					//로그인 아이디용 쿠키
					Cookie cookie = new Cookie("rId", member.getMember_id());
					cookie.setMaxAge(60*60*24*7);
					response.addCookie(cookie);
				}
			} else {
				//비번 틀림
				errMsg = "비번 에러";
				model.addAttribute("errMsg", errMsg);
				logger.info("비번 에러({})",errMsg);
				return "redirect:"+move;
			}
		} else {
			//아이디 없거나 틀림
			errMsg = "아디틀림";
			//model.addAttribute("errMsg", errMsg);
			logger.info("아뒤 에러({})",errMsg);
			return "redirect:"+move+"&errMsg="+errMsg;
		}
		
		if(!target.equals("false")) {
			logger.info("로그인 후 {}으로 이동",move);
		}
		return "redirect:"+move;
		//세션, 쿠키에 데이터를 저장하기 때문에 redirect 하자
	}
	
	@RequestMapping(value = "/memberLogout", method=RequestMethod.GET)
	public String memberLogout(HttpSession session
			, @RequestParam(value="target", defaultValue ="")String target) {
		//세션에 있는 아이디정보 삭제
		session.removeAttribute("loginId");
		session.removeAttribute("loginName");
		if (target != "" && target != null) {
			logger.info("로그아웃 후 {}으로 이동");
			return "redirect:"+target;
		}
		logger.info("로갓");
		return "redirect:/";
	}
}
