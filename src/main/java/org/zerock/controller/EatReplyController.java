package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.EatReplyVO;
import org.zerock.service.EatReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies")
@Log4j
@AllArgsConstructor
public class EatReplyController {

	private EatReplyService service;
	
	@PostMapping("/new")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> create(@RequestBody EatReplyVO vo){
		
		int cnt = service.register(vo);
		
		if(cnt ==1 ) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@GetMapping("/pages/{eatbno}")
	public List<EatReplyVO> getList(@PathVariable("eatbno") Long eatbno) {

		return service.getList(eatbno);
	}
	@GetMapping("/{eatrno}")
	public EatReplyVO get(@PathVariable Long eatrno) {

		return service.get(eatrno);
	}

	@DeleteMapping("/{eatrno}")
	@PreAuthorize("principal.nickName == #vo.replyer")
	public ResponseEntity<String> remove(@PathVariable Long eatrno, @RequestBody EatReplyVO vo) {

		int cnt = service.remove(eatrno);

		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "/{eatrno}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	@PreAuthorize("principal.nickName == #vo.replyer")
	public ResponseEntity<String> modify(@RequestBody EatReplyVO vo, @PathVariable Long eatrno) {
		int cnt = service.modify(vo);

		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
