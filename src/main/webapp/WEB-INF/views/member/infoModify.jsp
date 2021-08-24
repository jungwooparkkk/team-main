<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<link rel="stylesheet" href="${appRoot }/resources/css/member.css" />

<title>회원 정보 수정</title>
<script>
var appRoot = '${appRoot}';
</script>
<script src="${appRoot }/resources/js/infoModify.js"></script>

</head>


<tv:navbar></tv:navbar>

<body>
<div class="container">
		
		
		<form id = "profileUpdate" action="${appRoot }/member/uploadAction" method="post" class="line" enctype="multipart/form-data">
			<h1> 회원 정보 </h1>
			<hr>
		
				<input value="${pinfo.member.userid }" type="hidden" class="form-control" name="userid" value="${pinfo.member.userid }" readonly>
			
			<div class="mb-3 row">
				<label for="changePhoto" class="col-sm-2 col-form-label">프로필 사진</label>
				<div class="col-sm-5">
					<img id="imgBasic"
					
					 <c:if test="${empty members.fileName }">
				    	  src="${profile }basicProfile/basicImage.png"
				    	  </c:if>
				    	  
				    	  <c:if test="${not empty members.fileName }" >
	  			    	  src="${profile }${members.userid }/${members.fileName }"
				    	  </c:if>
				    	  
				    	  >  d
			
				
				<!-- 	<input type="file" id="photo-upload" class="changePhoto" accept="img/*"> -->
				
					<input type="file" hidden class="btn btn-light" id="profile-file" name="file">
					<button id="change-file-btn" type="button" class="btn btn-light" name="change-file-btn">사진 변경</button>
					<button class=" btn btn-light" type="submit" name="changePhoto" id ="changePhoto">적용 </button>
					<button class="btn btn-light" type="submit" id="removePhoto" name="removePhoto">삭제</button>
				</form>
				</div>		
			</div>
	 
	<form id="member-info-form1" method="post" class="line" action="${appRoot }/member/infoModify">	
		  <div class="mb-3 row">
		    <label for="userid" class="col-sm-2 col-form-label" >아이디</label>
			    <div class="col-sm-5">
			      <input value="${pinfo.member.userid }" type="text" class="form-control-plaintext" id="userid" name="userid" value="${pinfo.member.userid }" readonly>
			    </div>
		  </div>
			
		  <div class="mb-3 row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
			    <div class="col-sm-5 input-group">
			      <input type="password" class="form-control" id="inputPassword" name="userpw">
				      <div class="input-group-append">
					 	<button class="btn btn-outline-secondary" type="button" id="toggle-password-btn">
						<i id="toggle-password-icon" class = "far fa-eye"></i>
						</button>
				      </div>
			    </div>
		   </div>
		 
		  
		    <div class="mb-3 row">
		   		 <label for="passwordCheck" class="col-sm-2 col-form-label">비밀번호확인</label>
				    <div class="col-sm-5">
				      <input type="password" class="form-control" id="passwordCheck">
				      <small id="member-info-password-message" class="form-text text-danger"></small>
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
			    <div class="col-sm-7">
			      <input value="${pinfo.member.address }" type="text" class="form-control" id="addr" name="address">
			      <input type="text" class="zip_code" id="zipNo" readonly>
				  <button type="button" class="zip_code_btn" id="addr-input-btn" onclick="javascript:goPopup();">우편번호</button>
				  <br/> 				
		    		 <input type="text" class="address" id="address" readonly>
			    	 <input type="text" class="addrDetail" id="addrDetail" readonly><br><br>
					 <input name="address" type="hidden" id="fullAddressInput">
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

		  <button disabled type="submit" name="modifybtn" id="modifyBtn" class="btn btn-primary"> 수정하기</button>
		  </form>
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
	      		<input form="member-info-form1" class="form-control" name="exPassword" id="ex-password-input" type="password">
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
	        <button type="button" id="expassword-modal-btn" class="btn btn-success">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
 </div>
</div>
</body>
</html>