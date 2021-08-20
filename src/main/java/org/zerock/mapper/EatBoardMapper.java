package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.EatBoardVO;
import org.zerock.domain.MemberVO;

public interface EatBoardMapper {

	
	public List<EatBoardVO> getList();
	
	public void insert (EatBoardVO board);
	
	public Integer insertSelectKey(EatBoardVO board);
	
	public EatBoardVO read(Long eatbno);
	
	public int delete(Long eatbno);
	
	public int update (EatBoardVO board);

	public List<EatBoardVO> getListWithPaging(Criteria cri);

	public int getTotalCount(Criteria cri);
	
	public void removeByUserid(MemberVO vo);
	
	public int views(Long eatbno);
}
