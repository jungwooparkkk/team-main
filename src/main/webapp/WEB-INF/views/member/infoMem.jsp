<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>

<script>
$(function() {
	var exPasswordModal = $("#ex-password-modal");
	var selectButton ="";
	
	$("#ex-password-modal").click(function() {
		switch (selectButton) {
			case "modify-button" :
				$("#member-info-form1")
				.attr("action","${appRoot}/member/modifyMem")
				.submit();
			break;
			case "delete-button" :
				$("#member-info-form1")
				.attr("action", "${appRoot}/main/deleteMem")
				.submit();
			break;
		}
	});
	
	$("#member-info-modify-btn1").click(function(e) {
		e.preventDefault();
		selectButton="modify-button";
		exPasswordModal.modal('show');
	});
	
	$("#member-info-delete-btn1").click(function() {
		var ment = confirm("정말로 탈퇴 하시겠습니까?");
		selectButton = "delete-button";
		
		if(ment){
			exPasswordModal.modal('show');
		}
	});
	
	$("#member-info-input2, #member-info-input4").keyup(function( ) {
		var nowPw = $("#member-info-input2").val();
		var exPw = $("member-info-input4").val();
		var modifyBtn = $("#member-info-modify-btn1");
		
		if(nowPw != exPw){
			modifyBtn.attr("disabled", "disabled");
			$("member-info-password-message").text("패스워드가 일치하지 않습니다.");
		} else {
			if(pw == ""){
				modifyBtn.removeAttr("disabled");
				$("#member-info-password-message").empty();
			}
		}
	});
	
	$("#toggle-password-btn").click(function() {
		var inputPw = $("#member-info-input2")
		
		if(inputPw.attr("type") == "password"){
			inputPw.attr("type","text");
			$("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-low-vision");
		}else{
			inputPw.attr("type","password");
			$("#toggle-password-icon").removeClass("fa-eye-low-vision").addClass("fa-eye");
		}
	});
	
});

</script>
</head>
<body>
<div class="container">
	<c:if test="${param.status == 'success' }">
	<div class="alert alert-success d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
  <div>
    회원 정보 수정에 성공했습니다.
  </div>
</div>
	</c:if>
	
	<c:if test="${param.status == 'error' }">
	<div class="alert alert-danger d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
 	 <div>
    회원 정보 수정에 실패했습니다.
  	</div>
</div>
	</c:if>
	
	<h1>회원 정보</h1>
	<div class="row">
		<div class="col-12">
			<form id="member-info-form1" method="post" action="${appRoot }/main/modify">
					<div class="form-group">
					  <label for="member-info-inputid" > 아이디</label>
					  <input readonly value="${mem.userid }" type="text" class="form-control" id="member-info-inputid" name="userid" placeholder="아이디를 입력해주세요.">
					</div>
					<div class="form-group">
					  <label for="member-info-inputpw">새 비밀번호</label>
					  <input type="text" class="form-control" id="member-info-inputpw" placeholder="비밀번호를 입력해주세요.">
					  
					  <div class="input-group">
					  	<input type="password" class="form-control" id="member-info-inputpw" name="userpw">
					  	
					  <div class="input-group-append">
					  	<button class="btn btn-outline-secondry"
					  			type="button"
					  			id="toggle-password-btn">
					  			
					  			<i id="toggle-password-icon" class = "far fa-eye"></i>
					  			</button>
					  </div>
				  </div>
				</div>
				
				<div class="form-group">
					<label for="member-info-inputpwCheck">새 비밀번호 확인</label>
					<input type="password" class="form-control" id="member-info-inputpwCheck">
					<small id="member-info-password-message" class="form-text text-danger"></small>
				</div>
				
				<div class="form-group">
					<label for="member-info-nick">닉네임</label>
					<input value="${mem.nickName }" type="text" class="form-control" id="member-info-nick" name="nickName">
				</div>
				
				<button disabled type="submit" class="btn btn-secondary" id="member-info-modify-btn1">정보 수정</button>
				<button type="submit" class="btn btn-danger" id="member-info-delete-btn1">회원 탈퇴</button>
			</form>	
		</div>
	</div>
	
	<div class="modal fade" id="ex-password-modal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">기존 비밀번호 입력</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal">
	        	<span>&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="form-group">
	      		<label for="ex-password-input">기존 비밀번호</label>
	      		<input form="member-info-form1" class="form-control" name="exPassword" id="ex-password-input" type="password">
	      	</div>
	        <p>Modal body text goes here.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" id="ex-password-modal-btn" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
</body>
</html>