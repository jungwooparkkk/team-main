package org.zerock.service;


import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
//import javax.mail.MessagingException;
//import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceimpl implements MemberService{
	@Setter(onMethod_=@Autowired)
	private MemberMapper map;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder encoder;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	
	@Override
	@Transactional
	public boolean insert(MemberVO mem) {
		mem.setUserpw(encoder.encode(mem.getUserpw()));
		int cnt = map.insert(mem);
		
		AuthVO auth = new AuthVO();
		auth.setUserid(mem.getUserid());
		auth.setAuth("ROLE_MEMBER");
		map.insertAuth(auth);
		
		return cnt == 1;
	}

	@Override
	public MemberVO read(String name) {
		
		return map.read(name);
	}
	
	@Override
	public void modify(MemberVO user, String string, String tempPw) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean modify(MemberVO mem, String exPassword) {
		MemberVO ex = map.read(mem.getUserid());
		
		if(encoder.matches(exPassword, ex.getUserpw())) {
			return modify(mem);
		}
		return false;
	}

	@Override
	public boolean modify(MemberVO mem) {
		mem.setUserpw(encoder.encode(mem.getUserpw()));
		
		int cnt = map.update(mem);
		
		return cnt == 1;
	}

	@Override
	public boolean delete(MemberVO mem, String exPassword) {
		MemberVO ex = map.read(mem.getUserid());
		if(encoder.matches(exPassword, ex.getUserpw())) {
			return delete(mem);
		}
		return false;
	}

	@Override
	@Transactional
	public boolean delete(MemberVO mem) {
		

		map.deleteAuth(mem);
		
		int cnt = map.delete(mem);
		
		return cnt == 1;
	}

	@Override
	public MemberVO check(String email) {
		return map.check(email);
	}

	@Override
	public void send(String subject, String text, String from, String to) {
		   // javax.mail.internet.MimeMessage
        MimeMessage message = javaMailSender.createMimeMessage();
        
        String ContentText = text;
 
        try {
            // org.springframework.mail.javamail.MimeMessageHelper
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setSubject("임시 비밀번호 설정");
 //           helper.setText(text, true);
            helper.setText(ContentText);
            helper.setFrom(from);
            helper.setTo(to);
  
 
            javaMailSender.send(message);
       
        } catch (MessagingException e) {
            e.printStackTrace();
        }
      
    }


	
}
