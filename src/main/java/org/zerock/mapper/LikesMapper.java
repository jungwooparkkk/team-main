package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.LikesVO;

public interface LikesMapper {

	public int likescount(LikesVO vo);
	
	public int likesgetinfo(LikesVO vo);
	
	public void likesinsert(LikesVO vo);
	
	public int likesupdate(LikesVO vo);

	public List<Long> likeList(String userid);

	public Long likeClicked(@Param("userid") String userid, @Param("bno") Long bno);
}
