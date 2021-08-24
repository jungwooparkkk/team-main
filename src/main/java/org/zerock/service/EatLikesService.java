package org.zerock.service;

import java.util.List;

import org.zerock.domain.EatBoardVO;
import org.zerock.domain.EatLikesVO;

public interface EatLikesService {

	public int likescount(EatLikesVO vo);
	
	public int likesgetinfo(EatLikesVO vo);
	
	public void likesinsert(EatLikesVO vo);
	
	public void likesupdate(EatLikesVO vo);

	public List<Long> getLikeList(String name);

	public Long getLikeClicked(String userid, Long eatbno);

}
