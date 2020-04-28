package net.softsociety.binder.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.softsociety.binder.dao.MemberDAO;
import net.softsociety.binder.util.FileService;
import net.softsociety.binder.vo.MailVO;
import net.softsociety.binder.vo.Member;
import net.softsociety.binder.vo.Photo;

//@선언
@Controller
@RequestMapping(value="loginAndJoin/")
public class loginAndJoinController {
	
	private static final Logger logger = LoggerFactory.getLogger(loginAndJoinController.class);
	  private final String uploadPath = "/uploadFile";
	//0.dao선언
	@Autowired
	MemberDAO dao;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	//1.회원가입================================================================================
	//1.1[이동] 회원가입폼으로 이동.
	@RequestMapping(value="memberJoinForm", method=RequestMethod.GET)
	public String memberJoinForm(HttpServletRequest request, Model model)
	{	
		logger.info("memberJoinForm폼 이동 ");
		return "loginAndJoin/joinForm";
		
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
	@RequestMapping(value="/memberIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public boolean memberIdCheck(@RequestBody Member member, Model model) {
		logger.info("중복체크 : {}",member);
		boolean str = true;
		Member result = dao.memberSelectOne(member.getMember_id());
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
	public String memberJoin(Member member, MultipartFile upload) {
		Photo photo = new Photo();
		logger.info("memberJoin메소드입니다. 회원가입 자료 전달받고 실시");
		logger.info("form을 통해 기입된 member 정보 : {}",member);
		logger.info("form을 통해 기입된 첨부사진(upload) 정보 : {}",upload);
		
		
		logger.info("memberJoin메소드-프로필 사진 업로드 시작");		
        if(!upload.isEmpty()) { //1.파일업로드 체크 / .isEmpty() : 객체가 비었냐(=파일없냐?)
            //2.업로드된 파일의 경로(파일명)을 VO에게 설정(set)
            String savedfile = FileService.saveFile(upload, uploadPath, "profile", 0, 0);            
            photo.setPhoto_savedfile(savedfile);//DB가 사용한 파일의 별명
            photo.setPhoto_originfile(upload.getOriginalFilename());//원본 파일명
            member.setMember_photo(photo.getPhoto_savedfile());            
    		logger.info("member의 사진 정보(최종) : {}",member.getMember_photo());
        }
        // 3.VO를 DB에 INSERT
        int count = dao.memeberJoin(member);
        logger.info("3.VO를 DB에 INSERT count : {}",count);
        if(count ==0) {
            logger.info("회원등록이 실패되었습니다.");
        	}
		return "redirect:/";
	}
	
	//2.비밀번호 아이디 찾기 및 비밀번호 재설정 페이지
	//2.1 아이디/비밀번호 찾기 페이지로 이동
	@RequestMapping(value="memberFind", method=RequestMethod.GET)
	public String memberFind() {
		logger.info("memberFind페이지로 이동 실시");
	return "loginAndJoin/memberFind";
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
			model.addAttribute("resultMemberData", resultMemberData.getMember_id() );//id만 리턴한다.
	      	return "/loginAndJoin/memberFind";		
		}
		else
		{
			logger.info("memberFindId-없는 것으로 확인됨. forgetMemberID정보 : {}",forgetMemberID);
			errMsg="등록되지 않은 ID입니다.";
			model.addAttribute("errMsg", errMsg);
		    return "/loginAndJoin/memberFind";		
		}	
	}
	
	//2.3 비밀번호 재설정 페이지 이동
	@RequestMapping(value="memberFindPassword", method=RequestMethod.POST)
	public String memberFindPassword(Member forgetMember, Model model) {
		//forgetMemberPW : 비밀번호를 잊은 고객이 비번수정을 위해 자신의 이름,계정을 입력한 것.
		logger.info("memberFindPassword 메소드 실시");
		logger.info("memberFindId-사용자가 PW찾기 위해 입력한 정보 forgetMember : {}",forgetMember);
		String errMsg = "";   //실행결과또는 에러를 알리기위한 메시지 변수
		StringBuffer temp = new StringBuffer();
		
		Member updateMemberData = dao.memberSelectOne3(forgetMember);

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
				logger.info("코드 생성완료. 코드 : {}", temp);
				
				String tempPW = null; //생성된 코드를 저장
				tempPW = temp.toString();
				
				updateMemberData.setMember_pw(tempPW);
				
				dao.memberUpdatePW(updateMemberData);
				logger.info("DB에 수정된 비밀번호 : {}", updateMemberData.getMember_pw());	
				
								
					MailVO vo = new MailVO();
//					vo.setTo("사용자의 이메일");
					vo.setTo(updateMemberData.getMember_mail());
					logger.info("vo의 수신자(to) : {}",vo.getTo());
					vo.setContents(tempPW + "로 변경되었습니다.");
					vo.setSubject("비밀번호가 변경되었습니다. - Binder");
					vo.setFrom("Binder");
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
					errMsg="메일이 발송되었습니다.메일에 첨부된 임시번호를 확인하세요";
			      	model.addAttribute("errMsg", errMsg);
					logger.info("message : {}",model);
			      	return "index";			
			}
		else
			{
				errMsg="일치하는 계정이 없습니다.이름과 ID를확인해주세요.";
				model.addAttribute("errMsg", errMsg);
		      	return "/loginAndJoin/memberFind";
			}
		}
	
	@RequestMapping(value="needLogin", method=RequestMethod.GET)
	public String neddLogin()
	{	
		return "needLogin";
		
	}
}	