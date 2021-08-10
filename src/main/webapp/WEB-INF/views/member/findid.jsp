<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!--modi  -->
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%
String id =request.getParameter("userid");
String email = request.getParameter("email");
%>
<title>Insert title here</title>



<script>


	//이메일 정보 매칭해서 아이디 알려주기
	$(function() {
		 $("#findmailBtn").click(function() {
			var emailVal = $("#find-pw-email").val();
			var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
			var id = "${userid};"
			if(emailVal == ""){
				alert("이메일을 입력해주세요.")
			}else if (!regmail.test(emailVal)){
				alert("올바른 형식으로 작성해주세요.")
			}else{
				var data = {email : emailVal};
				$.ajax({
					type : "get",
					url : "${appRoot}/member/checkMail",
					data : data,
					success : function (data) {
						if(data[0] == "exist"){
							console.log("이미 회원 가입되어 있는 이메일")
							alert("회원가입 되어있는 아이디는"+data[1]+ "입니다.");
						} else if(data[0] == "fail"){
							console.log("등록되어 있지 않은 이메일")
							alert("등록되어 있지 않은 이메일입니다. 회원 가입을 진행해주세요.");
						}
					},
					error : function() {
						console.log("이메일 확인 불가")
					}
				})
			}
		})
		
	});
	
	
</script>

</head>
<body>


	<div class="row justify-content-center">
		<div class="col-md-6 col-7">
	  		<h2>아이디 찾기</h2>
	 		 <div class="form-group">
	  			<p>회원가입 시 입력한 이메일 주소를 입력하세요.</p>
				  	<div class="mb-3">
				  		<form id="findid" method="get" action="${appRoot }/member/findid">
						  <label for="find-pw-email" class="form-label">이메일</label>
						  <input type="email" class="form-control" id="find-pw-email" name = "email" placeholder="email@gmail.com">
				  		</form>
					</div>	  
				  <button type="submit" id="findmailBtn" class="btn btn-outline-primary">가입한 아이디 확인하기</button>
		  			
 			</div>
		</div>
	</div>
	

</body>
</html>