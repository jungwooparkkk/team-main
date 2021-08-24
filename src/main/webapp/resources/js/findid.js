
	//이메일 정보 매칭해서 아이디 알려주기
	$(function() {
		 $("#findmailBtn").click(function(e) {
		 	e.preventDefault();
			var emailVal = $("#find-pw-email").val();
			var id = "${userid};"
			var validMail = false;
			var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/; 
			
			if(emailVal == ""){
				alert("이메일을 입력해주세요.")
			}else if (!regmail.test(emailVal)){
				alert("올바른 형식으로 작성해주세요.")
			}else{
				var data = {email : emailVal};
				$.ajax({
					type : "post",
					url : appRoot+"/member/checkMail",
					data : data,
					success : function (data) {
						if(data[0] == "exist"){
							console.log("이미 회원 가입되어 있는 이메일")
							alert("회원가입 되어있는 아이디는"+data[1]+ "입니다.");
							var validMail = false;
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