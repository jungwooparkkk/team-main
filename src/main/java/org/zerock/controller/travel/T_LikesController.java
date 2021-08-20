package org.zerock.controller.travel;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.travel.T_LikesVO;
import org.zerock.service.travel.T_LikesService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/T_likes")
@Log4j
@AllArgsConstructor
public class T_LikesController {

public T_LikesService service;
	
	@PostMapping("likesupdate")
	@ResponseBody
	public Map<String, String> likesupdate(@RequestBody T_LikesVO vo){
		log.info("likesupdate");
		
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
