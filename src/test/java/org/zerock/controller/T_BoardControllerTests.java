package org.zerock.controller;

import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.travel.T_BoardVO;
import org.zerock.mapper.T_BoardMapperTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(
		{
			"file:src/main/webapp/WEB-INF/spring/root-context.xml",
			"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
		})
@Log4j
public class T_BoardControllerTests {
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		
     String viewName = mockMvc.perform(MockMvcRequestBuilders.get("/T_board/T_list"))
      .andReturn()
      .getModelAndView()
      .getViewName();
     
     assertEquals("T_board/T_list", viewName);
	}
	
	@Test
	public void testRegister() throws Exception{
		
		String resultpage = mockMvc.perform(MockMvcRequestBuilders.post("/T_board/T_register")
				.param("title", "테스트 새글 제목 ")
				.param("content", "테스트 새글 내용 ")
				.param("writer", "user00")).andReturn().getModelAndView().getViewName();
		log.info(resultpage);
	}
	
	@Test
    public void testGet() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/T_board/T_get")
				.param("bno", "2"))
				.andReturn()
				.getModelAndView().getModelMap());
	}
	@Test 
	public void testModify() throws Exception {
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/T_board/T_modify")
				.param("bno", "1")
				.param("title", "수정된 테스트 새글 제목 ")
				.param("content", "수정된 새글 내용 ")
				.param("writer", "user00"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test 
	public void testRemove() throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/T_board/T_remove")
				.param("bno", "9"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
}
