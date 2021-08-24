/**
 * 
 */
 $(function() {
   function showModifyModal(rno) {
      $.ajax({
         type: "get",
         url: appRoot + "/replies/" + rno,
         success: function (reply) {
            $("#reply-modify-rno").val(reply.rno);
            $("#reply-modify-writer").val(reply.replyer);
            $("#reply-modify-reply").text(reply.reply);

            // 댓글 작성자와 로그인 유저가 같지 않으면 
            // 수정/삭제 버튼 삭제
            if (userid != reply.replyer) {
               $("#reply-list-container")
                 .find("#reply-modify-btn1")
                 .find("#reply-delete-btn1")
                 .hide();
                 
               
            } else {
               $("#reply-modify-btn1")                 
                 .show();
               $("#reply-delete-btn1")
                 .show();   
               
               
            }

            
         },
         error: function () {
            console.log("댓글 가져오기 실패");
         }
      })
   }
   /*댓글 출력.*/
   function showReplyList(list) {
      var container = $("#reply-list-container").empty();
      
      for (var reply of list) {
         var replyHTML = `
            <li class="media" id="reply${reply.rno}" data-rno="${reply.rno}">
               <div class="media-body">
                  <h5 class="my-4">${reply.replyerName}</h5>
                  <p>${reply.reply}</p>
                  <small>${new Date(reply.replyDate).toISOString().split("T")[0]}</small>`
                  +
                     (reply.replyer == userid
                        ?
                           `
                           <button id="reply-delete-btn2" data-toggle='modal' data-target='#deleteModal' style="float:right">삭제</button>
                           <button id="reply-modify-btn2" data-toggle='modal' data-target='#modifyModal' style="float:right">수정</button>
                           `
                        : ``
                     )
                  +
                  `<hr>
               </div>
            </li>`;
         var replyComponent = $(replyHTML).click(function() {
            showModifyModal($(this).attr("data-rno"));
         });
         container.append(replyComponent);
      }
      
      /*
      for (var reply of list) {
         var newItem = $("<li>").addClass("media")
                           .attr("id", "reply" + reply.rno)
                           .attr("data-rno", reply.rno);
         var mediaBody = $("<div>").addClass("media-body");
         newItem.append(mediaBody);
         
         newItem.click(function() {
            showModifyModal($(this).attr("data-rno"));
         });
         mediaBody.append("<h5 class='my-4'>" + reply.replyer + "</h5>")
               .append("<p>" + reply.reply + "</p>")
//               .append("<small>" + reply.replyDate + "</small>");
               .append("<small>" + new Date(reply.replyDate).toISOString().split("T")[0] + "</small>");
         
         container.append(newItem);
      }
      */
   }
   
   /* 댓글 목록 가져오기 */
   function getReplyList() {
      $.ajax({
         type: "get",
         url: appRoot + "/replies/pages/" + boardBno,
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
      var bno = $("#reply-bno-input1").val();
      var replyer = $("#reply-replyer-input1").val();
      var reply = $("#reply-reply-textarea1").val();
      
      var data = {
         bno: bno,
         replyer: replyer,
         reply: reply
      };
      
      $.ajax({
         type: "post",
         url: appRoot + "/replies/new",
         data: JSON.stringify(data),
         contentType: "application/json",
         success: function() {
            console.log("입력 성공");
            
            // 댓글리스트 가져오고
            getReplyList();
            
         },
         error: function() {
            console.log("입력 실패");
         }
      });
   });
   
   /* 수정 submit 버튼 클릭시 */
   $("#reply-modify-btn1").click(function() {
      var rno = $("#reply-modify-rno").val();
      var bno = $("#reply-modify-bno").val();
      var reply = $("#reply-modify-reply").val();
      var replyer = $("#reply-modify-writer").val();
      
      var data = {
         rno : rno,
         bno : bno,
         reply: reply,
         replyer: replyer
      }
      
      $.ajax({
         type: "put",
         url: appRoot + "/replies/" + rno,
         data: JSON.stringify(data),
         contentType : "application/json",
         success: function() {
            console.log("수정 성공");
            // 모달창 닫고
            $("#modifyModal").modal("hide");
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
         var rno = $("#reply-modify-rno").val();
         var replyer = $("#reply-modify-writer").val();
         
         var data = {
            rno : rno,
            replyer: replyer
         }

         $.ajax({
            type: "delete",
            url: appRoot + "/replies/" + rno,
            data : JSON.stringify(data),
            contentType : "application/json",
            success: function () {
               // modal 닫고,
               $("#deleteModal").modal("hide");
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
   
   $('.likebtn').click(function(){
      likesupdate(this);
   });
   
   function likesupdate(elem){
      // var root = getContextPath(),
      var likeurl = "/likes/likesupdate";
      // userid = $('#userid').val(),
      var bno = $(elem).closest(".item").find(".list-num").text();
      bno = bno ? bno : window.boardBno;
      var count = $(elem).closest(".item").find('.likescheck').val();
      var data = {"userid" : userid,
            "bno" : bno,
            "count" : count};
      
      console.log("button click");
      
   $.ajax({
      url : appRoot + likeurl,
      type : 'post',
      contentType: 'application/json',
      data : JSON.stringify(data),
      success : function(result){
         console.log("수정" + result.result);
         location.reload();
      }, error : function(result){
         console.log(result)
      }
      
      });
   };

   function getContextPath() {
       var hostIndex = location.href.indexOf( location.host ) + location.host.length;
       return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
   } 
})