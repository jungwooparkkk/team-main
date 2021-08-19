package org.zerock.service.travel;

import org.zerock.domain.travel.MemberVO;

public interface MemberService {
	boolean insert(MemberVO mem);

	MemberVO read(String name);
	
	boolean modify(MemberVO mem);

	boolean delete(MemberVO mem);
	
	boolean modify(MemberVO mem, String exPassword);

	boolean delete(MemberVO mem, String exPassword);
	

	
}
