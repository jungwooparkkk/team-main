<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>회원가입</title>
<script>

//주소검색 팝업 및 입력
var goPopup = function(){
	var pop = window.open("${appRoot}/member/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	} 
var jusoCallBack = function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){ 
	document.getElementById("zipNo").value = zipNo; 
	document.getElementById("address").value = roadAddrPart1; 
	document.getElementById("addrDetail").value = addrDetail; 
	
	document.getElementById("fullAddressInput").value = `(\${zipNo}) \${roadAddrPart1} \${addrDetail}`;
}



$(function(){

	var validId = false;
	var passwordConfirm = false;
	var validNo = false;
	var validMail = false;
	var validNick = false;



	//아이디 중복 확인 및 조합 체크
	$("#id-dupCheck-btn").click(function() {
		var idVal = $("#signup-inputid").val();
		var messagePop = $("#id-message");
		var regid = /^[a-zA-Z0-9]{8,20}$/
	
		
		toggleEnableSubmit();

		if(idVal == ""){
			messagePop.text("아이디를 입력해주세요.");
		}else if(!regid.test(idVal)){
			messagePop.text("아이디는 숫자+영문자 조합 8자 이상 입력해주세요.");
		}else{
			var data = {id : idVal};
			$.ajax({
				type : "get",
				url : "${appRoot}/member/checkdupMem",
				data : data,
				success : function (data) {
					if (data[0] == "success"){
						console.log("사용 가능 아이디");
						validId = true;
						messagePop.text("사용 가능한 아이디 입니다.");
					}
					else if (data[0] == "exist") {
						console.log("사용 불가 아이디");
						messagePop.text("이미 있는 아이디 입니다.")
					}

					toggleEnableSubmit();
				},
				error : function() {
					console.log("아이디 중복 체크 실패");
				}
			});
		}
	})

	//비밀번호 일치여부 확인 및 조건 설정
	$("#signup-input-pw, #signup-input-pwCheck").keyup(function() {
		var pw = $("#signup-input-pw").val();
		var pwCheck = $("#signup-input-pwCheck").val();
		var regpw = /(?=.*?[#?!@$%^&*-])(?=.*[a-z])(?=.*[A-Z]).{8}/;
		var submitBtn = $("signup-btn");
		passwordConfirm = false;
	
	
		if (pw != pwCheck) {
			$("#password-message").text("비밀번호가 일치하지 않습니다.");
		}else{
			if(pw == ""){
				$("#password-message").text("비밀번호를 입력해주세요.")
			} else if(!regpw.test(pw)){
				$("#password-message").text("적어도 숫자+대문자+소문자+특수문자 포함 8자리 이상으로 설정해주세요.")
			}else{
				passwordConfirm = true;
				$("#password-message").text("사용 가능한 비밀번호 입니다.");
			}
		}
		toggleEnableSubmit();
	});

	function toggleEnableSubmit(){
		console.log(passwordConfirm, validId, validMail, validNo, validNick)
		if(passwordConfirm && validId && validMail && validNo && validNick){
			$("#signup-btn").removeAttr("disabled");
		}else{
			$("#signup-btn").attr("disabled","disabled");
		}
	}
	
	//닉네임 중복 체크
	
	$("#nick-dupCheck-btn").click(function() {
		var nickVal = $("signup-input-nick").val(); 
	
		if(nickVal == ""){
			$("nickname-message").text("닉네임을 입력해주세요.");
		}else{
			var data = {nickName : nickVal};
			$.ajax({
				type : "get",
				url : "${appRoot}/member/checkNick",
				data : data,
				success : function(data) {
					if(data == "exist"){
						console.log("사용가능 닉네임")
						validNick = true;
						$("#nickname-message").text("사용 가능한 닉네임입니다.");
					}
					else if(data == "success") {
						console.log("사용불가 닉네임")
						$("#nickname-message").text("이미 사용중인 닉네임입니다.");
					}
					toggleEnableSubmit();
				},
				error : function() {
					console.log("확인불가");
				}
			});
		}
	})
	

	
 	//이메일 양식 체크

	$("#signup-input-email").keyup(function(){
		var email = $("#signup-input-email").val();
		var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
		var submitBtn = $("signup-btn");
		validMail = false;
		toggleEnableSubmit();
		
		if(email ==""){
			$("#email-message").text("이메일을 입력해주세요.");
		}else if (!regmail.test(email)){
			$("#email-message").text("올바른 형식의 이메일을 입력해주세요.");
		}else{
			validMail = true;
			$("#email-message").empty();
		}
		toggleEnableSubmit();
	}) ;
	
	
	// 연락처 양식 체크
	$("#signup-input-phoneNum").keyup(function() {
		var phoneNum = $("#signup-input-phoneNum").val();
		var regNo = /(\d{3}).*(\d{4}).*(\d{4})/;
		validNo = false;
		toggleEnableSubmit();
		
		if(phoneNum == ""){
			$("#phone-message").text("휴대폰 번호를 입력해주세요")
		}else if(!regNo.test(phoneNum)){
			$("#phone-message").text("유효한 번호를 입력해주세요")
		}else{
			validNo = true;
			$("#phone-message").empty();
		}
		toggleEnableSubmit();
	});
	
})





</script>


</head>
<body>
<div class="container">
	<c:if test="${not empty param.error }">
			<div id="signup-alert" class="alert alert-danger" role="alert">
  			회원가입에 실패했습니다.
  			</div>
	</c:if>
	<h1>회원가입</h1>
		<div class="row">	
				<div class="col-md-6 col-7">
					<form id="signup" method="post" action="${appRoot }/member/signupMem">
						<div class="form-group">
							<label for="signup-inputid">아이디</label>
							<input required="required" type="text" class="form-control" id="signup-inputid" name="userid">
							
							<button class="btn btn-outline-secondary" type="button" id="id-dupCheck-btn">아이디 중복 확인</button>
							<small id="id-message" class="form-text"></small>
						</div>
									
						<div class="form-group">
							<label for="signup-input-pw"> 비밀번호 </label>
							<input required="required" type="password" class="form-control" id="signup-input-pw" name="userpw">
					
							<label for="signup-input-pwCheck">비밀번호 확인</label>
							<input required="required" type="password" class="form-control" id="signup-input-pwCheck">
							<small id="password-message" class="form-text text-danger "></small>
						</div>
			
						<div class="form-group">
							<label for="signup-input-nick">닉네임</label>
							<input type="text" class="form-control" id="signup-input-nick" name="nickName">
							
							<button class="btn btn-outline-secondary" type="button" id="nick-dupCheck-btn" name="nickname">중복 확인</button>
							<small id="nickname-message" class="form-text text-danger"></small>
						</div>
						
				 		 <div class="form-group">
							 <label for="signup-input-address"> 주소 </label><br>
						 	 <input type="text" class="zip_code" id="zipNo" readonly>
							 <button type="button" class="zip_code_btn" id="addr-input-btn" onclick="javascript:goPopup();">우편번호</button>
							 <br/> 				
							 <input type="text" class="address" id="address" readonly>
							 <input type="text" class="addrDetail" id="addrDetail" readonly><br><br>
							 <input name="address" type="hidden" id="fullAddressInput">
						</div>
						
						<div class="form-group">
				 			<label for="signp-input-email"> 이메일 주소 </label><br>
				   			<input required="required" type="email" class="form-control" id="signup-input-email" placeholder="e-mail@gmail.com" name="email">
							<small id="email-message" class="form-text"></small>
						</div>
			
						<div class="form-group">
							<label for="signup-input-phoneNum"> 연락처 </label>
							<input required="required" type="text" class="form-control" id="signup-input-phoneNum" name="phoneNum">
							<small id="phone-message" class="form-text"></small>
						</div>
			
							<button disabled type="submit" class="btn btn-primary" id="signup-btn">회원 가입</button>
				</form>
			</div>
		</div>
	</div>		
</body>
</html>