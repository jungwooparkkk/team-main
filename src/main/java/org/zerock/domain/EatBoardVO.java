package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EatBoardVO {

	private long eatbno;
	private String title;
	private String content;
	private String adress;
	private String writer;
	private Date regdate;
	private Date updatedate;
}
