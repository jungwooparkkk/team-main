package org.zerock.controller.main1;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/main/*")
public class Main1Controller {
	
	@GetMapping("/list")
	public void main() {
		log.info("main/list method.....");
	}

}
