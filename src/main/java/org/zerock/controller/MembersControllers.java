package org.zerock.controller;

import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.security.domain.PersoUser;
import org.zerock.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@CrossOrigin
@Controller
@RequestMapping("/member")
@Log4j
public class MembersControllers {

	@Setter(onMethod_=@Autowired)
	private MemberService service;
	
	@RequestMapping("/loginMem")
	public void login() {
		
	}
	
	@RequestMapping("/jusoPopup")
	public void juso() {
		
	}
	
	@GetMapping("/signupMem")
	public void signupMem() {
		
	}
	
	@PostMapping("/signupMem")
	public String signupPost(MemberVO mem, RedirectAttributes rttr) {
		log.info(mem);
		boolean ok = service.insert(mem);
		
		if(ok) {
			return "redirect:/member/loginMem";
		}else {
			return "redirect:/member/signupMem?error";
		}
		
	}
	
	@GetMapping("/infoMem")
	@PreAuthorize("isAuthenticated()")
	public void info(Principal principal, Model model) {
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
		return "redirect:/main/info";
	}
	
	@PostMapping("/deleteMem")
	@PreAuthorize("pricipal.nickName == #mem.userid")
	public String delete(MemberVO mem, RedirectAttributes rttr, HttpServletRequest req, String exPassword) throws ServletException{
		boolean ok = service.delete(mem, exPassword);
		
		if(ok) {
			req.logout();
			return "redirect:/board/list";
		}else {
			rttr.addAttribute("status","error");
			return "redirect:/member/info";
		}
	}
	
	@GetMapping("/checkdupMem")
	@ResponseBody
	public ResponseEntity<String>copy(String id){
		log.info("check duplicate method");
		
		MemberVO mem = service.read(id);
		
		if (mem == null) {
			return new ResponseEntity<> ("success",HttpStatus.OK);
		}else {
			return new ResponseEntity<> ("exist",HttpStatus.OK);
		}
	}
	

	

	
	
}

