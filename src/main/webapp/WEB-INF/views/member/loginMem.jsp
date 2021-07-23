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
		<div class="col-md-6 col-12">
					<h1>로그인</h1>
			<form action="${appRoot }/member/loginMem" method="post">
				<div class="form-group">
					<label for="innick">닉네임</label>
					<input id="nick" class="form-control" name="nickName">
				</div>
				<div class="form-group">
					<label for="inpw">비밀번호</label>
					<input id="inpw" type="password" class=form-control" name="userpw" />
				</div>
				
				<div class="form-group d-flex">
					<input class="btn btn-primary" type="submit"  style="width:260px;" value="로그인">
				</div>
			</form>
			
				<div class = "form-group form-check">
					<label class="form-check-label" for="checkbox">remember me</label>
					<input name="remember-me" type="checkbox" class="form-check-input" id="checkbox">
				</div>
				
		<div class="find_info">
				<a href="${appRoot }/home/findid"></a>
				<form action="${appRoot }/member/findid" method="get">
						<input class="btn btn-primary" type="submit" value="아이디 찾기">
				</form>		
						
				<form action="${appRoot }/member/findpw" method="post">
						<input class="btn btn-primary" type="submit" value="비밀번호 찾기">
				</form>
				</div>
			
			<form action="${appRoot }/member/signupt" method="post">
				<div class="form-group" >
					<small>아직 회원이 아니신가요?</small><br>
					<input class="btn btn-secondary" type="submit" value="회원가입">
				</div>
			</form>
			
		</div>
	</div>
</div>
</body>
</html>