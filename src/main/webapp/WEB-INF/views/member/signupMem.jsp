<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
<script>

var goPopup = function(){
	var pop = window.open("${appRoot}/member/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	} 
var jusoCallBack = function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){ 
	document.getElementById("zipNo").value = zipNo; 
	document.getElementById("address").value = roadAddrPart1; 
	if(addrDetail.length>30){ 
		alert('상세주소가 너무 길어 다시 입력해야 합니다.'); 
		return; 
		} 
	document.getElementById("addrDetail").value = addrDetail; 

	
//
$(function(){
	var validId = false;
	var passwordConfirm = false;
		
	
	//아이디 중복 확인
	$("#id-dupCheck-btn").click(function() {
		var idVal = $("#signup-inputid").val();
		var messagePop = $("#id-message");
		validId = false;
		toggleEnableSubmit();
		
		if(idVal == ""){
			messagePop.text("아이디를 입력해주세요.");
		}else {
			var data = {id : idVal};
			$.ajax({
				type : "get",
				url : "${appRoot}/member/checkdupMem",
				data : data,
				success : function (data) {
					if (data == "success"){
						console.log("사용 가능 아이디")
						validId = true;
						messagePop.text("사용 가능한 아이디 입니다.");
					}
					else if (data == "exist") {
						console.log("사용 불가 아이디")
						messagePop.text("이미 있는 아이디 입니다. 다른 아이디를 입력해주세요.")
					}
					
					toggleEnableSubmit();
				},
				error : function() {
					console.log("아이디 중복 체크 실패");
				}
			});
		}
	})
	
	//비밀번호 확인
	$("#signup-inputpw, #signup-inputpwCheck").keyup(function() {
		var pw = $("#signup-input-pw").val();
		var pwCheck = $("#signup-input-pwCheck").val();
		var submitBtn = $("signup-btn1");
		passwordConfirm = false;
		toggleEnableSubmit();
		
		if (pw != pwCheck) {
			$("#password-message").text("비밀번호가 일치하지 않습니다.");
		}else{
			if(pw == ""){
				$("#password-message").text("비밀번호를 입력해주세요.")
			} else {
				paswordConfirm = true;
				$("#password-message").empty();
			}
		}
		toggleEnableSubmit();
	});
	
	function toggleEnableSubmit(){
		if(passwordConfirm && validId){
			$("#signup-btn1").removeAttr("disabled");
		}else{
			$("#signup-btn1").attr("disabled","disabled");
		}
	}
})



</script>


</head>
<body>
<div class="container">
	<c:if test="${not empty param.error }">
			<div id="login-alert" class="alert alert-danger d-flex align-items-center" role="alert">
  			회원가입에 실패했습니다.
  			</div>
	</c:if>
	<h1>회원가입</h1>
		<div class="row">	
				<div class="col-6">
					<form method="post" action="${appRoot }/member/signupMem">
						<div class="form-group">
							<label for="signup-inputid">아이디</label>
							<div class="input-group">
							<input type="text" class="form-control" id="signup-inputid" name="userid">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button"
										id="id-dupCheck-btn">
								아이디 중복 확인		
								</button>
							</div>
						</div>
						<small id="id-message" class="form-text"></small>
					
				</div>
			<div class="form-group">
				<label for="signup-input-pw"> 비밀번호 </label>
				<input type="password" class="form-control" id="signup-input-pw" name="userpw">
			</div>
			
			<div class="form-group">
				<label for="signup-input-pwCheck">비밀번호 확인</label>
				<input type="password" class="form-control" id="signup-input-pwCheck">
				<small id="password-message" class="form-text text-danger "></small>
			</div>
			
			<div class="form-group">
				<label for="signup-input-nick">닉네임</label>
				<input type="text" class="form-control" id="signup-input-nick" name="nickName">
			</div>
			
	 		 <div class="form-group">
				 <label for="signup-input-address"> 주소 </label><br>
		 		 <input type="text" class="zip_code" id="zipNo" readonly>
		 		 <button type="button" class="zip_code_btn" onclick="javascript:goPopup();">우편번호</button>
				 <br/> 				
				 <input type="text" placeholder="기본 주소를 입력해 주세요" id="address">
				 <input type="text"  placeholder="나머지 주소를 입력해 주세요" id="addrDetail">
			 </div>	
			
			<div class="form-group col-5">
				<label for="signp-input-email"> 이메일 주소 </label>
				<input type="text" class="serchBox" id="signup-input-email" 
				placeholder="e-mail@gmail.com" name="email">
			</div>
			
			<div class="form-group">
				<label for="signup-input-phoneNum"> 연락처 </label>
				<input type="text" class="form-control" id="signup-input-phoneNum" name="phoneNum">
			</div>
			<button type="submit" class="btn btn-primary" id="signup-btn1">회원 가입</button>
				</form>
				</div>
			</div>
		</div>	

</body>
</html>