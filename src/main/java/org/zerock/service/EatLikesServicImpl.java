package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.EatBoardVO;
import org.zerock.domain.EatLikesVO;
import org.zerock.mapper.EatLikesMapper;

import lombok.Setter;

@Service
public class EatLikesServicImpl implements EatLikesService {

	@Setter(onMethod_= @Autowired)
	public EatLikesMapper mapper;
	
	public int likescount(EatLikesVO vo) {
		return mapper.likescount(vo);
	}
	
	public int likesgetinfo(EatLikesVO vo) {
		return mapper.likesgetinfo(vo);
	}
	
	public void likesinsert(EatLikesVO vo) {
		mapper.likesinsert(vo);
	}
	
	public void likesupdate(EatLikesVO vo) {
		 if (mapper.likesupdate(vo) == 0) {
	         mapper.likesinsert(vo);
		 }
	}

	@Override
	public List<Long> getLikeList(String userid) {
		return mapper.likeList(userid);
	}

	@Override
	public Long getLikeClicked(String userid, Long eatbno) {
		// TODO Auto-generated method stub
		return mapper.likeClicked(userid, eatbno);
	}
}
