package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.EatLikesVO;

public interface EatLikesMapper {

	
	public int likescount(EatLikesVO vo);
	
	public int likesgetinfo(EatLikesVO vo);
	
	public void likesinsert(EatLikesVO vo);
	
	public int likesupdate(EatLikesVO vo);

	public List<Long> likeList(String userid);

	public Long likeClicked(@Param("userid") String userid, @Param("eatbno") Long eatbno);

}
