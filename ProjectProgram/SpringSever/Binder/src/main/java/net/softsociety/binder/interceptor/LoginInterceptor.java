package net.softsociety.binder.interceptor;

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
		logger.debug("LoginInterceptor 시작");

		HttpSession session = request.getSession();
	
		//URL 확보
		String uri = request.getRequestURI();
		//쿼리스트링 확보
		String qrString = request.getQueryString();
		
		String movePage = "";
		
		String loginId = (String)session.getAttribute("loginId"); 
		logger.debug("loginId : {}",loginId);

		if(loginId == null) {
			if(qrString != null) {
				movePage += uri + "?" +qrString;
			} else {
				movePage += uri;
			}
			session.setAttribute("movePage", movePage);
			response.sendRedirect(request.getContextPath() + "/loginAndJoin/needLogin");
			
			return false;
		}
		
		return true;
	}
}
