/**
 * 
 */
 $(function() {
	function showModifyModal(eatrno) {
		$.ajax({
			type: "get",
			url: appRoot + "/eatreplies/" + eatrno,
			success: function (reply) {
				$("#reply-eatrno-input2").val(reply.eatrno);
				$("#reply-replyer-input2").val(reply.replyer);
				$("#reply-replyerName-input2").val(reply.replyerName);
				$("#reply-reply-textarea2").text(reply.reply);

				// 댓글 작성자와 로그인 유저가 같지 않으면 
				// 수정/삭제 버튼 삭제
				if (userid != reply.replyer) {
					$("#reply-modify-modal")
					  .find("#reply-modify-delete-btn-wrapper")
					  .hide();	
					
					$("#reply-reply-textarea2").attr("readonly", "readonly");
				} else {
					$("#reply-modify-modal")
					  .find("#reply-modify-delete-btn-wrapper")
					  .show();	
					
					$("#reply-reply-textarea2").removeAttr("readonly");
				}

				$("#reply-modify-modal").modal("show");
			},
			error: function () {
				console.log("댓글 가져오기 실패");
			}
		})
	}
	
	function showReplyList(list) {
		var container = $("#reply-list-container").empty();
		
		for (var reply of list) {
			var replyHTML = `
				<li class="media" id="reply${reply.eatrno}" data-eatrno="${reply.eatrno}">
					<div class="media-body">
						<h5 class="my-4">${reply.replyerName}</h5>
						<p>${reply.reply}</p>
						<small>${new Date(reply.replyDate).toISOString().split("T")[0]}</small>
						<hr>
					</div>
				</li>`;
			var replyComponent = $(replyHTML).click(function() {
				showModifyModal($(this).attr("data-eatrno"));
			});
			container.append(replyComponent);
		}
		
		/*
		for (var reply of list) {
			var newItem = $("<li>").addClass("media")
									.attr("id", "reply" + reply.eatrno)
									.attr("data-eatrno", reply.eatrno);
			var mediaBody = $("<div>").addClass("media-body");
			newItem.append(mediaBody);
			
			newItem.click(function() {
				showModifyModal($(this).attr("data-eatrno"));
			});
			mediaBody.append("<h5 class='my-4'>" + reply.replyer + "</h5>")
				   .append("<p>" + reply.reply + "</p>")
//				   .append("<small>" + reply.replyDate + "</small>");
				   .append("<small>" + new Date(reply.replyDate).toISOString().split("T")[0] + "</small>");
			
			container.append(newItem);
		}
		*/
	}
	
	/* 댓글 목록 가져오기 */
	function getReplyList() {
		$.ajax({
			type: "get",
			url: appRoot + "/eatreplies/pages/" + boardBno,
			success: function(list) {
				console.log(list);
				showReplyList(list);
			},
			error : function() {
				console.log("댓글 가져오는 중 에러.");
			}
		});
	}
	// 페이지 로딩 후 댓글 목록 가져오는 함수 실행
	getReplyList();
	
	/* 댓글 입력 버튼 처리 */
	$("#reply-insert-btn1").click(function() {
		var eatbno = $("#reply-eatbno-input1").val();
		var replyer = $("#reply-replyer-input1").val();
		var reply = $("#reply-reply-textarea1").val();
		
		var data = {
			eatbno: eatbno,
			replyer: replyer,
			reply: reply
		};
		
		$.ajax({
			type: "post",
			url: appRoot + "/eatreplies/new",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function() {
				console.log("입력 성공");
				// 모달창 닫고
				$("#reply-insert-modal").modal("hide");
				// 댓글리스트 가져오고
				getReplyList();
				
				// 안내 메세지 보여주기
				$("#alert1").text("새 댓글 입력하였습니다.").addClass("show");
			},
			error: function() {
				console.log("입력 실패");
			}
		});
	});
	
	/* 수정 submit 버튼 클릭시 */
	$("#reply-modify-btn1").click(function() {
		var eatrno = $("#reply-eatrno-input2").val();
		var eatbno = $("#reply-eatbno-input2").val();
		var reply = $("#reply-reply-textarea2").val();
		var replyer = $("#reply-replyer-input2").val();
		
		var data = {
			eatrno : eatrno,
			eatbno : eatbno,
			reply: reply,
			replyer: replyer
		}
		
		$.ajax({
			type: "put",
			url: appRoot + "/eatreplies/" + eatrno,
			data: JSON.stringify(data),
			contentType : "application/json",
			success: function() {
				console.log("수정 성공");
				// 모달창 닫고
				$("#reply-modify-modal").modal("hide");
				// 댓글리스트 가져오고
				getReplyList();
				
				// 안내 메세지 보여주기
				$("#alert1").text("댓글 수정하였습니다.").addClass("show");
			},
			error: function() {
				console.log("수정 실패");
			}
		})
	});
	
	/* 삭제 버튼 클릭시 */
	$("#reply-delete-btn1").click(function () {
		var check = confirm("삭제 하시겠습니까?");

		if (check) {
			var eatrno = $("#reply-eatrno-input2").val();
			var replyer = $("#reply-replyer-input2").val();
			
			var data = {
				eatrno : eatrno,
				replyer: replyer
			}

			$.ajax({
				type: "delete",
				url: appRoot + "/eatreplies/" + eatrno,
				data : JSON.stringify(data),
				contentType : "application/json",
				success: function () {
					// modal 닫고,
					$("#reply-modify-modal").modal("hide");
					// 댓글 리스트 다시 얻어오고,
					getReplyList();
					// alert 띄우고
					$("#alert1").text("댓글 삭제하였습니다.").addClass("show");
				},
				error: function() {
					console.log("삭제 실패");
				}
			})
		}
	});
})
