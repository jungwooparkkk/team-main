package org.zerock.controller.travel;

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
import org.zerock.domain.travel.T_BoardVO;
import org.zerock.domain.travel.T_Criteria;
import org.zerock.domain.travel.T_PageDTO;
import org.zerock.service.travel.T_BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/T_board/*")
@AllArgsConstructor
public class T_BoardController {
	
	private T_BoardService service;
	
	@GetMapping("/T_list")
	public void list(@ModelAttribute("cri") T_Criteria cri, Model model) {
		log.info("board/list method.....");
		int total = service.getTotal(cri);
		
		// service getList() 실행 결과를
		List<T_BoardVO> list = service.getList(cri);
		//log.info(list.get(0).getTitle());
		// model에 attribute로 넣고
		log.info(list);
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new T_PageDTO(cri, total));
		System.out.println("되나?");
		// view로 포워드
	}
	
	

	@GetMapping("/T_register")
	@PreAuthorize("isAuthenticated()")
	public void register(@ModelAttribute("cri") T_Criteria cri) { 
		// forward/WEB-INF/views/board/register.jsp
	}
	
	@PostMapping("/T_register")
	@PreAuthorize("isAuthenticated()")
	public String register(T_BoardVO board, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("register: " + board);
		
		board.setFileName(file.getOriginalFilename());
		
		service.register(board, file);
		
		// redirect 목적지로 정보 전달
		rttr.addFlashAttribute("result", board.getBno());
		rttr.addFlashAttribute("messageTitle", "등록성공.");
		rttr.addFlashAttribute("messageBody", board.getBno() + "번 게시물 등록 되었습니다.");
		
		
		return "redirect:/T_board/T_list";
	}
	
	@GetMapping({"/T_get", "/T_modify"})
	public void get(@RequestParam("bno") Long bno, 
			@ModelAttribute("cri") T_Criteria cri, 
			Model model) {
		log.info("T_get or /T_modify");
		
		// service에게 일 시킴
		T_BoardVO vo = service.get(bno);
		
		// 결과를 모델에 넣음
		model.addAttribute("board", vo);
		
		service.views(bno);
		
		// forward 
	}
	@PostMapping("/T_modify")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(T_BoardVO board, T_Criteria cri, 
			@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("T_modify:" + board);
		
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
		return "redirect:/T_board/T_list";
	}
	
	@PostMapping("/T_remove")
	@PreAuthorize("principal.username == #writer")
	public String remove(@RequestParam("T_bno") Long bno, String writer,
			RedirectAttributes rttr,
			T_Criteria cri) {
		log.info("remove..." + bno);
		
		boolean success = service.remove(bno);
		
		if(success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공.");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/T_board/T_list";
	}
	
}

     
