package org.zerock.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.zerock.domain.MemberVO;

import lombok.Getter;
import lombok.Setter;

public class PersoUser extends User{
	
	@Getter
	@Setter
	private MemberVO member;
	
	public PersoUser(String username, String password, Collection<? extends GrantedAuthority> authorities ) {
		super(username, password, authorities);
	}
	
	public PersoUser(MemberVO mem) {
		super(mem.getUserid(),mem.getUserpw(),mem.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		member = mem;
		
		
	}

}
