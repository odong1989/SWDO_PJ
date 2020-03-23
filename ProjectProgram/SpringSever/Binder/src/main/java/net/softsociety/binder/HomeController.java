package net.softsociety.binder;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

<<<<<<< HEAD:ProjectProgram/SpringSever/BsNoticeBoard/src/main/java/com/boseong/swdo3th/HomeController.java
import com.boseong.swdo3th.util.PageNavigator;
=======
import net.softsociety.binder.dao.BoardDAO;
import net.softsociety.binder.util.PageNavigator;
import net.softsociety.binder.vo.Board;
>>>>>>> 브랜치_지혜:ProjectProgram/SpringSever/Binder/src/main/java/net/softsociety/binder/HomeController.java

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		logger.info("메인페이지 시작");
		return "index";
	}
	
}
