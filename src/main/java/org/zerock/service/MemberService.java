package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {

	boolean insert(MemberVO mem);

	MemberVO read(String name);
	
	boolean modify(MemberVO mem);

	boolean delete(MemberVO mem);
	
	boolean modify(MemberVO mem, String exPassword);

	boolean delete(MemberVO mem, String exPassword);
	
	MemberVO check(String email);
	




	

	
	
}
