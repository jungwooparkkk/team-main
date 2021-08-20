package org.zerock.domain;

import lombok.Data;

@Data
public class LikesVO {
	
	private String userid;
	private long bno;
	private long lno;
	
	private long count;
}
