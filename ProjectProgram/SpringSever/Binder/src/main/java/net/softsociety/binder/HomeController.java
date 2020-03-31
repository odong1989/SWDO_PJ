package net.softsociety.binder;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Random;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.softsociety.binder.util.PageNavigator;
import net.softsociety.binder.vo.MailVO;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;

import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.core.io.FileSystemResource;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private JavaMailSenderImpl mailSender;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(@RequestParam(value = "to",defaultValue="a")String to) {
		logger.info("대문 접속");
		String currDir = HomeController.class.getResource(".").getPath();
		logger.info(currDir);
		
		return "index";
	}
	
	@RequestMapping(value = "/sendMail.do")
	public String sendMail(final MailVO vo) {
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				helper.setFrom(vo.getFrom());
				helper.setTo(vo.getTo());
				helper.setSubject(vo.getSubject());
				helper.setText(vo.getContents(), true);
			}
		};
		mailSender.send(preparator);
		return "result";
	}
}
