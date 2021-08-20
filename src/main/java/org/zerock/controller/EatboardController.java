package org.zerock.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.EatBoardVO;
import org.zerock.domain.eatpageDTO;
import org.zerock.service.EatBoardService;
import org.zerock.service.EatLikesService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/eatboard")
@Log4j
@AllArgsConstructor
public class EatboardController {
	
	public EatBoardService service;
	public EatLikesService lservice;
	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model, Principal principal) {
		log.info("list");
		
		int total = service.getTotal(cri);
		
		List<EatBoardVO> list = service.getList(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new eatpageDTO(cri, total));
		
		log.info(principal);
		//좋아요
		if (principal != null) {
			List<Long> likesEatList = lservice.getLikeList(principal.getName());
			
			log.info(likesEatList);
			
			for (EatBoardVO evo : list) {
				if (likesEatList.contains(evo.getEatbno())) {
					log.info(evo);
					evo.setLikeClicked(true);
				}
			}
		}
		
		
		
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register(@ModelAttribute("cri") Criteria cri) { 
		// forward/WEB-INF/views/board/register.jsp
	}

	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(EatBoardVO board, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("register: " + board);
		
		board.setFileName(file.getOriginalFilename());
		
		service.register(board, file);
		
		// redirect 목적지로 정보 전달
		rttr.addFlashAttribute("result", board.getEatbno());
		rttr.addFlashAttribute("messageTitle", "등록성공.");
		rttr.addFlashAttribute("messageBody", board.getEatbno() + "번 게시물 등록 되었습니다.");
		
		
		return "redirect:/eatboard/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("eatbno") Long eatbno, Model model, 
			@ModelAttribute("cri") Criteria cri, Principal principal) {
		log.info("/get or /modify");
		EatBoardVO vo = service.get(eatbno);
		
		//좋아요
		if (principal != null) {
			Long likeClicked = lservice.getLikeClicked(principal.getName(), vo.getEatbno());
			Long one = 1L;
			if (one.equals(likeClicked)) {
				vo.setLikeClicked(true);
			}
		}
		
		
		model.addAttribute("board", vo);
		
		service.views(eatbno);

	}
	

	
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(EatBoardVO board, Criteria cri, 
			@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("modify:" + board);
		
		boolean success = service.modify(board, file);
		
		if(success) {
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
	@PreAuthorize("principal.username == #writer")
	public String remove(@RequestParam("eatbno") Long eatbno, String writer,
			RedirectAttributes rttr,
			Criteria cri) {
		log.info("remove..." + eatbno);
		
		boolean success = service.remove(eatbno);
		
		if(success) {
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












