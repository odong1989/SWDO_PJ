package net.softsociety.binder.controller;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//@선언
@Controller
@RequestMapping(value="calender")
public class CalenderController {

	private static final Logger logger = LoggerFactory.getLogger(CalenderController.class);
	@RequestMapping(value="calenderMain", method=RequestMethod.GET)
	public String calenderMain(HttpSession session )
	{	
		logger.info("calenderMain 캘린더 이동  실시.");
		String member_id = (String) session.getAttribute("loginId");
		logger.info("calender - member_id :{}",member_id);
		
		logger.info("각 일자에 따라 일정을 표기해줄 수 있어야 한다.");
		return "/calender/calenderMain";
		
	}	
}