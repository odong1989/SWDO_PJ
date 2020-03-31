package net.softsociety.binder.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

//@선언
@Controller
public class uploadTest {

	private static final Logger logger = LoggerFactory.getLogger(uploadTest.class);

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public ModelAndView test(HttpServletRequest request) 
	{
		Set pathSet = request.getSession().getServletContext().getResourcePaths("/");
		System.out.println(pathSet);	
		return null;
	}

	@RequestMapping(value = "/test2", method = RequestMethod.GET)
	public ModelAndView test2(HttpServletRequest request) 
	{
//		Set pathSet = request.getSession().getServletContext().getResourcePaths("/");
//		System.out.println(pathSet);	
		logger.info("zzzzzzzzzzzzzzzzzz");
		String pdfPath = request.getSession().getServletContext().getRealPath("/resources/2020TOMATO会社説明資料.pdf");
		logger.info("pdfPath : {}",pdfPath);
		System.out.println(new File(pdfPath).exists());	
		return null;
	}
	
}