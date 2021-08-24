package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.LikesVO;


public interface LikesService {
	
	public int likecount(LikesVO vo);
	
	public int likesgetinfo(LikesVO vo);
	
	public void likesinsert(LikesVO vo);
	
	public void likesupdate(LikesVO vo);
	
	public List<Long> getLikeList(String name);

	public Long getLikeClicked(String userid, Long bno);
	
	
}
