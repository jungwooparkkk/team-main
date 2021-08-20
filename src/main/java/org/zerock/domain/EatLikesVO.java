package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EatLikesVO {

	private String userid;
	private Long eatbno;
	private Long eatlno;
	
	private Long count;

}
