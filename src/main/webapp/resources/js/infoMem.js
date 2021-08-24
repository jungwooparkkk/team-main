$(function() {
	var exPasswordModal = $("#ex-password-modal");
	var selectButton ="";
	
	$("#deleteBtn").click(function(e) {
		e.preventDefault();
		var ment = confirm("정말로 탈퇴 하시겠습니까?");
		selectButton = "delete-button";
		
		if(ment){
			exPasswordModal.modal('show');			
		}
	});
	
	$("#ex-password-modal-btn").click(function() {
		switch (selectButton) {
			case "delete-button" :
				$("#member-info-form")
				.attr("action", appRoot+"/member/deleteMem")
				.submit();
			break;
		}
	});
	
});
	