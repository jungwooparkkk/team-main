package org.zerock.service.travel;

import java.util.List;

import org.zerock.domain.travel.T_BoardVO;
import org.zerock.domain.travel.T_LikesVO;

public interface T_LikesService {

	public int likescount(T_LikesVO vo);
	
	public int likesgetinfo(T_LikesVO vo);
	
	public void likesinsert(T_LikesVO vo);
	
	public void likesupdate(T_LikesVO vo);

	public List<Long> getLikeList(String name);

	public Long getLikeClicked(String userid, Long bno);

}
