package org.zerock.mapper;

import org.zerock.domain.fileVO;

public interface EatFileMapper {
	public int insert(fileVO vo);
	public void deleteByEatBno(Long eatbno);
	public void removeByUserid();
}
