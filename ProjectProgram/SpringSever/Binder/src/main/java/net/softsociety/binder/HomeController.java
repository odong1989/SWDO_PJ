package net.softsociety.binder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
import net.softsociety.binder.util.PageNavigator;
=======

import net.softsociety.binder.util.PageNavigator;


>>>>>>> cce1670dee33611a30dbb79659ccac8fbcba5ef6
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		logger.info("메인페이지 시작");
		return "index";
	}
}