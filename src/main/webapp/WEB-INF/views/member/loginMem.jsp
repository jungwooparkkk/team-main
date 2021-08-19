
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/board" %>


<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>로그인 화면</title>
</head>

<tv:navbar></tv:navbar>
<h1>정보수정필요</h1>


<body>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-md-6 col-7">
					<h1>로그인</h1>

			<form action="${appRoot }/login" method="post">
				<div class="form-group">
					<label for="input1">아이디</label>				
					<input id="input1" class="form-control" name="username" />
				</div>
				<div class="form-group">
					<label for="input2">패스워드</label>
					<input id="input2" type="password" 
					class="form-control" name="password" />
				</div>
				
				<input class="btn btn-primary" type="submit" value="로그인">

			</form>
			
				<div class = "form-check">
					<label class="form-check-label" for="checkbox">remember me</label>
					<input name="remember-me" type="checkbox" class="form-check-input" id="checkbox">
				</div>
				
			<div class="form-row">
				<div class="find-info">
					<a href="${appRoot }/member/findid"></a>
					<form action="${appRoot }/member/findid" method="get">
							<input class="btn btn-light" type="submit" value="아이디 찾기">
					</form>		
				</div>
				<div class="find-info">
					<form action="${appRoot }/member/findpw" method="post">
							<input class="btn btn-light" type="submit" value="비밀번호 찾기">
					</form>
				</div>
			 
			<form action="${appRoot }/member/signupMem" method="post">
				<div class="find-info" >
					<a class="btn btn-light" href="${appRoot }/member/signupMem">
					회원가입
					</a>
				</div>
			</form>
			</div>
		</div>
			
	</div>
</div>
</body>
</html>