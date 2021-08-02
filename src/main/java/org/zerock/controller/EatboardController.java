package org.zerock.controller;

import java.util.List;

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
import org.zerock.domain.eatpageDTO;
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
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("list");
		int total = service.getTotal(cri);
		
		List<EatBoardVO> list = service.getList(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new eatpageDTO(cri, total));
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register(@ModelAttribute("cri") Criteria cri) { 
		// forward/WEB-INF/views/board/register.jsp
	}

	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(EatBoardVO board, RedirectAttributes rttr) {
		log.info("register: " + board);
		
		service.register(board);
		
		// redirect 목적지로 정보 전달
		rttr.addFlashAttribute("result", board.getEatbno());
		rttr.addFlashAttribute("messageTitle", "등록성공.");
		rttr.addFlashAttribute("messageBody", board.getEatbno() + "번 게시물 등록 되었습니다.");
		
		
		return "redirect:/eatboard/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("eatbno") Long eatbno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("/get or /modify");
		
		EatBoardVO vo = service.get(eatbno);
		
		model.addAttribute("board", vo);
	}
	

	
	@PostMapping("/modify")
	public String modify(EatBoardVO board, Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "수정 성공");
			rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/eatboard/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("eatbno") Long eatbno, 
			RedirectAttributes rttr, 
			Criteria cri) {
		log.info("remove..." + eatbno);
		if(service.remove(eatbno)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공.");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/eatboard/list";
	}
}












