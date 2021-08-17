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
				<c:if test="${not empty board.fileName }">
					<div>
						<img class="img-fluid" 
						src="${imgRoot}${board.bno }/${board.fileName}">
					</div>
				</c:if>
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
				
				<div>
					<div class="w3-border w3-center w3-padding">
				
					
					
					<div class="form-group">
						<label>조회수</label>
						<input class="form-control" name='views'
					value='<c:out value="${board.views }"/>'readonly="readonly">
					</div>
					<c:choose>
						<c:when test="${pinfo.member.userid ne null }">
							<a href='javascript: like_func();'><i class="far fa-heart" style="font-size:16px;color:red" id='like_icon'></i></a>
						</c:when>
						<c:otherwise>
							<a href= 'javascript: login_need();'><i class="far fa-heart" style="font-size:16px;color:red"></i></a>
						</c:otherwise>
					</c:choose>
			</div>
			</div>		
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
						<form>
							<input type="text" value="${board.bno }" readonly hidden id="reply-bno-input1">
						<c:choose>
						<c:when test="${pinfo.member.userid ne null }">
						<div class="form-group com-sm-8">
							<textarea class="form-control"  id="reply-reply-textarea1" placeholder="댓글을 입력해주세요"></textarea>
						</div>
						</c:when>
						<c:otherwise>
							<textarea class="form-control" readonly id="reply-reply-textarea1" placeholder="로그인 후 이용 부탁드립니다"></textarea>
						</c:otherwise>
						</c:choose>
					<div class="form-group col-sm-2">					
            					<input type="hidden"  readonly value="${pinfo.member.userid }" class="form-control" id="reply-replyer-input1"/>
            					<input type="hidden" value="${pinfo.member.nickName }" class="form-control" >
					</div>
					
					<div class="form-group col-sm-2">
						<button id="reply-insert-btn1" type="button" class="btn btn-primary" style="
    					width: 56px;
    					padding-right: 6px;
    					padding-left: 6px;
    					
						">등록</button>
					</div>
					</form>
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
								
			<c:if test="${pinfo.member.nickName eq board.writer }" >
					<a class="btn btn-secondary" href="${modifyUrl }">수정</a>
				</c:if>
			 <button class="btn btn-info" type="button" onclick="location.href='${appRoot }/board/list'">게시글로 돌아가기</button>
			<form id='operForm' action="${appRoot }/board/modify" method="get">
				<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
			</form>
			
			
		</div>
		
	</div>
	
</div>

<!-- 댓글 수정창 -->
	<div class="modal fade" id="modifyModal"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<h4 class="modal-title">댓글 수정</h4>
					<input type="text" value="" readonly hidden id="reply-modify-rno" >
          			<input type="text" value="${board.bno }" readonly hidden id="reply-modify-bno">
				<div class="form-group">
					<label for="reply">댓글 내용</label>
					<input class="form-control" id="reply-modify-reply" name="reply" placeholder="댓글 작성해주세요">
				</div>
				<div class="form-group">
					<input class="form-control" readonly hidden id="reply-modify-writer" name="writer" >
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
				<button id="reply-modify-btn1" type="button" class="btn btn-primary">수정</button>
				<!--  <button type="button" class="btn btn-danger modalDelBtn">삭제</button> -->
			</div>
			</div>
		</div>
	</div>	
	<!-- 댓글 삭제 -->
	<div class="modal fade" id="deleteModal"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">댓글 삭제창</h4>
			</div>
			<div class="modal-body">
					<input type="text" value="" readonly hidden id="reply-modify-rno" >
          			<input type="text" value="${board.bno }" readonly hidden id="reply-modify-bno">
				<div class="form-group">
					
					<input class="form-control" readonly hidden id="reply" name="reply-modify-reply" placeholder="댓글 작성해주세요">
				</div>
				<div class="form-group">
					<input class="form-control" readonly hidden id="writer" name="reply-modify-writer" >
				</div>
			</div>
				<div class="form-group">
				
				<h3 style="text-align:center">삭제하시겠습니까?</h3>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
				  <button id="reply-delete-btn1" type="button" class="btn btn-danger ">삭제</button> 
			</div>
			</div>
		</div>
	</div>	
</body>
</html>