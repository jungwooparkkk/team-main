package org.zerock.mapper.travel;

import java.util.List;

import org.zerock.domain.travel.MemberVO;
import org.zerock.domain.travel.T_BoardVO;
import org.zerock.domain.travel.T_Criteria;

public interface T_BoardMapper {
	
	//@Select("select * frome travel_board where bno > 0")
	public List<T_BoardVO> getList();
	
	public int views(long bno);
	
	
	public void insert(T_BoardVO board);
	
	public Integer insertSelectKey(T_BoardVO board);
	
	public T_BoardVO read(long bno);
	
	public int delete(long bno);
	
	public int update(T_BoardVO board);
	
	public List<T_BoardVO> getListWithPaging(T_Criteria cri);

	public int getTotalCount(T_Criteria cri);
	
	public void removeByUserid(MemberVO vo);
	


}
