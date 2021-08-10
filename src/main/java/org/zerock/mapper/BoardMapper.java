package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {

	// @Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	public int views(long bno);
	
	
	public boolean write(BoardVO board);
	
	public int writeSelectKey(BoardVO board);
	
	public BoardVO read(long bno);
	
	public int delete(long bno);
	
	public int update (BoardVO board);

	public List<BoardVO> getListWithPaging(Criteria cri);


	public int getTotalCount(Criteria cri);
	
	
}
