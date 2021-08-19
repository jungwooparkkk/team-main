package org.zerock.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	
	public void write(BoardVO board, MultipartFile file);
	
	public BoardVO get(long bno);
	
	public boolean modify(BoardVO board, MultipartFile file);
	
	public boolean remove(long bno);

	public int views(long bno);
	
	public boolean modify(BoardVO board);
	
	public List<BoardVO> getList(Criteria cri);

	public int getTotal(Criteria cri);

	public void write(BoardVO board);

	

}
