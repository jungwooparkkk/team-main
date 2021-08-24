package org.zerock.service.travel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.travel.T_BoardVO;
import org.zerock.domain.travel.T_LikesVO;
import org.zerock.mapper.travel.T_LikesMapper;

import lombok.Setter;

@Service
public class T_LikesServicImpl implements T_LikesService {

	@Setter(onMethod_= @Autowired)
	public T_LikesMapper mapper;
	
	public int likescount(T_LikesVO vo) {
		return mapper.likescount(vo);
	}
	
	public int likesgetinfo(T_LikesVO vo) {
		return mapper.likesgetinfo(vo);
	}
	
	public void likesinsert(T_LikesVO vo) {
		mapper.likesinsert(vo);
	}
	
	public void likesupdate(T_LikesVO vo) {
		if (mapper.likesupdate(vo) == 0) {
			mapper.likesinsert(vo);
		}
	}

	@Override
	public List<Long> getLikeList(String userid) {
		return mapper.likeList(userid);
	}

	@Override
	public Long getLikeClicked(String userid, Long bno) {
		// TODO Auto-generated method stub
		return mapper.likeClicked(userid, bno);
	}
}
