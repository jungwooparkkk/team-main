package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.EatReplyVO;
import org.zerock.domain.MemberVO;

public interface EatReplyMapper {
	
	public int insert(EatReplyVO vo);
 
	public EatReplyVO read(Long eatrno);
	
	public int delete(Long eatrno);
	
	public int update(EatReplyVO reply);
	
	public List<EatReplyVO> getList(Long eatbno);
	
	public int getCountByBno(Long eatbno);
	
	public void deleteByBno(Long eatbno);

	public void removeByUserid(MemberVO vo);

	public void removeByBnoByUserid(MemberVO vo);

	
}
