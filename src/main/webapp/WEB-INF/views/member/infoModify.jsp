<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bd" tagdir="/WEB-INF/tags/board" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>

<script>

 
 $(document).ready(function() {
	$("#changePhoto").on("click",function(e){
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		console.log(files);
	})
})
 



$(function() {

	
	var exPasswordModal = $("#ex-password-modal");
	var selectButton ="";
	
	
	$("#modifyBtn").click(function(e) {
		e.preventDefault();
		selectButton = "modify-button";
		exPasswordModal.modal('show');
	});
	
	$("#expassword-modal-btn").click(function() {
		switch(selectButton){
			case "modify-button" :
				$("#member-info-form1")
				.attr("action","${appRoot}/member/modifyMem")
				.submit();
			break;
		}

	});
	/* 비밀번호/확인 여부에 따른 수정버튼 활성화*/
	$("#inputPassword, #passwordCheck").keyup(function() {
		var newPw = $("#inputPassword").val();
		var newPwCheck = $("#passwordCheck").val();
		var modifyBtn = $("#modifyBtn");
		
		if(newPw != newPwCheck){
			modifyBtn.attr("disabled", "disabled");
			$("#member-info-password-message").text("비밀번호가 일치하지 않습니다.");
		} else {
			if(newPw == ""){
				$("#member-info-password-message").text("비밀번호를 입력해주세요.");
			}else{
			modifyBtn.removeAttr("disabled");
			$("#member-info-password-message").empty();
			}
			
		}
	});
	
	$("#toggle-password-btn").click(function() {
	      var inputPw = $("#inputPassword")
	      
	      if(inputPw.attr("type") == "password"){
	         inputPw.attr("type","text");
	         $("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-slash");
	      }else{
	         inputPw.attr("type","password");
	         $("#toggle-password-icon").removeClass("fa-eye-slash").addClass("fa-eye");
	      }
   });
	
	$("#change-file-btn").click(function() {
		$("#profile-file").click();
	});
	
	$("#profile-file").change(function(e) {
		$("#imgBasic").attr("src", URL.createObjectURL(e.target.files[0]));
	});
		
});
 

 
</script>	
</head>
<style>

hr.distinct{
border : none;

}

#imgBasic{ 
 width : 120px;
 height: 120px;
 border-radius: 70%;
}
</style>

<body>
<div class="container">
<%-- 
	<c:if test="${param.status == 'success' }">
 		<div id="alert1" class="alert alert-primary" role="alert">
 
			회원 정보를 수정하였습니다.
		</div>
	</c:if>
	
	<c:if test="${param.status == 'error' }">
		<div id="alert1" class="alert alert-danger" role="alert">
			회원 정보 수정을 할 수 없습니다.
		</div>
	</c:if>
		 --%>
	<div class = "modify-form">
		<h1> 회원 정보 </h1>
<hr>
		<form id = "profileUpdate" action="${appRoot }/member/uploadAction" method="post" enctype="multipart/form-data">
		
				<input value="${pinfo.member.userid }" type="hidden" class="form-control" name="userid" value="${pinfo.member.userid }" readonly>
			
			<div class="mb-3 row">
				<label for="changePhoto">프로필 사진</label>
			<div class="col-sm-5">
				<img id="imgBasic"
				
				 <c:if test="${empty members.fileName }">
			    	  src="${profile }basicProfile/basicImage.png"
			    	  </c:if>
			    	  
			    	  <c:if test="${not empty members.fileName }" >
  			    	  src="${profile }${members.userid }/${members.fileName }"
			    	  </c:if>
			    	  
			    	  > 
			
				<hr class="distinct">
			<!-- 	<input type="file" id="photo-upload" class="changePhoto" accept="img/*"> -->
			<div class="col-sm-5">
				<input type="file" hidden class="btn btn-light" id="profile-file" name="file">
				<button id="change-file-btn" type="button" class="btn btn-light col ">사진 변경</button>
				<button class=" btn btn-light" type="submit" name="changePhoto" id ="changePhoto">적용 </button>
				<button class="btn btn-light" type="submit" id="removePhoto">삭제</button>
			</div>	
			</div>
			</form>
		</div>
	</div>
				</div>
	 
	<form id="member-info-form1" method="post" action="${appRoot }/member/infoModify">	
		  <div class="mb-3 row">
		    <label for="userid" class="col-sm-2 col-form-label" >아이디</label>
		    <div class="col-sm-5">
		      <input value="${pinfo.member.userid }" type="text" class="form-control-plaintext" id="userid" name="userid"value="${pinfo.member.userid }" readonly>
		    </div>
		  </div>
			
		  <div class="mb-3 row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-5">
		      <input type="password" class="form-control" id="inputPassword" name="userpw">
			 	<button class="btn btn-outline-secondry" type="button" id="toggle-password-btn">
				<i id="toggle-password-icon" class = "far fa-eye"></i></button>
			
		    </div>
		  </div>
		  
		  
		    <div class="mb-3 row">
		    <label for="passwordCheck" class="col-sm-2 col-form-label">비밀번호확인</label>
		    <div class="col-sm-5">
		      <input type="password" class="form-control" id="passwordCheck">
		    </div>
		  </div>
		  
		  
		   <div class="mb-3 row">
		    <label for="nick" class="col-sm-2 col-form-label">닉네임</label>
		    <div class="col-sm-5">
		      <input value="${pinfo.member.nickName }" type="text" class="form-control" id="nick" name="nickName">
		    </div>
		  </div>
		  
		   <div class="mb-3 row">
		    <label for="addr" class="col-sm-2 col-form-label">주소</label>
		    <div class="col-sm-10">
		      <input value="${pinfo.member.address }" type="text" class="form-control" id="addr" name="address">
		    </div>
		  </div>
			
		   <div class="mb-3 row">
		    <label for="email" class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-5">
		      <input value="${pinfo.member.email }" type="text" class="form-control" id="email" name="email" >
		    </div>
		  </div>
		  
		   <div class="mb-3 row">
		    <label for="phone" class="col-sm-2 col-form-label">연락처</label>
		    <div class="col-sm-5">
		      <input value="${pinfo.member.phoneNum }" type="text" class="form-control" id="phone" name="phoneNum" >
		    </div>
		  </div>
		  </form>
	<!-- 	  <input type="submit" id="modifyBtn" value="수정하기"> -->
		  <button disabled type="submit" name="modifybtn" id="modifyBtn" class="btn btn-primary"> 수정하기</button>
		  
 	<div class="modal fade" id="ex-password-modal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">기존 비밀번호 입력</h5>
	      </div>
	      <div class="modal-body">
	      	<div class="form-group">
	      		<label for="ex-password-input">기존 비밀번호</label>
	      		<input form="member-info-form1" class="form-control" name="exPassword" id="ex-password-input" type="password">
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        <button type="button" id="expassword-modal-btn" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
 </div>
</div>
</body>
</html>