package org.zerock.controller.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")

@Log4j
public class MainController {
	
	@GetMapping("/main")
	public void main() {
		log.info("board/main method....");
	}

	// 새 리퀘스트 핸들러 메소드
}
