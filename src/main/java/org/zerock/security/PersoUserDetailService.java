package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
<<<<<<< HEAD
import org.zerock.domain.travel.MemberVO;
import org.zerock.mapper.travel.MemberMapper;
=======
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
>>>>>>> branch 'master' of https://github.com/twp3379/team-main.git
import org.zerock.security.domain.PersoUser;

import lombok.Setter;

public class PersoUserDetailService implements  UserDetailsService{

	@Setter(onMethod_ = @Autowired)
	private MemberMapper map;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO mem = map.read(username);

		if(mem == null) {
			throw new UsernameNotFoundException("사용자를 찾을 수 없습니다. nickname : "+ username);
		}
		return new PersoUser(mem);
	}
}
