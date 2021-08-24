<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<link rel="stylesheet" href="${appRoot }/resources/css/member.css" />

<title>비밀번호 찾기</title>



<script>
var appRoot = '${appRoot}';
</script>
<script src="${appRoot }/resources/js/findpw.js"></script>

</head>

<tv:navbar></tv:navbar>

<body>



	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6 col-7">
		 		 <div class="form-group">	
					<form action="${appRoot }/member/findpw" method="get">
		  				<h2>비밀번호 찾기</h2>
		  					<p>비밀번호를 재설정 할 이메일 주소를 입력하세요.</p>
					  
			<%-- 		  		
			<form id="findpw" method="post" action="${appRoot }/member/findpw"> 
			--%>
					
							  <input type="email" class="form-control" id="find-pw-email" name = "email" placeholder="email@gamil.com">	  
					  <button type="submit" id="findmailBtn" class="btn btn-outline-primary" >비밀번호 재설정 이메일 보내기</button>	  			
					  		</form>
						</div>
	 			</div>
			</div>
		</div>

</body>
</html>