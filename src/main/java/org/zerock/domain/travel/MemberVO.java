package org.zerock.domain.travel;
import java.util.List;
import lombok.Data;

@Data
public class MemberVO {

	private String userid;
	private String userpw;
	private String nickName;
	private String address;
	private String email;
	private String phoneNum;
	private boolean enabled;
	
	private List<AuthVO> authList;
}
