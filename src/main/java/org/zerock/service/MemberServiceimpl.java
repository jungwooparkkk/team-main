package org.zerock.service;


import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AuthVO;
import org.zerock.domain.FileDTO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class MemberServiceimpl implements MemberService{
	@Setter(onMethod_=@Autowired)
	private MemberMapper map;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder encoder;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	public MemberServiceimpl() {
		this.bucketName ="ca-myuniq";
		this.profileName ="profileImage";
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
	}
	

	
	
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

	@Override
	public MemberVO dupNickcheck(String nickName) {
		return map.dupNickcheck(nickName);
	}

	@Override
	public boolean upload(String userid, MultipartFile mfile) {
		
		// 회원 테이블에 파일명 추가 
		FileDTO file = new FileDTO();
		file.setFileName(mfile.getOriginalFilename());
		file.setUserid(userid);
		
		map.upload(file);
		
		// s3 upload
		try (InputStream is = mfile.getInputStream()) {
			
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(userid +"/"+ mfile.getOriginalFilename())
					.contentType(mfile.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, mfile.getSize()));
			
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
		
		return false;
	}

	
}
