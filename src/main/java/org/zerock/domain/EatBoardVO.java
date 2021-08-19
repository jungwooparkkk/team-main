package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EatBoardVO {

	private Long eatbno;
	private String title;
	private String content;
	private String address;
	private String kategorie;
	private String writer;
	private String writerName;
	private Date regdate;
	private Date updatedate;
	private int likes;
	private int views;
	
	private boolean likeClicked;
	
	private int replyCnt;
	private int likesCnt;

	private String fileName;
}
