
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
 
 $(document).ready(function() {
	$("#changePhoto").on("click",function(e){
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		console.log(files);
	})
})
 



$(function() {

	
	var exPasswordModal = $("#ex-password-modal");
	var selectButton ="";
	
	
	$("#modifyBtn").click(function(e) {
		e.preventDefault();
		selectButton = "modify-button";
		exPasswordModal.modal('show');
	});
	
	$("#expassword-modal-btn").click(function() {
		switch(selectButton){
			case "modify-button" :
				$("#member-info-form1")
				.attr("action", appRoot+"/member/modifyMem")
				.submit();
			break;
		}

	});
	/* 비밀번호/확인 여부에 따른 수정버튼 활성화*/
	$("#inputPassword, #passwordCheck").keyup(function() {
		var newPw = $("#inputPassword").val();
		var newPwCheck = $("#passwordCheck").val();
		var regpw = /(?=.*?[#?!@$%^&*-])(?=.*[a-z])(?=.*[A-Z]).{8}/;
		var modifyBtn = $("#modifyBtn");
		passwordConfirm = false;
		
		if(newPw != newPwCheck){
			modifyBtn.attr("disabled", "disabled");
			$("#member-info-password-message").text("비밀번호가 일치하지 않습니다.");
		} else {
			if(newPw == ""){
				$("#member-info-password-message").text("비밀번호를 입력해주세요.");
			}else if(!regpw.test(newPw)){
				$("#member-info-password-message").text("숫자+대소문자+특수문자 포함 8자리 이상 조합으로 설정해주세요.")
			}else{
			modifyBtn.removeAttr("disabled");
			$("#member-info-password-message").empty();
			passwordConfirm = true;
			}
			
		}
	});
	
	$("#toggle-password-btn").click(function() {
	      var inputPw = $("#inputPassword")
	      
	      if(inputPw.attr("type") == "password"){
	         inputPw.attr("type","text");
	         $("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-slash");
	      }else{
	         inputPw.attr("type","password");
	         $("#toggle-password-icon").removeClass("fa-eye-slash").addClass("fa-eye");
	      }
   });
	
	$("#change-file-btn").click(function() {
		$("#profile-file").click();
	});
	
	$("#profile-file").change(function(e) {
		$("#imgBasic").attr("src", URL.createObjectURL(e.target.files[0]));
	});
		
});
 