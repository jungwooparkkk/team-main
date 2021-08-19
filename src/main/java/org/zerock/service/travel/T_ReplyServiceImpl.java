package org.zerock.service.travel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.travel.T_ReplyVO;
import org.zerock.mapper.travel.T_ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class T_ReplyServiceImpl implements T_ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private T_ReplyMapper mapper;
	
	/*
	@Autowired
	public void setMapper(ReplyMapper mapper) {
		this.mapper = mapper;
	}
	*/

	@Override
	public int register(T_ReplyVO vo) {

		return mapper.insert(vo);
	}

	@Override
	public T_ReplyVO get(Long rno) {

		return mapper.read(rno);
	}

	@Override
	public int modify(T_ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		// TODO Auto-generated method stub
		return mapper.delete(rno);
	}

	@Override
	public List<T_ReplyVO> getList(Long bno) {
		// TODO Auto-generated method stub
		return mapper.getList(bno);
	}
	
}






