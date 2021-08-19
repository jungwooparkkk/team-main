package org.zerock.mapper.travel;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.travel.MemberVO;
import org.zerock.domain.travel.T_Criteria;
import org.zerock.domain.travel.T_ReplyVO;

public interface T_ReplyMapper {
	
	public int insert(T_ReplyVO vo);
	 
	public T_ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(T_ReplyVO reply);
	
	public List<T_ReplyVO> getList(Long bno);
	
	public int getCountByBno(Long bno);
	
	public void deleteByBno(Long bno);

	public void removeByUserid(MemberVO vo);

	public void removeByBnoByUserid(MemberVO vo);

	
}
