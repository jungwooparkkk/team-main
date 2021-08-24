package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.LikesVO;
import org.zerock.mapper.LikesMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class LikesServiceImpl implements LikesService {

	@Setter(onMethod_= @Autowired)
	public LikesMapper mapper;
	
	@Override
	public int likecount(LikesVO vo) {
		
		return mapper.likescount(vo);
	}

	@Override
	public int likesgetinfo(LikesVO vo) {
		
		return mapper.likesgetinfo(vo);
	}

	@Override
	public void likesinsert(LikesVO vo) {
		
		mapper.likesinsert(vo);
		
	}

	@Override
	public void likesupdate(LikesVO vo) {
		log.info(vo);
		if(mapper.likesupdate(vo)== 0) {
			log.info(vo);
			mapper.likesinsert(vo);
		}
		
	}

	@Override
	public List<Long> getLikeList(String userid) {
		
		return mapper.likeList(userid);
	}

	@Override
	public Long getLikeClicked(String userid, Long bno) {
		
		return mapper.likeClicked(userid, bno);
	}

}
