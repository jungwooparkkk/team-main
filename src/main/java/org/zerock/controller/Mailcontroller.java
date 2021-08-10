package org.zerock.controller;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.MailVO;
import org.zerock.service.MailSendService;

import lombok.extern.log4j.Log4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;

@RequestMapping("/mail")
@Log4j
public class Mailcontroller {

	@Autowired
	private MailSendService mailSender;

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
	
	@GetMapping("/mail")
	public void mail() {
		log.info("mail");
	}
}
