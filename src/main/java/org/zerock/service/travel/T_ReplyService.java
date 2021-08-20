package org.zerock.service.travel;

import java.util.List;

import org.zerock.domain.travel.T_ReplyVO;

public interface T_ReplyService {
	
	public int register(T_ReplyVO vo);
	
	public T_ReplyVO get(Long rno);
	
	public int modify(T_ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<T_ReplyVO> getList(Long bno);
	
}
