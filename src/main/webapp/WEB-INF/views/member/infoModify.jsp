<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1> 회원 정보 </h1>
		
		<div class = "modify-form">
			 <div class="mb-3 row">
				  <label for="formFile" class="form-label">프로필 사진</label>
				   	<div class="col-sm-5">
				  <input class="form-control" type="file" id="formFile">	
					 </div>
			  </div>
			
		  <div class="mb-3 row">
		    <label for="userid" class="col-sm-2 col-form-label">아이디</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control-plaintext" id="userid" readonly>
		    </div>
		  </div>
			
		  <div class="mb-3 row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-5">
		      <input type="password" class="form-control" id="inputPassword">
		    </div>
		  </div>
		  
		    <div class="mb-3 row">
		    <label for="PasswordCheck" class="col-sm-2 col-form-label">비밀번호확인</label>
		    <div class="col-sm-5">
		      <input type="password" class="form-control" id="PasswordCheck">
		    </div>
		  </div>
		  
		  
		   <div class="mb-3 row">
		    <label for="nick" class="col-sm-2 col-form-label">닉네임</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="nick">
		    </div>
		  </div>
		  
		   <div class="mb-3 row">
		    <label for="addr" class="col-sm-2 col-form-label">주소</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="addr" >
		    </div>
		  </div>
			
		   <div class="mb-3 row">
		    <label for="email" class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="email" >
		    </div>
		  </div>
		  
		   <div class="mb-3 row">
		    <label for="phone" class="col-sm-2 col-form-label">연락처</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="phone" >
		    </div>
		  </div>
		  
		  <input type="submit" id="modifyBtn" value="수정하기">
 </div>
</div>
</body>
</html>