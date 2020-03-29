package net.softsociety.binder.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {
		logger.info("LoginInterceptor 시작");
		String errMsg = "";//에러메시지 출력위한 변수.
		Model model=null;
		HttpSession session = request.getSession();
		logger.info("LoginInterceptor session: {}", session.toString());
	
		String loginId = (String)session.getAttribute("loginId"); 
		logger.info("LoginInterceptor loginId : {}",loginId);


		if(loginId == null) {
			logger.info("LoginInterceptor loginId값 null인 경우 실시");
			errMsg="로그인이 필요한 페이지입니다.";
		//	model.addAttribute("errMsg",errMsg); //에러문쿠 출력 위해 써보려고 하였으나 문법에러(500번에러) 발생.
			response.sendRedirect(request.getContextPath() + "/");
			logger.info("LoginInterceptor - 인터셉터 실시. index(로그인 전페이지)로 이동합니다.");
			return false;
		}
		
		return true;
	}
}
