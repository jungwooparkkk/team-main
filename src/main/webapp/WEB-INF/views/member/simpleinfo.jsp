<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>내 정보</title>
</head>
<style>
div.container {
  border: 15px solid transparant;
  margin: 110px; 
}

#imgBasic{ 
 width : 120px;
 height: 120px;
 border-radius: 70%;
}
</style>
<body>
<div class="container">
		<h1>내 정보</h1>
	<div class="row">
		<div class="col-12">
					
			     <img id="imgBasic" 
			     <c:if test="${empty members.fileName }">
			    	  src="${profile }basicProfile/basicImage.png"
			    	  </c:if>
			    	  
			    	  <c:if test="${not empty members.fileName }" >
  			    	  src="${profile }${members.userid }/${members.fileName }"
			    	  </c:if>
			     > 
					 <div class= sm3>
						<label for="member-info-nick">닉네임</label>
						<input value="${pinfo.member.nickName }" type="text" class="form-control" id="member-info-nick" name="nickName">
					 </div>
					</div>
			</div>
		</div>
	</div>
</body>
</html>