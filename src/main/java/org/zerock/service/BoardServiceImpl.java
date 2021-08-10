package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.FileVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.FileMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter (onMethod_ = @Autowired)
	private ReplyMapper replyMapper;

	@Setter (onMethod_ = @Autowired)
	private FileMapper fileMapper;
	
	@Override
	public void write(BoardVO board) {
		mapper.writeSelectKey(board);
	}
	
	@Override
	@Transactional
	public void write(BoardVO board, MultipartFile file) {
		write(board);
		
		if (file != null && file.getSize() > 0) {
			FileVO vo = new FileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			
		}
	}

	@Override
	public BoardVO get(long bno) {
		log.info("get..." + bno );
	
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		
		log.info("modify..." + board);
		return mapper.update(board) == 1;
	}

	@Override
	@Transactional
	public boolean remove(long bno) {
		log.info("remove..." + bno);
		replyMapper.deleteByBno(bno);
		
		return mapper.delete(bno) == 1;
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("criteria" + cri);
		
		return mapper.getListWithPaging(cri);
	}

	

	@Override
	public int getTotal(Criteria cri) {
		log.info("getTotal count");
		return mapper.getTotalCount(cri);
	
	}
	
	@Override
	public int views(long bno) {
		return mapper.views(bno);
	}
	

}

