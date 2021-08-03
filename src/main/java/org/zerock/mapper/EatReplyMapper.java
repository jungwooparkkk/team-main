package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.EatReplyVO;
import org.zerock.domain.MemberVO;

public interface EatReplyMapper {
	
	public int insert(EatReplyVO vo);
 
	public EatReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(EatReplyVO reply);
	
	public List<EatReplyVO> getList(Long bno);

	public void deleteByBno(Long bno);

	public void removeByUserid(MemberVO vo);

	public void removeByBnoByUserid(MemberVO vo);
	
	public int getCountByBno(Long eatbno);
}
