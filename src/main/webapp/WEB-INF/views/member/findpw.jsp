<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>

<!--
public void findpwPost(HttpSession session, @RequestParam String id, @RequestParam String email, RedirectAttributes rttr) {
		MemberVO user = service.read(email);
		if (user != null) {
			if(!user.getUserid().equals(id)) {
				rttr.addFlashAttribute("resultMsg", "입력하신 이메일의 회원정보와 가입된 아이디가 일치하지 않습니다.");
				return "redirect:${appRoot}/member/findpw";
			}else {
				int ranNo = (int)(Math.random() * (99999-10000 + 1)) + 10000;
				String pwd = String.valueOf(ranNo);
				service.modify(user.getEmail(),"pwd",pwd);
				
				String subject = "임시 비밀 번호 발급 안내";
				StringBuilder bds = new StringBuilder();
				bds.append("임시 비밀번호는" + pwd + "입니다.");
				esvc.send(subject, bds.toString(),"testaddr67@gmail.com",email);
				rttr.addFlashAttribute("resultMsg", "해당 이메일 주소로 새로운 임시 비밀번호를 발송 했습니다.");
			}else {
				rttr.addFlashAttribute("resultMsg", "해당 이메일로 가입된 내역이 없습니다.");
			}
			return "redirect:${appRoot}/member/findpw";
		}
  -->
<script type="text/javascript">


	//이메일 정보매칭해서 비밀번호 재설정하기
	$(function() {
		
	//		var orEmail = document.getElementByID("email").value;
		 $("#findmailBtn").click(function() {
			var emailVal = $("#find-pw-email").val();
			var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
			var validMail = false;
			if(emailVal == ""){
				alert("이메일을 입력해주세요.")
			}else if (!regmail.test(emailVal)){
				alert("올바른 형식으로 작성해주세요.")
			}else{
			
				$.ajax({
					type : "get",
					url : "${appRoot}/member/checkMail",
					data : data,
					success : function data() {
						if(data == "exist"){
							alert("입력한 이메일로 임시비밀번호를 발송했습니다.");
							console.log("이미 회원 가입되어 있는 이메일")
							validMail = true;
							sendMail();
						}else{
							console.log("등록되어 있지 않은 이메일")
							alert("등록되어 있지 않은 이메일입니다. 회원 가입을 진행해주세요.");
						}
					},
					error : function() {
						console.log("이메일 확인 불가")
					}
				})
			}
		})
		 }
	});
	
	
</script>
</head>
<body>



	<div class="row justify-content-center">
		<div class="col-md-6 col-7">
		<form action="${appRoot }/member/findpw" method="get"></form>
	  		<h2>비밀번호 찾기</h2>
	 		 <div class="form-group">	
	  			<p>비밀번호를 재설정 할 이메일 주소를 입력하세요.</p>
				  	<div class="mb-3">
				  		<form id="findpw" method="post" action="${appRoot }/member/findpw">
						  <label for="find-pw-email" class="form-label">이메일</label>
						  <input type="email" class="form-control" id="find-pw-email" name = "email" placeholder="Example input placeholder">	  
				  		</form>
					</div>	  
				  <button type="submit" id="findmailBtn" class="btn btn-outline-primary" >비밀번호 재설정 이메일 보내기</button>
		  	
		  			
 			</div>
		</div>
	</div>

</body>
</html>