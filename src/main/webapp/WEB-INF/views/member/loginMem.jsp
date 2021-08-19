
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>


<title>로그인 화면</title>

</head>

<tv:navbar></tv:navbar>

<body>
<div class="container">

	<div class="row justify-content-center">
		<div class="col-md-6 col-7">
					<h1>로그인</h1>
			<form action="${appRoot }/login" method="post">
				<div class="form-group">

					<input id="inid" type="text" class="form-control" name="username">
				</div>
				<div class="form-group">
					<label for="inpw">비밀번호</label>
					<input id="inpw" type="password" class="form-control" name="password" />
				</div>
				
	
				<div class="form-group">
					<button name="button" type="submit" id="loginBtn" class="btn btn-primary btn-block" tabindex="3">
	       			 로그인 
					</button>
				</div>
				
			</form>
			
				<div class = "form-check">
					<label class="form-check-label" for="checkbox">remember me</label>
					<input name="remember-me" type="checkbox" class="form-check-label" id="checkbox">
				</div>
				
			<div class="form-row">

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