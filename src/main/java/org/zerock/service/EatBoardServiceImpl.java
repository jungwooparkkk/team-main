package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.EatBoardVO;
import org.zerock.mapper.EatBoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class EatBoardServiceImpl implements EatBoardService {

	@Setter(onMethod_= @Autowired)
	public EatBoardMapper mapper;

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
		
		return mapper.delete(eatbno) == 1;
	}

	@Override
	public List<EatBoardVO> getList() {

		log.info("getList...............");

		return mapper.getList();
	}
}
