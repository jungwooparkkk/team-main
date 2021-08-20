<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="bd" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<link rel="stylesheet" href="${appRoot }/resources/css/eatboard.css" />

<!-- <script>
var appRoot = '${appRoot}';

<sec:authorize access="isAuthenticated()" >
var userid = '<sec:authentication property="principal.username" />';
</sec:authorize> -->

<script>
   var appRoot = "${appRoot}";
   var userid = "${pinfo.member.userid}";
</script>


</script>
<script src="${appRoot }/resources/js/eatget.js"></script>
<title>맛집 리스트</title>
<script>
	$(document).ready(function() {
		$("#list-pagenation1 a").click(function(e) {
			// 기본 액션 중지 (hyperlink 역할 안함)
			e.preventDefault();

			console.log("a요소 클릭됨");

			var actionForm = $("#actionForm");

			// form의 pageNum input의 값을 a 요소의 href값으로 변경
			actionForm.find("[name=pageNum]").val($(this).attr("href"));

			// submit
			actionForm.submit();
		});
	});
</script>
</head>
<body>
	<bd:navbar />

	<div class="container eat-board">
		<h1>글 목록</h1>

		<c:url value="/eatboard/register" var="registerUrl">
			<c:if test="${not empty cri.pageNum }">
				<c:param name="pageNum" value="${cri.pageNum }"></c:param>
			</c:if>
			<c:if test="${not empty cri.amount }">
				<c:param name="amount" value="${cri.amount }"></c:param>
			</c:if>
			<c:param name="keyword" value="${cri.keyword }"></c:param>
			<c:param name="type" value="${cri.type }"></c:param>
		</c:url>
		<div class="btn-wrap">
			<a class="btn btn-secondary" href="${registerUrl }">글작성</a>
		</div>
		<div class="eat-board-list">
			<ul class="clearfix">
				<c:forEach items="${list }" var="board">
					<li class="item"><c:url value="/eatboard/get" var="eatgetUrl">
							<c:param name="eatbno" value="${board.eatbno }" />
							<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
							<c:param name="amount" value="${pageMaker.cri.amount }" />
							<c:param name="type" value="${pageMaker.cri.type }" />
							<c:param name="keyword" value="${pageMaker.cri.keyword }" />
						</c:url>
						<a class="img" href="${eatgetUrl }">
							<img src="${imgRoot}${board.eatbno }/${board.fileName}">
						</a>
							<a class="item-title" href="${eatgetUrl }">
							<span class="list-num">${board.eatbno }</span>
							<span class="title">${board.title }</span>
							</a>
						<a class="item-content" href="${eatgetUrl }">
						<div class="address">${board.address }</div>
						<div class="kategorie">${board.kategorie }</div>
						<div class="content">${board.content }</div>
						</a>
						<div class="writer">${board.writerName}</div>
						<div class="item-info">
							<div class="reply">
								<i class="far fa-comment-dots"></i>&nbsp;${board.replyCnt }
							</div>
							<div class="view">
								<i class="far fa-eye"></i>&nbsp;${board.views }
							</div>
							<%-- <button class="like _like" id="like-button1" data-operation="like">
								<i id="like-icon1" class="far fa-heart"></i>&nbsp;<span id="like-cnt1">${board.likesCnt }</span>	
							</button> --%>
							
							
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
						<div class="date">
							<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" />
						</div></li>
				</c:forEach>
			</ul>
		</div>
		<!--  pagination -->
		<div>
			<nav aria-label="Page navigation">
				<ul id="list-pagenation1" class="pagination justify-content-center">

					<c:if test="${pageMaker.prev }">
						<li class="page-item"><a class="page-link"
							href="${pageMaker.startPage - 1 }">Previous</a></li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="num">
						<%-- href value
		href="${appRoot }/board/list?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}"
		 --%>
						<li class="page-item ${num == cri.pageNum ? 'active' : '' }"><a
							class="page-link" href="${num }">${num }</a></li>
					</c:forEach>

					<c:if test="${pageMaker.next }">
						<li class="page-item"><a class="page-link"
							href="${pageMaker.endPage - 1 }">Next</a></li>
					</c:if>
				</ul>
			</nav>

			<!-- 페이지 링크용 from -->
			<div style="display: none;">
				<form id="actionForm" action="${appRoot }/eatboard/list"
					method="get">
					<input name="pageNum" value="${cri.pageNum }" /> <input
						name="amount" value="${cri.amount }" /> <input name="type"
						value="${cri.type }" /> <input name="keyword"
						value="${cri.keyword }" />
				</form>
			</div>

		</div>
	</div>



	<c:if test="${not empty result }">
		<script>
			$(document).ready(function() {

				if (history.state == null) {
					console.log("어서와 처음이지!!!");

					$("#eatboard-modal1").modal('show');
					history.replaceState({}, null);

				} else {

					console.log("너 전에 왔었어!!!!");
				}

			});
		</script>

		<div id="eatboard-modal1" class="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">${messageTitle }</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>${messageBody }</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>


	</c:if>
</body>
</html>