package org.zerock.service;

import java.util.List;

import org.zerock.domain.EatReplyVO;

public interface EatReplyService {

	public int register(EatReplyVO vo);
	
	public EatReplyVO get(Long eatrno);
	
	public int modify(EatReplyVO vo);
	
	public int remove(Long eatrno);
	
	public List<EatReplyVO> getList(Long eatbno);

}
