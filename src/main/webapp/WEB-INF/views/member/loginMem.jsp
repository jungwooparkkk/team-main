<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>


<!DOCTYPE html>
<html>
<head>


<link rel="stylesheet" href="${appRoot }/resources/css/member.css" />


<title>로그인 </title>

</head>

<tv:navbar></tv:navbar>

<body>
<div class="container">

	<div class="row justify-content-center">
		<div class="col-md-6 col-7">	
					<img class="loginLogo" src="${appRoot}/resources/img/logo.jpg">
			<form action="${appRoot }/login" method="post" class="line">
				<div class="form-group">

					<input id="inid" type="text" class="form-control" name="username" placeholder="아이디">
				</div>
				<div class="form-group">	
					 <div class="input-group">
						<input id="inpw" type="password" class="form-control md-3" name="password" placeholder="비밀번호" />
						 <div class="input-group-append">
							 		<button class="btn btn-outline-secondary" type="button" id="toggle-password-btn">
										<i id="toggle-password-icon" class = "far fa-eye"></i>
									</button>
								  </div>
								</div>
				</div>
				
				<div class = "form-group">
					<label class="form-check-label" for="checkbox">자동 로그인</label>
					<input name="remember-me" type="checkbox" class="form-check-label" id="checkbox">
				</div>
	
				<div class="form-group">
					<button name="button" type="submit"  class="form-control btn btn-secondary"  id="loginBtn" tabindex="3">
	       			 로그인 
					</button>
				</div>
				
			</form>
			
			<hr class="col-6">
			
			<div class="row justify-content-center">

				<div class="find-info">	
					<a class="btn btn-light"  href="${appRoot }/member/findid">아이디 찾기</a>
					<a class="btn btn-light" href="${appRoot }/member/findpw"> 비밀번호 찾기</a>	
					<a class="btn btn-light" href="${appRoot }/member/signupMem">회원가입</a>
				</div>
			</div>
		</div>
			
	</div>
</div>
</body>
</html>