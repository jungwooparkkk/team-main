package org.zerock.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.LikesVO;
import org.zerock.service.LikesService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/likes")
@Log4j
@AllArgsConstructor
public class BoardLikesController {
	
	public LikesService service;
	
	@PostMapping("likesupdate")
	@ResponseBody
	public Map<String, String> likesupdate(@RequestBody LikesVO vo){
		log.info("likes..");
		log.info(vo);
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			service.likesupdate(vo);
			map.put("result", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		return map;
	}
}
