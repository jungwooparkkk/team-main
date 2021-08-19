package org.zerock.domain.travel;

import java.util.Date;

import lombok.Data;

@Data
public class T_BoardVO {
	private long bno;
	private String title;
	private String content;
	private String writer;
	private String address;
	private long views;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;
	
	private String fileName;
	private String writerName;

}
