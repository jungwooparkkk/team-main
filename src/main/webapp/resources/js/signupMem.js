
//주소검색 팝업 및 입력
var goPopup = function(){
	var pop = window.open(appRoot+"/member/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
var jusoCallBack = function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){ 
		document.getElementById("zipNo").value = zipNo; 
		document.getElementById("address").value = roadAddrPart1; 
		document.getElementById("addrDetail").value = addrDetail; 
		
		document.getElementById("fullAddressInput").value = `(${zipNo}) ${roadAddrPart1} ${addrDetail}`;
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
				url : appRoot+"/member/checkdupMem",
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
		console.log(validId, passwordConfirm,validNick, validMail, validNo)
		if(validId && passwordConfirm && validNick&& validMail && validNo){
			$("#signup-btn").removeAttr("disabled");
		}else{
			$("#signup-btn").attr("disabled","disabled");
		}
	}
	
	//닉네임 중복 체크
	
	$("#nick-dupCheck-btn").click(function() {
		var nickVal = $("#signup-input-nick").val(); 
		
		toggleEnableSubmit();
		
		if(nickVal == ""){
			$("#nickname-message").text("닉네임을 입력해주세요.");
		}else{
			var data = {nickName : nickVal};
			$.ajax({
				type : "get",
				url : appRoot+"/member/checkNick",
				data : data,
				success : function(data) {
					if(data[0] == "success"){
						console.log("사용가능 닉네임")
						validNick = true;
						$("#nickname-message").text("사용 가능한 닉네임입니다.");
					}
					else if(data[0] == "exist") {
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

	$("#signup-input-email").keyup(function(e){
		e.preventDefault();
		var email = $("#signup-input-email").val();
		var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
		validMail = false;
		toggleEnableSubmit();
		
		if(email ==""){
			$("#email-message").text("이메일을 입력해주세요.");
		}else if (!regmail.test(email)){
			$("#email-message").text("올바른 형식의 이메일을 입력해주세요.");
		}else{
			var data = {email : email};
			$.ajax({
				type : "post",
				url : appRoot+"/member/checkMail",
				data : data,
				success : function(data){
					if(data[0] == "fail"){
						console.log("사용가능 이메일")
						validMail = true;
						$("#email-message").text("사용 가능한 이메일입니다.");
					}
					else if (data[0] == "exist") {
						console.log("사용 불가 아이디");
						$("#email-message").text("이미 가입되어 있는 이메일 입니다.")
					}
		toggleEnableSubmit();
				}
			});
		} 
	})
	
	
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
	
		$("#toggle-password-btn").click(function() {
	      var inputPw = $("#signup-input-pw")
	      
	      if(inputPw.attr("type") == "password"){
	         inputPw.attr("type","text");
	         $("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-slash");
	      }else{
	         inputPw.attr("type","password");
	         $("#toggle-password-icon").removeClass("fa-eye-slash").addClass("fa-eye");
	      }
   });
	
})



