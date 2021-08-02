package org.zerock.domain;

import lombok.Data;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

@Data
public class BoardVO {
	private long bno;
	
	private String title;
	private String content;
	private String writer;
	
	private Date regdate;
	private Date updateDate;
	
	private long views;
	private long good;
}
