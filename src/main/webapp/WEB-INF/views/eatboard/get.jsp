<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bd" tagdir="/WEB-INF/tags/travel"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>맛집 리스트</title>
<script>
	var appRoot = "${appRoot}";
	var boardBno = "${board.eatbno}";
	var userid = "${pinfo.member.userid}";
</script>
<script src="${appRoot }/resources/js/eatget.js"></script>
<link rel="stylesheet" href="${appRoot }/resources/css/eatboard.css" />
</head>
<body>
	<bd:navbar></bd:navbar>

	<div class="container eat-board-detail">

		<div id="alert1" class="alert alert-primary fade" role="alert">
		</div>

		<h1>글 보기</h1>

		<div class="row">
			<div class="col-12">
				<c:if test="${not empty board.fileName }">
					<div class="img-wrap">
						<div class="inner">
							<img class="img-fluid"
								src="${imgRoot}${board.eatbno }/${board.fileName}">
						</div>
					</div>
				</c:if>
				<div class="item-info">
					<div class="icon-reply">
						<i class="far fa-comment-dots"></i>&nbsp;${board.replyCnt }
					</div>
					<div class="icon-view">
						<i class="far fa-eye"></i>&nbsp;${board.views }
						<c:choose>
							<c:when test="${!board.likeClicked}">
							<span class="likebtn">
								<i type="button" class="far fa-heart"></i>
							</span>
								<input type="hidden" class="likecheck" value="${eatlno }">
							</c:when>					
							<c:when test="${board.likeClicked}">
							<span class="likebtn">
								<i type="button" class="fas fa-heart"></i>
							</span>
								<input type="hidden" class="likecheck" value="${eatlno }">
							</c:when>
							<c:otherwise>
								0도 아니고 1도 아님.
							</c:otherwise>
						</c:choose> ${board.likesCnt }
					</div>
				</div>
				<form>
					<div class="form-group">
						<label for="input1">제목</label> <input readonly="readonly"
							id="input1" class="form-control" name="title"
							value="${board.title }">
					</div>
					<div class="form-group">
						<label for="input3">주소</label> <input readonly id="input3"
							class="form-control" name="address" value="${board.address}">
					</div>
					<div class="form-group">
						<label for="kategorie1">음식종류</label> <input readonly id="kategorie1"
							class="form-control" name="kategorie" value="${board.kategorie}">
					</div>
					<div class="form-group">
						<label for="input2">작성자</label> <input type="hidden"
							readonly="readonly" id="input2" class="form-control"
							name="writer" value="${board.writer}"> <input
							readonly="readonly" class="form-control"
							value="${board.writerName}">
					</div>
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea readonly="readonly" id="textarea1" class="form-control"
							name="content"><c:out value="${board.content }" /></textarea>
					</div>
					<c:url value="/eatboard/modify" var="eatmodifyurl">
						<c:param name="eatbno" value="${board.eatbno }" />
						<c:param name="pageNum" value="${cri.pageNum }" />
						<c:param name="amount" value="${cri.amount }" />
						<c:param name="type" value="${cri.type }" />
						<c:param name="keyword" value="${cri.keyword }" />
					</c:url>
					<div class="btn-wrap">
						<c:if test="${pinfo.member.userid eq board.writer }">
							<a class="btn btn-secondary btn-border" href="${eatmodifyurl }">수정/삭제</a>
						</c:if>
						<c:url value="/eatboard/list" var="listUrl">
							<c:param name="pageNum" value="${cri.pageNum }"></c:param>
							<c:param name="amount" value="${cri.amount }"></c:param>
							<c:param name="keyword" value="${cri.keyword }"></c:param>
							<c:param name="type" value="${cri.type }"></c:param>
						</c:url>
						<a class="btn btn-secondary" href="${listUrl }">글 목록</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	<!-- 댓글 입력 -->
	<div class="container reply-wrap">
	  	<div class="row">
			<div class="col-12">
				<div class="reply-header">
					<form>
						<input type="text" value="${board.eatbno }" readonly hidden
									id="reply-eatbno-input1">
								<div hidden class="form-group">
									<label for="recipient-name" class="col-form-label">작성자</label> <input
										type="text" readonly value="${pinfo.member.nickName }"
										class="form-control" /> <input type="hidden"
										value="${pinfo.member.userid }" class="form-control"
										id="reply-replyer-input1">
								</div>
							<sec:authorize access="isAuthenticated()">
								<div class="form-group">
									<label for="message-text" class="col-form-label"></label>
									<textarea class="form-control" id="reply-reply-textarea1"></textarea>
								</div>
								<input type="submit" class="btn btn-primary"
									id="reply-insert-btn1" value="댓글 작성"/>
							</sec:authorize>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	 <div class="container reply-wrap">
		<div class="row">
			<div class="col-12">
				<div class="reply-header">
					<h3>댓글</h3>
					<%-- <sec:authorize access="isAuthenticated()">
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#reply-insert-modal">댓글 작성</button>
					</sec:authorize> --%>
				</div>
				<ul class="list-unstyled" id="reply-list-container">
				</ul>
			</div>
		</div>
	</div> 
	 
	<%-- 댓글 입력 모달 --%>

	<%-- <div class="modal fade" id="reply-insert-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">새 댓글</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<input type="text" value="${board.eatbno }" readonly hidden
							id="reply-eatbno-input1">
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">작성자</label> <input
								type="text" readonly value="${pinfo.member.nickName }"
								class="form-control" /> <input type="hidden"
								value="${pinfo.member.userid }" class="form-control"
								id="reply-replyer-input1">
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">댓글</label>
							<textarea class="form-control" id="reply-reply-textarea1"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="reply-insert-btn1" type="button"
						class="btn btn-primary">댓글 입력</button>
				</div>
			</div>
		</div>
	</div> --%>

	<%-- 댓글 수정, 삭제 모달 --%>
	<div class="modal fade" id="reply-modify-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">댓글 수정/삭제</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<input type="text" value="" readonly hidden
							id="reply-eatrno-input2"> <input type="text"
							value="${board.eatbno }" readonly hidden id="reply-eatbno-input2">
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">작성자</label> <input
								type="hidden" class="form-control" id="reply-replyer-input2"
								readonly> <input type="text" class="form-control"
								id="reply-replyerName-input2" readonly>
						</div>
						<div class="form-group">
							<label for="message-text" class="col-form-label">댓글</label>
							<textarea class="form-control" id="reply-reply-textarea2"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<span id="reply-modify-delete-btn-wrapper">
						<button id="reply-modify-btn1" type="button"
							class="btn btn-primary">댓글 수정</button>
						<button id="reply-delete-btn1" type="button"
							class="btn btn-danger">댓글 삭제</button>
					</span>
				</div>
			</div>
		</div>
	</div>

</body>
</html>