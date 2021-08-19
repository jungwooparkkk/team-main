package org.zerock.mapper.travel;

import javax.servlet.http.HttpServletResponse;

import org.zerock.domain.travel.AuthVO;
import org.zerock.domain.travel.MemberVO;

public interface MemberMapper {
	
	public int insert(MemberVO mem);

	public void insertAuth(AuthVO authi);

	public MemberVO read(String userid);

	public int update(MemberVO mem);

	public int delete(MemberVO mem);

	public void deleteAuth(MemberVO mem);
	
	public void findInfo(MemberVO mem);

	public void read(MemberVO mem);

	public void findid(HttpServletResponse response, MemberVO mem);
	
	
}
