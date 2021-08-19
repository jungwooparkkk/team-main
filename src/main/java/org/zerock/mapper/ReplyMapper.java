package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	
	public ReplyVO read(long rno);
	
	public int delete(long rno);
	
	public int update(ReplyVO reply);
	


	public List<ReplyVO> getList(Long bno);

	public void deleteByBno(long bno);

	public void ByBnoByUserid(MemberVO mem);

	public void deleteByBnoByUserid(MemberVO mem);

	public void deleteByUserid(MemberVO mem);
}
