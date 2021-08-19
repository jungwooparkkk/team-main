package org.zerock.domain.travel;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class T_LikesVO {

	private String userid;
	private Long bno;
	private Long lno;
	
	private Long count;

}
