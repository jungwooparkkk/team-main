package org.zerock.domain.travel;

import java.util.Date;

import lombok.Data;

@Data
public class T_ReplyVO {
	private long rno;
	private long bno;
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	
	private String replyerName;
}
