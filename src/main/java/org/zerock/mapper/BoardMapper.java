package org.zerock.mapper;

import java.util.List;


import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;

public interface BoardMapper {

	// @Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	public int views(long bno);
	
	
	public int write(BoardVO board);
	
	public int writeSelectKey(BoardVO board);
	
	public BoardVO read(long bno);
	
	public int delete(long bno);
	
	public int update (BoardVO board);

	public List<BoardVO> getListWithPaging(Criteria cri);


	public int getTotalCount(Criteria cri);

	public void deleteByUserid(MemberVO mem);
	
	
}
