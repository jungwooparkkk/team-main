package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.EatBoardVO;

public interface EatBoardMapper {

	
	public List<EatBoardVO> getList();
	
	public void insert (EatBoardVO board);
	
	public void insertSelectKey(EatBoardVO board);
	
	public EatBoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update (EatBoardVO board);
}
