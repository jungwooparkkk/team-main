package org.zerock.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.EatBoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class EatBoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private EatBoardMapper mapper;
	
	@Test
	public void testGetList() {
		assertNotNull(mapper);
		
		List<EatBoardVO> list = mapper.getList();
		assertTrue(list.size() > 0);
		
	}
	
	@Test
	public void testInsert() {
		EatBoardVO board = new EatBoardVO();
		board.setTitle("새로 작성하는글");
		board.setContent("새로 작성하는 내용");
		board.setAdress("새로 작성하는 주소");
		board.setWriter("newbie");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		EatBoardVO board = new EatBoardVO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성하는 내용 select key");
		board.setAdress("새로 작성하는 주소 select key");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		EatBoardVO board = mapper.read(5L);
		
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("DELETE COUNT : " + mapper.delete(3L));
	}
	
	@Test
	public void testUpdate() {
		EatBoardVO board = new EatBoardVO();
		// 실행전 존재하는 번호인지 확인
		board.setEatbno(5L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setAdress("수정된 주소");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT :" + count);
	}
}



























