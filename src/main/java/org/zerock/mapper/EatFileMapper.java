package org.zerock.mapper;

import org.zerock.domain.EatFileVO;
import org.zerock.domain.MemberVO;

public interface EatFileMapper {
	
	public int insert(EatFileVO vo);
	
	public void deleteByEatBno(Long eatbno);
	
	public void removeByUserid(MemberVO vo);
}
