package org.zerock.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberServiceTests {

	@Setter(onMethod_ = @Autowired)
	MemberService service;
	
	@Test
	public void test() {
		assertNotNull(service);
		int ranNo = (int)(Math.random() * (99999-10000 + 1)) + 10000;
		String tempPw = String.valueOf(ranNo);
		StringBuilder bds = new StringBuilder("");
		bds.append("임시 비밀번호는" + tempPw + "입니다.");
		service.send("subject", bds.toString(), "testaddr67@gmail.com", "testaddr67@gmail.com");
	}

}
