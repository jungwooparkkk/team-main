package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
@Service
@Repository
public class MemberServiceimpl implements MemberService {
	@Setter(onMethod_=@Autowired)
	private MemberMapper map;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder encoder;
	
	@Override
	@Transactional
	public boolean insert(MemberVO mem) {
		mem.setUserpw(encoder.encode(mem.getUserpw()));
		int cnt = map.insert(mem);
		
		AuthVO auth = new AuthVO();
		auth.setUserid(mem.getUserid());
		auth.setAuth("ROLE_USER");
		map.insertAuth(auth);
		
		return cnt == 1;
	}

	@Override
	public MemberVO read(String name) {
		
		return map.read(name);
	}

	@Override
	public boolean modify(MemberVO mem, String exPassword) {
		MemberVO ex = map.read(mem.getUserid());
		
		if(encoder.matches(exPassword, ex.getUserpw())) {
			return modify(mem);
		}
		return false;
	}

	@Override
	public boolean modify(MemberVO mem) {
		mem.setUserpw(encoder.encode(mem.getUserpw()));
		
		int cnt = map.update(mem);
		
		return cnt == 1;
	}

	@Override
	public boolean delete(MemberVO mem, String exPassword) {
		MemberVO ex = map.read(mem.getUserid());
		if(encoder.matches(exPassword, ex.getUserpw())) {
			return delete(mem);
		}
		return false;
	}

	@Override
	@Transactional
	public boolean delete(MemberVO mem) {
		

		map.deleteAuth(mem);
		
		int cnt = map.delete(mem);
		
		return cnt == 1;
	}

	
}
