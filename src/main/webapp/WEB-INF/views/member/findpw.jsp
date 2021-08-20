<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>비밀번호 찾기</title>

<style>
div.container {
  border: 15px solid transparant;
  margin: 110px; 
}
</style>

<script type="text/javascript">


	//이메일 정보매칭해서 비밀번호 재설정하기
	$(function() {
		 $("#findmailBtn").click(function() {
			var emailVal = $("#find-pw-email").val();
			var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
			var validMail = false;
			if(emailVal == ""){
				alert("이메일을 입력해주세요.")
			}else if (!regmail.test(emailVal)){
				alert("올바른 형식으로 작성해주세요.")
			}else{
				var data = {email : emailVal};
				$.ajax({
					type : "get",
					url : "${appRoot}/member/newpassword",
					data : data,
					success : function (data) {
						if(data[0] == "exist"){	
							alert("해당 이메일 주소로 새로운 임시 비밀번호를 발송 했습니다. 임시 비밀번호로 로그인 후 비밀번호 변경해주세요.");
							console.log("이미 회원 가입되어 있는 이메일")
							validMail = true;
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
			
		
	});
	
	
</script>
</head>

<tv:navbar></tv:navbar>

<body>



	<div class="container">
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
	</div>
</body>
</html>