package org.zerock.mapper.travel;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.travel.T_LikesVO;

public interface T_LikesMapper {

	
	public int likescount(T_LikesVO vo);
	
	public int likesgetinfo(T_LikesVO vo);
	
	public void likesinsert(T_LikesVO vo);
	
	public int likesupdate(T_LikesVO vo);

	public List<Long> likeList(String userid);

	public Long likeClicked(@Param("userid") String userid, @Param("bno") Long bno);

}
