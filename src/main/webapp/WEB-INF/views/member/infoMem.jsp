<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<style>
div.container {
  border: 15px solid transparant;
  margin: 110px; 
}
</style>
<title>회원정보</title>

<script>
$(function() {
	var exPasswordModal = $("#ex-password-modal");
	var selectButton ="";
	
	$("#deleteBtn").click(function(e) {
		e.preventDefault();
		var ment = confirm("정말로 탈퇴 하시겠습니까?");
		selectButton = "delete-button";
		
		if(ment){
			exPasswordModal.modal('show');			
		}
	});
	
	$("#ex-password-modal-btn").click(function() {
		switch (selectButton) {
			case "delete-button" :
				$("#member-info-form")
				.attr("action", "${appRoot}/member/deleteMem")
				.submit();
			break;
		}
	});
	
});
	


	

	

</script>
</head>
<style>

#imgBasic{ 
 width : 120px;
 height: 120px;
 border-radius: 70%;
}
</style>
<body>
<div class="container">


	
	<h1>회원 정보</h1>
	<div class="row">
		<div class="col-12">
			<form id="member-info-form" method="post" action="${appRoot }/member/deleteMem">
			
					<div class="form-group">
			    	  <img id="imgBasic" 
			    	  
			    	  <c:if test="${empty members.fileName }">
			    	  src="${profile }basicProfile/basicImage.png"
			    	  </c:if>
			    	  
			    	  <c:if test="${not empty members.fileName }" >
  			    	  src="${profile }${members.userid }/${members.fileName }"
			    	  </c:if>
			    	  
			    	  
			    	  > 
					</div> 
					
					<div class="form-group">
					  <label for="member-info-inputid" > 아이디</label>
					  <input readonly value="${pinfo.member.userid }" type="text" class="form-control" id="member-info-inputid" name="userid" >
					</div>

				<div class="form-group">
					<label for="member-info-nick">닉네임</label>
					<input value="${pinfo.member.nickName }" type="text" class="form-control" id="member-info-nick" name="nickName">
				</div>
				
				<div class="form-group">
					<label for="member-info-addr">주소</label>
					<input value="${pinfo.member.address }" type="text" class="form-control" id="member-info-addr" name="address">
				</div>
				
				<div class="form-group">
					<label for="member-info-mail">이메일</label>
					<input value="${pinfo.member.email }" type="email" class="form-control" id="member-info-mail" name="email">
				</div>
				
				<div class="form-group">
					<label for="member-info-phone">연락처</label>
					<input value="${pinfo.member.phoneNum }" type="text" class="form-gontrol" id="member-info-phone" name="phoneNo">
				</div>
				
				<a class="btn btn-secondary" href="${appRoot }/member/infoModify">정보 수정</a>
			<!-- 	<button disabled type="submit" class="btn btn-secondary" id="member-info-modify-btn">정보 수정</button> -->
				<button type="submit" class="btn btn-danger" id="deleteBtn">회원 탈퇴</button>
			</form>	
		</div>
	</div>
 	<div class="modal fade" id="ex-password-modal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">기존 비밀번호 입력</h5>
	      </div>
	      <div class="modal-body">
	      	<div class="form-group">
	      		<label for="ex-password-input">기존 비밀번호</label>
	      		<input form="member-info-form" class="form-control" name="exPassword" id="ex-password-input" type="password">
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        <button type="button" id="ex-password-modal-btn" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>	

</div>
</body>
</html>