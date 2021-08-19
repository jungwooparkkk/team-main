package org.zerock.service.travel;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.travel.T_BoardVO;
import org.zerock.domain.travel.T_Criteria;

public interface T_BoardService {
	
public void register(T_BoardVO board);
	
	public T_BoardVO get(Long bno);
	
	public boolean modify(T_BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<T_BoardVO> getList(T_Criteria cri);

	public int getTotal(T_Criteria cri);

	public void register(T_BoardVO board, MultipartFile file);
	
	public boolean modify(T_BoardVO board, MultipartFile file);

	public int views(Long bno);
	}