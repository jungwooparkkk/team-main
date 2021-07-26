package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.EatBoardVO;
import org.zerock.service.EatBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/eatboard")
@Log4j
@AllArgsConstructor
public class EatboardController {
	
	public EatBoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		
		model.addAttribute("list", service.getList());
	}
	
	@GetMapping("/register")
	/* @PreAuthorize("isAuthenticated()") */
	/* @ModelAttribute("cri") Criteria cri */
	public void register() { 
		// forward /WEB-INF/views/board/register.jsp
	}

	
	@PostMapping("/register")
	/* @PreAuthorize("isAuthenticated()") */
	public String register(EatBoardVO board, RedirectAttributes rttr) {
		log.info("register: " + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getEatbno());
		
		return "redirect:/eatboard/list";
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("eatbno") Long eatbno, Model model) {
		log.info("get");
		model.addAttribute("board", service.get(eatbno));
	}
	

	
	@PostMapping("/modify")
	public String modify(EatBoardVO board, RedirectAttributes rttr) {
		log.info("modify:" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "rediect:/eatboard/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("eatbno") Long eatbno, RedirectAttributes rttr) {
		log.info("remove..." + eatbno);
		if(service.remove(eatbno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:eatboard/list";
	}
}












