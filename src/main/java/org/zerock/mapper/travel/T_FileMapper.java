package org.zerock.mapper.travel;

import org.zerock.domain.travel.T_FileVO;
import org.zerock.domain.MemberVO;

public interface T_FileMapper {


	public int insert(T_FileVO vo);

	public void deleteByBno(Long bno);

	public void removeByUserid(MemberVO vo);
}

