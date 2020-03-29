package net.softsociety.binder.controller;

import java.util.Random;

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

import net.softsociety.binder.dao.MemberDAO;
import net.softsociety.binder.vo.Member;

//@선언
@Controller
@RequestMapping(value="loginAndJoin/")
public class loginAndJoinController {
	
	private static final Logger logger = LoggerFactory.getLogger(loginAndJoinController.class);
	
	//0.dao선언
	@Autowired
	MemberDAO dao;
	
	//1.회원가입================================================================================
	//1.1[이동] 회원가입폼으로 이동.
	@RequestMapping(value="memberJoinForm", method=RequestMethod.GET)
	public String memberJoinForm(HttpServletRequest request, Model model)
	{	
		logger.info("memberJoinForm폼 이동 ");
		return "/loginAndJoin/memberJoinForm";
		
	}
	
	//1.2[이동] ID중복체크 폼으로 이동
	@RequestMapping(value="memberidCheckForm", method=RequestMethod.GET)
	public String memberidCheckForm(Model model) {
		logger.info("아이디 중복 체크 폼 이동 ");
		boolean checkFlag = false;
		model.addAttribute("checkFlag", checkFlag);
		return "loginAndJoin/memberIdCheckForm";
	}
	
	//1.3[실행] 회원가입ID중복확인 실시
	@RequestMapping(value="/memberIdCheck", method=RequestMethod.GET)
	public String memberIdCheck(String checkId, Model model) {
		logger.info("memberIdCheck메소드 실행. ");
		logger.info("checkId : {} ",checkId);
		
		Member member = dao.memberSelectOne(checkId);

		boolean checkFlag = true;
		logger.info("member : {} ",member);
		model.addAttribute("member", member);
		model.addAttribute("checkId", checkId); 
		model.addAttribute("checkFlag", checkFlag);
		
		return "loginAndJoin/memberIdCheckForm";
	}	

	//1.4[실행] 회원가입실시
	@RequestMapping(value="memberJoin", method=RequestMethod.POST)
	public String memberJoin(Member member) {
		logger.info("memberJoin메소드입니다");
		logger.info("회원가입 자료 전달");
		logger.info("member : {}",member);
		dao.memeberJoin(member);
		
		return "redirect:/";
	}
	
	//2.비밀번호 아이디 찾기 및 비밀번호 재설정 페이지
	//2.1 아이디/비밀번호 찾기 페이지로 이동
	@RequestMapping(value="memberFindMyIDorPW", method=RequestMethod.GET)
	public String memberFindMyIDorPW() {
		logger.info("memberFindMyIDorPW페이지로 이동 실시");
	return "/loginAndJoin/memberFindMyIDorPW";
	}
	
	//2.2 아이디 찾기 메소드 실시&아이디 검색결과 출력페이지로 리턴(출력 방식은 memeberFindResultId.jsp페이지에서 리턴값에 따라 출력을 담당.)
	@RequestMapping(value="memberFindId", method=RequestMethod.POST)
	public String memberFindId(Member forgetMemberID, Model model) {
		logger.info("memberFindId 메소드 실시");

		Member resultMemberData = null; //memberSelectOne2메소드를 통해 찾은 계정의 ID정보를 입력.
		String errMsg = "";				//에러메시지 출력위한 변수.
	
		logger.info("memberFindId-사용자가 ID찾기 위해 입력한 정보 forgetMemberID : {}",forgetMemberID);
		resultMemberData = dao.memberSelectOne2(forgetMemberID);
		
		if(resultMemberData != null)
		{
			logger.info("memberFindId-존재확인&리턴될 resultMemberData정보 : {}",resultMemberData);
			model.addAttribute("resultMemberData", resultMemberData);
			return "/loginAndJoin/memberFindResultId";			
		}
		else
		{
			logger.info("memberFindId-없는 것으로 확인됨. forgetMemberID정보 : {}",forgetMemberID);
			errMsg="등록되지 않은 ID입니다.";
			model.addAttribute("errMsg", errMsg);
			return "/loginAndJoin/memberFindResultId";			
		}	
	}
	
	//2.3 비밀번호 재설정 페이지 이동
	@RequestMapping(value="memberFindPassword", method=RequestMethod.POST)
	public String memberFindPassword(Member forgetMemberPW, Model model) {
		//forgetMemberPW : 비밀번호를 잊은 고객이 비번수정을 위해 자신의 이름,계정을 입력한 것.
		logger.info("memberFindPassword 메소드 실시");
		logger.info("memberFindId-사용자가 PW찾기 위해 입력한 정보 forgetMemberPW : {}",forgetMemberPW);
		String errMsg = "";   //입력된 정보가 틀릴시 에러안내문구(에러메시지 출력위한 변수.)
		String introMsg ="가입하신 이메일로 비밀번호가 전송되었습니다."; //정상실행시 리턴
		StringBuffer temp = new StringBuffer();
		
		Member updateMemberData = dao.memberSelectOne2(forgetMemberPW);

		if(updateMemberData != null)
			{
				Random rnd = new Random();
				for (int i = 0; i < 8; i++) {
				    int rIndex = rnd.nextInt(3);
				    switch (rIndex) {
				    case 0:
				        // a-z
				        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				        break;
				    case 1:
				        // A-Z
				        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				        break;
				    case 2:
				        // 0-9
				        temp.append((rnd.nextInt(10)));
				        break;
				    }
				}
				logger.info("코드 생성완료 {}", temp);
				String tempPW = null; //생성된 코드를 저장
				tempPW = temp.toString();			
				updateMemberData.setMember_pw(tempPW);
				dao.memberUpdate(updateMemberData);
				model.addAttribute("resultMsg",errMsg);
				return "/loginAndJoin/memberFindMyIDorPW";			
			}
		else
			{
				errMsg="존재하지 ID입니다.";
				
				model.addAttribute("introMsg",introMsg);
				return "/loginAndJoin/memberFindMyIDorPW";
			}
		    
		}
	}	