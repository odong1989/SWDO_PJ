package net.softsociety.binder;
<<<<<<< HEAD
=======

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Random;

import javax.annotation.Resource;

>>>>>>> 브랜치_지혜
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
<<<<<<< HEAD
=======
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
>>>>>>> 브랜치_지혜
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

<<<<<<< HEAD

@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
=======
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private JavaMailSenderImpl mailSender;

>>>>>>> 브랜치_지혜
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(@RequestParam(value = "to",defaultValue="a")String to) {
		logger.info("대문 접속");
		
		if (!to.equals("a")) {
			StringBuffer temp = new StringBuffer();
			Random rnd = new Random();
			for (int i = 0; i < 5; i++) {
			    int rIndex = rnd.nextInt(3);
			    switch (rIndex) {
			    case 0:
			        // a-z
			        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
			        break;
			    case 1:
			        // A-Z
			        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
			        break;
			    case 2:
			        // 0-9
			        temp.append((rnd.nextInt(10)));
			        break;
			    }
			}
						
			MailVO vo = new MailVO("binder.send@gmail.com", "Binder", temp + "님의 Binder 초대메시지입니다.", "ㅋㅋ 힝 속았징");
			vo.setTo(to);
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
			logger.info("메일전송완료");
		}
		
		
		return "index";
	}
<<<<<<< HEAD
}
=======

	
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
>>>>>>> 브랜치_지혜
