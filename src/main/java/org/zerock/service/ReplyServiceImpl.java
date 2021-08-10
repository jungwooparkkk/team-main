package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int write(ReplyVO vo) {
		log.info("글쓰기" + vo);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(long rno) {
		log.info("글 정보" + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("수정" + vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(long rno) {
		log.info("삭제" + rno);
		return mapper.delete(rno);
	}


	@Override
	public List<ReplyVO> getList(Long bno) {
		// TODO Auto-generated method stub
		return mapper.getList(bno);
	}

	
}
