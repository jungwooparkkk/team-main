package org.zerock.mapper;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.travel.T_BoardVO;
import org.zerock.mapper.travel.T_BoardMapper;
import org.zerock.mapper.travel.T_BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class T_BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private T_BoardMapper mapper;
	
	@Test
	public void testGetList1() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testGetList() {
		assertNotNull(mapper);
		
		List<T_BoardVO> list = mapper.getList();
		
//		assertEquals(5, list.size());
		assertTrue(list.size() > 0);
	}
	@Test
	public void testInsert() {
		T_BoardVO board = new T_BoardVO();
		board.setTitle("새로 작성하는 글 ");
	    board.setContent("새로 작성하는 내용 ");
	    board.setWriter("newbie");
	    
	    mapper.insert(board);
	    
	    log.info(board);
		
	}
	@Test
	public void testInsertSelectKey() {
		
		T_BoardVO board = new T_BoardVO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성하는 내용 select key");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
		
	}
	@Test
	public void testRead() {
		T_BoardVO board = mapper.read(1L);
		log.info(board);
	}
	@Test
	public void testDelete() {
		log.info("DELETE COUNT: " + mapper.delete(1L));
	}
	@Test
	public void testUpdate() {
		T_BoardVO board = new T_BoardVO();
		board.setBno(1L);
		board.setTitle("수정된 제목!!");
        board.setContent("수정된 내용!!");
        board.setWriter("TWP");
        
        int count = mapper.update(board);
        log.info("UPDATE COUNT: " + count);
	}

}
