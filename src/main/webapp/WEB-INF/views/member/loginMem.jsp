<%@ page contentType="text/html; charset=UTF-8"%>


<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>로그인 화면</title>
</head>
<body>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-md-6 col-7">
					<h1>로그인</h1>
			<form action="${appRoot }/member/loginMem" method="post">
				<div class="form-group">
					<label for="inid">아이디</label>
					<input id="inid" class="form-control" name="userid">
				</div>
				<div class="form-group">
					<label for="inpw">비밀번호</label>
					<input id="inpw" type="password" class="form-control" name="userpw" />
				</div>
				
				<div class="form-group">
					<input class="btn btn-primary" type="submit"  style="width:290px;" value="로그인">
				</div>
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
					<input class="btn btn-light" type="submit" value="회원가입">
				</div>
			</form>
			</div>
		</div>
			
	</div>
</div>
</body>
</html>