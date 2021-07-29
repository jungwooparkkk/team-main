package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/security")
@Log4j
public class SecurController {

	@GetMapping(value="/every", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getEvery() {
		log.info("모두 접근 가능");
		return "모두 접근 가능한 경로";
	}
	
	@GetMapping(value="/member",produces="text/plain; charset=utf-8")
	@ResponseBody
	public String getMember() {
		log.info("멤버만");
		
		return "멤버 접근 가능 경로";
	}
	
	@GetMapping(value="/admin", produces ="text/plain; charset=utf-8" )
	@ResponseBody
	public String getAdmin() {
		log.info("관리자만");
		return "관리자 접근 가능 경로";
	}
}
