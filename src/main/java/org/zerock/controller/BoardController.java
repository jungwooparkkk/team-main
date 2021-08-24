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
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
@AllArgsConstructor
public class BoardController {

	private BoardService service;

	@GetMapping("/list")
	public void list(Criteria cri ,Model model) {
		log.info("게시판" + cri);

		int total = service.getTotal(cri);
		
		// service getList() 실행 결과를
		List<BoardVO> list = service.getList(cri);
		// model에 attribute로 넣고
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public String write(@ModelAttribute("cri") Criteria cri) {
		System.out.println("글쓰기");
		return "board/write";
	}

	@PostMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public String write(BoardVO board,@RequestParam("file")MultipartFile file, RedirectAttributes rttr) {
		log.info("write: " + board);
		
		board.setFileName(file.getOriginalFilename());
		
		service.write(board, file);
		
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
		
	}

	@PostMapping("/modify")
	public String modify(BoardVO board,@ModelAttribute("cri") Criteria cri,
			@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("글 수정/삭제: " + board);
		
		if(service.modify(board,file)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		
		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri , RedirectAttributes rttr, String writer) {
		
		boolean success = service.remove(bno);
		
		log.info("삭제" + bno);
		
		if (success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") long bno,@ModelAttribute("cri") Criteria cri, Model model, Principal principal) {
		log.info("게시글 보기");
		
		BoardVO vo = service.get(bno);
		
		if (principal != null) {
			Long likeClicked = service.getLikeClicked(principal.getName(), vo.getBno());
			Long one = 1L;
			vo.setLikeClicked(one.equals(likeClicked)); 
		}
		
		model.addAttribute("board", vo);
		service.views(bno);
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno")long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("수정작업");
		
		BoardVO vo = service.get(bno);
		
		model.addAttribute("board",service.get(bno));
	}
	
	@GetMapping("/favicon.ico")
	   public String favcon() {
	      return "forward:/resources/favicon.ico";
	   }
}
