package com.boseong.swdo3th.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {
		logger.info("LoginInterceptor 시작");

		HttpSession session = request.getSession();
		logger.info("session: {}", session.toString());
	
		String loginId = (String)session.getAttribute("loginId"); 
		logger.info("loginId : {}",loginId);
		

		if(loginId == null) {
			response.sendRedirect(request.getContextPath() + "/member/memberLoginForm");
			return false;
		}
		
		return true;
	}
}
