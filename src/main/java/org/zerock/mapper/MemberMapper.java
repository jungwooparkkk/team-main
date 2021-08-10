package org.zerock.mapper;
//modi
import javax.servlet.http.HttpServletResponse;

import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;

public interface MemberMapper {
	
	public int insert(MemberVO mem);

	public void insertAuth(AuthVO auth);

	public MemberVO read(String userid);

	public int update(MemberVO mem);

	public int delete(MemberVO mem);

	public void deleteAuth(MemberVO mem);
	
	public MemberVO check(String email);

	
	
}
