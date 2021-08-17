package org.zerock.mapper;

import static org.junit.Assert.*

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.travel.MemberVO;
import org.zerock.mapper.travel.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(	
		{"file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_= @Autowired)
	private MemberMapper mapper;

	@Test
	public void test() {
		fail("Not yet implemented");
	}
	
	@Test
	public void testInsert() {
		
		MemberVO member = new MemberVO();
		member.setUserid("user");
		member.setUserpw("pw");
		member.setNickName("nickname");
		
		mapper.insert(member);
		
		log.info(member);
	}

}

