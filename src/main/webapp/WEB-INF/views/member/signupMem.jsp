<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<link rel="stylesheet" href="${appRoot }/resources/css/member.css" />


<title>회원가입</title>
<script>

var appRoot = '${appRoot}';
</script>
<script src="${appRoot }/resources/js/signupMem.js"></script>
 
 
 


</head>

<tv:navbar></tv:navbar>

<body>
<div class="container">
	<c:if test="${param.status == 'success' }">
		<script>
	 		alert('회원가입을 축하드립니다.')
		</script>	
	</c:if>
	
	<c:if test="${not empty param.error }">
			<div id="signup-alert" class="alert alert-danger" role="alert">
  			회원가입에 실패했습니다.
  			</div>
	</c:if>
		<div class="row justify-content-center">	
				<div class="col-md-6 col-7">
					<form id="signup" method="post" action="${appRoot }/member/signupMem">
						<h1>회원가입</h1>
						<div class="form-group">
							<label for="signup-inputid">아이디</label>
							<input required="required" type="text" class="form-control" id="signup-inputid" name="userid">
							
							<button class="btn btn-outline-secondary" type="button" id="id-dupCheck-btn">아이디 중복 확인</button>
							<small id="id-message" class="form-text text-danger"></small>
						</div>
									
						<div class="form-group">
							<label for="signup-input-pw"> 비밀번호 </label>
							  <div class="input-group">
								<input required="required" type="password" class="form-control"  id="signup-input-pw" name="userpw">
							  	 <div class="input-group-append">
							 		<button class="btn btn-outline-secondary" type="button" id="toggle-password-btn">
										<i id="toggle-password-icon" class = "far fa-eye"></i>
									</button>
								  </div>
								</div>
					
							<label for="signup-input-pwCheck">비밀번호 확인</label>
							<input required="required" type="password" class="form-control" id="signup-input-pwCheck">
							<small id="password-message" class="form-text text-danger "></small>
						</div>
			
						<div class="form-group">
							<label for="signup-input-nick">닉네임</label>
							<input type="text" class="form-control" id="signup-input-nick" name="nickName">
							
							<button class="btn btn-outline-secondary" type="button" id="nick-dupCheck-btn" name="nickname">중복 확인</button>
							<small id="nickname-message" class="form-text text-danger"></small>
						</div>
						
				 		 <div class="form-group">
							 <label for="signup-input-address"> 주소 </label><br>
						 	 <input type="text" class="zip_code" id="zipNo" readonly>
							 <button type="button" class="zip_code_btn" id="addr-input-btn" onclick="javascript:goPopup();">우편번호</button>
							 <br/> 				
							 <input type="text" class="address" id="address" readonly>
							 <input type="text" class="addrDetail" id="addrDetail" readonly><br><br>
							 <input name="address" type="hidden" id="fullAddressInput">
						</div>
						
						<div class="form-group">
				 			<label for="signp-input-email"> 이메일 주소 </label><br>
				   			<input required="required" type="email" class="form-control" id="signup-input-email" placeholder="e-mail@gmail.com" name="email">
							<small id="email-message" class="form-text text-danger"></small>
						</div>
			
						<div class="form-group">
							<label for="signup-input-phoneNum"> 연락처 </label>
							<input required="required" type="text" class="form-control" id="signup-input-phoneNum" name="phoneNum">
							<small id="phone-message" class="form-text text-danger"></small>
						</div>
			
							<button disabled type="submit" class="btn btn-primary" id="signup-btn">회원 가입</button>
				</form>
			</div>
		</div>
	</div>		
</body>
</html>