package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EatReplyVO {
	private Long eatrno;
	private Long eatbno;
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	private Long likes;
	
	private String replyerName;
}
