package global.sesoc.sample;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 메인 화면으로 이동하는 요청 처리
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(
			@RequestParam(value = "errMsg", defaultValue = "") String errMsg) {
		logger.info("메인 화면으로 이동");
		if (errMsg != null) {
			logger.info("에러 있나 {}",errMsg);
		}
		return "home";
	}
	
	@RequestMapping(value = "iftest", method = RequestMethod.GET)
	public String iftest() {
		return "board/iftest";
	}
}
