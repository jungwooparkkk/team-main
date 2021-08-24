
$(function(){
	$("#toggle-password-btn").click(function() {
		    var inputPw = $("#inpw")
		    
		    if(inputPw.attr("type") == "password"){
		       inputPw.attr("type","text");
		       $("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-slash");
		    }else{
		       inputPw.attr("type","password");
		       $("#toggle-password-icon").removeClass("fa-eye-slash").addClass("fa-eye");
		    }
		});
})