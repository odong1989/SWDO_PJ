package net.softsociety.binder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
=======

>>>>>>> 브랜치_지혜
import net.softsociety.binder.util.PageNavigator;



@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		logger.info("대문 접속");
		return "index";
	}
}