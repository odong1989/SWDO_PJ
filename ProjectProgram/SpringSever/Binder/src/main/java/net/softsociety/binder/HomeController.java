package net.softsociety.binder;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.softsociety.binder.util.PageNavigator;
import net.softsociety.binder.vo.MailVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.core.io.FileSystemResource;
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



@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private JavaMailSenderImpl mailSender;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(@RequestParam(value = "to",defaultValue="a")String to) {
		logger.info("대문 접속");
		
		if (!to.equals("a")) {
			MailVO vo = new MailVO("binder.send@gmail.com", "jsh4646@naver.com", "Binder 초대메시지입니다.", "ㅋㅋ 힝 속았징");
			vo.setTo(to);
			final MimeMessagePreparator preparator = new MimeMessagePreparator() {
				@Override
				public void prepare(MimeMessage mimeMessage) throws Exception {
					final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					helper.setFrom(vo.getFrom());
					helper.setTo(vo.getTo());
					helper.setSubject(vo.getSubject());
					helper.setText(vo.getContents(), true);
				}
			};
			mailSender.send(preparator);
			logger.info("메일전송완료");
		}
		
		
		return "index";
	}

	
	@RequestMapping(value = "/sendMail.do")
	public String sendMail(final MailVO vo) {
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				helper.setFrom(vo.getFrom());
				helper.setTo(vo.getTo());
				helper.setSubject(vo.getSubject());
				helper.setText(vo.getContents(), true);
			}
		};
		mailSender.send(preparator);
		return "result";
	}

	//2.2로그인 
	//0.dao선언
	@Autowired
	MemberDAO dao;
	@RequestMapping(value="memberLoginExe", method=RequestMethod.POST)
	public String memberLoginExe(Member member, String remember,HttpSession session, HttpServletResponse response,Model model) {
		logger.info("HomeController-memberLoginExe 로그인 프로세스 시작");
		String errMsg = "";//에러메시지 출력위한 변수.
		
		Member newMember = dao.memberSelectOne(member.getMember_id());
		logger.info("로그인 프로세스 DB의 저장계정값 newMember : {}",newMember);
		
		if(newMember != null  && newMember.getMember_wdraw()==0) {
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
				logger.info("memberLoginExe.java - 비밀번호가 틀렸습니다");
				model.addAttribute("errMsg",errMsg);
				return "redirect:/";
			}
		}else {//ID가 틀린경우 실시.
			errMsg="가입되지 않은 ID입니다.";
			logger.info("memberLoginExe.java - 가입되지 않은 ID입니다. 라고 출력을 한다.");
			model.addAttribute("errMsg",errMsg);
			return "redirect:/";
		}
		logger.info("memberLoginExe 로그인 프로세스 페이지 이동");
		return "redirect:/document/mainDocument";
	}
}
