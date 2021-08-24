<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${appRoot }/resources/css/member.css" />
<tv:navbar></tv:navbar>


<title>아이디 찾기</title>
<script>
var appRoot = '${appRoot}';
</script>
<script src="${appRoot }/resources/js/findid.js"></script>

</head>


<body>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6 col-7">
			 	<div class="form-group">
					<form id="findid" method="get" action="${appRoot }/member/findid">
				  		<h2>아이디 찾기</h2>
				  			<p>회원가입 시 입력한 이메일 주소를 입력하세요.</p>
				  				 <label for="find-pw-email" class="form-label">이메일</label>
								 <input type="email" class="form-control" id="find-pw-email" name = "email" placeholder="email@gmail.com">
								<button type="button" id="findmailBtn" class="btn btn-outline-primary">가입한 아이디 확인하기</button>
					</form>	
		 		</div>
			</div>
		</div>
	</div>

</body>
</html>