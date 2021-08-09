package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EatBoardVO {

	private Long eatbno;
	private String title;
	private String content;
	private String address;
	private String writer;
	private String writerName;
	private Date regdate;
	private Date updatedate;
	private int likes;
	private int views;
	
	private int replyCnt;

	private String fileName;
}
