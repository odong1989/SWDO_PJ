package net.softsociety.binder.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.softsociety.binder.dao.DocumentDAO;
import net.softsociety.binder.dao.GroupJoinDAO;
import net.softsociety.binder.vo.Document;
import net.softsociety.binder.vo.GroupJoin;

//@선언
@Controller
@RequestMapping(value="calender")
public class CalenderController {

	
	@Autowired DocumentDAO documentDao;
	@Autowired GroupJoinDAO groupJoinDao;
	private static final Logger logger = LoggerFactory.getLogger(CalenderController.class);

	@RequestMapping(value="calenderMain", method=RequestMethod.GET)
	@ResponseBody
	public ArrayList<HashMap<String, Object>> calenderMain(String group_no ,HttpSession session)
	{	
		//logger.info("calenderMain 캘린더 jsp페이지로 이동  실시.");
		//목표 : 사용자의 소속된 그룹된 관련된 스케쥴(Document들)을 모두 로드 해야 한다.

		//스텝1 : 정상적으로 값 수신되었는지 확인.
		logger.info("calenderMain -로그인 세션 확인    :{}", (String) session.getAttribute("loginId"));
		logger.info("calenderMain -그룹번호확인 - group_no : {}", Integer.parseInt(group_no));

		//스텝2 :	DocumentDAO에서 아래의 메소드를 활용한다.
		// public ArrayList<HashMap<String, Object>> selectDocumentsForCalendar(GroupJoin groupCal);
		GroupJoin groupCal = new GroupJoin();
		groupCal.setMember_id((String) session.getAttribute("loginId"));
		groupCal.setGroup_no(Integer.parseInt(group_no));
		logger.info("calenderMain -GroupJoin groupCal : {}",groupCal);
		
		ArrayList<HashMap<String, Object>> documentList = null;
		documentList = documentDao.selectDocumentsForCalendar(groupCal);
		logger.info("calenderMain 캘린더 위해 리턴하는 값 : {}",documentList);
		
		return documentList;
		//return "/calender/calenderMain"; //선생님의 조언에 따라 데이터를 직통으로 리턴하는 것으로 변경.
	}	
	
	
	@RequestMapping(value="getUserSchedule", method=RequestMethod.POST)
	@ResponseBody
	public String getUserSchedule(String group_no ,HttpSession session, Model model)
	{	
		logger.info("getUserSchedule- json으로 ");
		logger.info("getUserSchedule -로그인 세션 확인    :{}", (String) session.getAttribute("loginId"));
//		logger.info("calenderMain -그룹번호확인 - group_no : {}", Integer.parseInt(group_no));

		//[SKIP]스텝2 : groupJoinDao.selectGroupJoinMember()를 통하여 소속한 그룹의 정보를 받는다.
		/*당장은 불필요하다고 판단되어 일단 넘김.(#Not Null때문에 열심히 만드는데 생각해보니 그건 SQL생성시의 중요사항이었다...-_-;
		GroupJoin vo = null; 
		ArrayList<GroupJoin> groupJoinDataOne = null; // 
		
		groupJoinData = groupJoinDao.selectGroupJoinMember(vo);
		logger.info("calenderMain 사용자가 가입한 그룹정보(멤버레벨까지받았는지 확인!): {}", groupJoinData);
		*/
		//회원의 등급에 따라 가져올 수 있는 글을 제어하는 조건도 생성될거 같음.
		
		/*[SKIP]스텝3 : DocumentDAO의
		  	    public ArrayList<HashMap<String, Object>> selectDocumentsForCalendar(GroupJoin groupCal);
		 		메소드를 통하여 해당 그룹의 document들을 갖고 온다.
		 		도규먼트들이 갖고 있는 시작일, 종료일 칼럼등을 값을 활용하여 캘린더의CSS를 활용해 
		 		캘린더에 표현되도록 하고자 한다. 
		//documentDao.selectDocumentsForCalendar(Integer.parseInt(group_no));
		 */
		
		
		//스텝2 :	DocumentDAO에서 아래의 메소드를 활용한다.
		// public ArrayList<HashMap<String, Object>> selectDocumentsForCalendar(GroupJoin groupCal);
		GroupJoin groupCal = new GroupJoin();
		groupCal.setMember_id((String) session.getAttribute("loginId"));
//		groupCal.setGroup_no(Integer.parseInt(group_no));
		logger.info("calenderMain -GroupJoin groupCal : {}",groupCal);
		
		ArrayList<HashMap<String, Object>> documentList = null;
		documentList = documentDao.selectDocumentsForCalendar(groupCal);
		logger.info("calenderMain - 리턴해줄 일정(document)들 : {}",documentList);

		model.addAttribute("documentList",documentList);
		
		return "response";
	}	
}