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
			<h3>댓글 </h3>
			
			<sec:authorize access="isAuthenticated()">
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reply-insert-modal">댓글 작성</button>
			</sec:authorize>
			<ul class="list-unstyled" id="reply-list-container">
			
			</ul>
		</div>
	</div>
</div>
				
				
				<div class="modal fade" id="reply-insert-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">새 댓글</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <input type="text" value="${board.bno }" readonly hidden id="reply-bno-input1">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input type="text" readonly value="${pinfo.member.userName }" class="form-control" />
            <input type="hidden" value="${pinfo.member.userid }" class="form-control" id="reply-replyer-input1">
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">댓글</label>
            <textarea class="form-control" id="reply-reply-textarea1"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="reply-insert-btn1" type="button" class="btn btn-primary">댓글 입력</button>
      </div>
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