package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.EatBoardVO;
import org.zerock.mapper.EatBoardMapper;
//import org.zerock.mapper.EatFileMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class EatBoardServiceImpl implements EatBoardService {

	@Setter(onMethod_= @Autowired)
	public EatBoardMapper mapper;
	
//	@Setter(onMethod_= @Autowired)
//	public EatFileMapper eatfileMapper;

	@Override
	public void register(EatBoardVO board) {
		log.info("register......." + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public EatBoardVO get(Long eatbno) {
		log.info("get......." + eatbno);
		
		return mapper.read(eatbno);
	}

	@Override
	public boolean modify(EatBoardVO board) {
		log.info("modifiy......." + board);
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long eatbno) {
		log.info("remove........" + eatbno);
		
		int cnt = mapper.delete(eatbno);
		
		return cnt == 1;
	}

	@Override
	public List<EatBoardVO> getList(Criteria cri) {

		log.info("getList...............");

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
}
