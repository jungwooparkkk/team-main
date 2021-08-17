package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;
	
//	@PostMapping(value = "/new",
//			consumes = "application/json",
//			produces = { MediaType.TEXT_PLAIN_VALUE })
//	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
//		log.info("ReplyVO" + vo);
//		
//		int insertCount = service.write(vo);
//		
//		log.info("Reply insert count" + insertCount);
//		
//		return insertCount == 1
//				? new ResponseEntity<>("sucess", HttpStatus.OK)
//						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	
	
	@PostMapping("/new")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {

		int cnt = service.write(vo);

		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@GetMapping("/pages/{bno}")
	public List<ReplyVO> getList(@PathVariable("bno") Long bno) {

		return service.getList(bno);
	}

	@GetMapping("/{rno}")
	public ReplyVO get(@PathVariable Long rno) {

		return service.get(rno);
	}
	@DeleteMapping("/{rno}")
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> remove(@PathVariable Long rno, @RequestBody ReplyVO vo) {

		int cnt = service.remove(rno);

		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable Long rno) {
		int cnt = service.modify(vo);

		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}