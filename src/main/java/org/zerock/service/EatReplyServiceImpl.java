package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.EatReplyVO;
import org.zerock.mapper.EatReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class EatReplyServiceImpl implements EatReplyService {
	@Setter(onMethod_ = @Autowired)
	private EatReplyMapper mapper;
	
	@Override
	public int register(EatReplyVO vo) {
		return mapper.insert(vo);
	}
	
	@Override
	public EatReplyVO get(Long eatrno) {
		return mapper.read(eatrno);
	}
	
	@Override
	public int modify(EatReplyVO vo) {
		return mapper.update(vo);
	}
	
	@Override
	public int remove(Long eatrno) {
		return mapper.delete(eatrno);
	}
	
	@Override
	public List<EatReplyVO> getList(Long eatbno){
		return mapper.getList(eatbno);
	}
	


}
