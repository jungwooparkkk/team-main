package org.zerock.controller;

import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.security.domain.PersoUser;
import org.zerock.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MembersControllers {
	


	@Setter(onMethod_=@Autowired)
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;

	@RequestMapping("/loginMem")
	public void login(){
		
	}
	

	@RequestMapping("/jusoPopup")
	public void juso() {
		
	}
	
	@GetMapping("/signupMem")
	public void signup() {
		
	}
	
	@PostMapping("/signupMem")
	public String signupPost(MemberVO mem, RedirectAttributes rttr) {
		log.info(mem);
		boolean ok = service.insert(mem);
		
		if(ok) {
			return "forward:/member/loginMem";
		}else {
			return "redirect:/member/signupMem?error";
		}
		
	}
	
	@GetMapping("/infoMem")
	@PreAuthorize("isAuthenticated()")
	public void info(Criteria cri, Principal principal, Model model) {
		log.info(principal.getName());
		MemberVO members = service.read(principal.getName());
		
		model.addAttribute("members", members);
	}
	
	@PostMapping("/modifyMem")
	@PreAuthorize("principal.nickName == #mem.userid")
	public String modify(MemberVO mem, RedirectAttributes rttr, Authentication auth, String exPassword) {
		boolean ok = service.modify(mem, exPassword);
		
		if(ok) {
			rttr.addAttribute("status", "success");
			PersoUser user = (PersoUser) auth.getPrincipal();
			user.setMember(mem);
		}else {
			rttr.addAttribute("status","error");
		}
		return "redirect:/member/infoMem";
	}
	
	@PostMapping("/deleteMem")
	@PreAuthorize("pricipal.nickName == #mem.userid")
	public String delete(MemberVO mem, RedirectAttributes rttr, HttpServletRequest req, String exPassword) throws ServletException{
		boolean ok = service.delete(mem, exPassword);
		
		if(ok) {
			req.logout();
			return "redirect:/member/loginMem";
		}else {
			rttr.addAttribute("status","error");
			return "redirect:/member/infoMem";
		}
	}
	
	@GetMapping("/checkdupMem")
	@ResponseBody
	public ResponseEntity<String[]>copy(String id){
		log.info("check duplicate method");
		
		MemberVO mem = service.read(id);
		
		if (mem == null) {
			return new ResponseEntity<> (new String[] {"success", ""} , HttpStatus.OK);
		}else {
			return new ResponseEntity<> (new String[] {"exist",mem.getUserid()},HttpStatus.OK);
		}
	}
	
	@GetMapping("/checkMail")
	@ResponseBody
	public ResponseEntity<String[]> emailDupcheck(HttpSession session, String email, RedirectAttributes rttr){
		log.info("check signed email method");
		
		MemberVO mem = service.check(email);
		
		if(mem == null) {
			return new ResponseEntity<> (new String[] {"fail", ""},HttpStatus.OK);
		}else{
			findpwPost(session, email);
			return new ResponseEntity<> (new String[] {"exist", mem.getUserid()} ,HttpStatus.OK);
		}
	}
	
	@GetMapping("/newpassword")
	@ResponseBody
	public ResponseEntity<String[]> newpassword(HttpSession session, String email, RedirectAttributes rttr){
		log.info("check signed email method");
		
		MemberVO mem = service.check(email);
		
		if(mem == null) {
			return new ResponseEntity<> (new String[] {"fail", ""},HttpStatus.OK);
		}else{
			findpwPost(session, email);
			return new ResponseEntity<> (new String[] {"exist", mem.getUserid()} ,HttpStatus.OK);
		}
	}
	

	
	@GetMapping("/findid")
	public void findid() {
		
	}
	
	@GetMapping("/findpw")
	public void findpw() {
		
	}
	
	@PostMapping("/findpw")
	public String findpwPost(HttpSession session, @RequestParam String email) {

		MemberVO user = service.check(email);
		
		if(user != null && user.getEmail().equals(email)) {
					int ranNo = (int)(Math.random() * (99999-10000 + 1)) + 10000;
					String tempPw = String.valueOf(ranNo);
					user.setUserpw(tempPw);
					service.modify(user);
					
					String subject = "임시 비밀 번호 발급 안내";
					StringBuilder bds = new StringBuilder();
					bds.append("임시 비밀번호는" + tempPw + "입니다.");
					service.send(subject, bds.toString(),"testaddr67@gmail.com", email);
		}
		return "redirect: ${appRoot}/member/findpw";
	}
		
	
	@GetMapping("/infoModify")
	public void modify() {
		
	}
	
	@GetMapping("/simpleinfo")
	public void simpleinfo() {
		
	}


	
}

