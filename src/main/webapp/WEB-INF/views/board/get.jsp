<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>


<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>자유 게시판 글 정보</title>
<script>
var appRoot = "${appRoot}";
var boardBno = "${board.bno}";
var userid = "${pinfo.member.userid}";
</script>
<script src="${appRoot }/resources/js/get.js"></script>
<script>
function getReplies() { $.getJSON("${path}/replies/all/" + article_no, function (data) { 
	console.log(data);
	 var str = ""; 
	 $(data).each(function () { 
	 str += "<li data-reply_no='" + this.reply_no + "' class='replyLi'>" 
	 	 + "<p class='reply_text'>" + this.reply_text + "</p>" 
	 	 + "<p class='reply_writer'>" + this.reply_writer + "</p>" 
	 	 + "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>" 
	 	 + "</li>" 
	 	 + "<hr/>";
	 	  }); 
	 	  
	 $("#replies").html(str); });
	 
 }
</script>
</head>
<body>




<tv:navbar></tv:navbar>
<div class="container">
	
	<h1>글 정보</h1>
	<div class="row">			
		<div class="col-12">				
			<div class="panel panel-default">
			
				<div class="form-group">
					<label>글 번호</label> <input class="form-control" name='bno'
					value='<c:out value="${board.bno }"/>' readonly = "readonly">
				</div>
				
				<div class="form-group">
					<label>제목</label> <input class="form-control" name='title'
					value='<c:out value="${board.title }"/>' readonly = "readonly">
				</div>
				
				<div class="form-group">
					<label>내용</label> 
					<textarea class="form-control" rows="3" name='content'
					readonly="readonly"><c:out value="${board.content }" /></textarea>
				</div>
				
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='writer'
					value='<c:out value="${board.writer }"/>'readonly="readonly">
				</div>
				
				<c:url value="/board/modify" var="modifyUrl">
					<c:param name="bno" value="${board.bno }" />
					<c:param name="pageNum" value="${cri.pageNum }" />
					<c:param name="amount" value="${cri.amount }" />
					<c:param name="keyword" value="${cri.keyword }" />
					<c:param name="type" value="${cri.type }" />
				</c:url>
				
				
	<div class="container">
	<div class="row">
		<div class="col-12">
			<h3><i class="fa fa-comments fa-fw"></i> 댓글 </h3>			
			<ul class="list-unstyled" id="reply-list-container">								
			</ul>		
		</div>
	</div>
</div>
		<div class="col-12">											
				<div class="reply-body">
					<div class="row">
					
						<div class="form-group com-sm-8">
							<textarea class="form-control" id="reply-reply-textarea1" placeholder="댓글을 입력 해주세요"></textarea>
						</div>
					<div class="form-group col-sm-2">
						<input class="form-control input-sm" id="reply-replyer-input1" type="text" placeholder="작성자">
					</div>
					<div class="form-group col-sm-2">
						<button id="reply-insert-btn1" type="button" class="btn btn-primary">등록</button>
					</div>
					</div>						
				</div>
			<div class="reply-footer">
				<ul id="replies">
				
				</ul>
			</div>
			<div class="reply-footer">
				<nav aria-label="Contacts page navi">
				<ul class="pagination pageination-sm no-margin justify-content-center m-0">
				
				</ul>
				</nav>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="modifyModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">댓글 수정</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="rno">댓글번호</label>
					<input class="form-control" id="rno" name="rno" readonly>
				</div>
				<div class="form-group">
					<label for="reply">댓글 내용</label>
					<input class="form-control" id="reply" name="reply" placeholder="댓글 작성해주세요">
				</div>
				<div class="form-group">
					<label for="writer">댓글 작성자</label>
					<input class="form-control" id="writer" name="writer" readonly>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-success modalModBtn">수정</button>
				<button type="button" class="btn btn-danger modalDelBtn">삭제</button>
			</div>
		</div>
	</div>								
			<button data-oper='modify' class="btn btn-default">수정</button>
			<button data-oper='list' class="btn btn-info">게시글로 돌아가기</button>
			<form id='operForm' action="${appRoot }/board/modify" method="get">
				<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
			</form>
			
			
		</div>
		
	</div>
	
</div>
</body>
</html>