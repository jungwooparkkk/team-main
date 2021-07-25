<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bd" tagdir="/WEB-INF/tags/board"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<script src="res/js/all.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
	crossorigin="anonymous"></script>
<style>
</style>
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
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>
</head>
<!-- 네비게이션 -->
<body>
	<bd:navbar />
	<div class="container">
		<!-- Header-->
		<header class="bg-dark py-5">
			<div class="container px-4 px-lg-5 my-5">
				<div class="text-center text-white">
					<h1 class="display-4 fw-bolder">맛집리스트</h1>
					<p class="lead fw-normal text-white-50 mb-0">어디까지 먹어봤니?!</p>
				</div>
			</div>
		</header>
		<section class="py-5">
			<div class="container px-4 px-lg-5 mt-5">
				<div
					class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
					<div class="col mb-5">
						<div class="card h-70">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto" href="#"> <!-- Product image-->
									<img class="card-img-top"
									src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg"
									alt="..." /> <!-- Product details-->
									<div class="card-body p-4">
										<div class="text-center">
											<!-- Product name-->
											<h5 class="fw-bolder">제목</h5>
											<!-- Product price-->
											카테고리 <br>
											음식 <br>
											위치 <br>
											등등
										</div>
									</div>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

	<h1>글 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="eatboard">
				<tr>
					<td>${eatboard.eatbno }</td>
					<td>
					
					<c:url value="/eatboard/get" var="getUrl">
						<c:param name="eatbno" value="${eateatboard.eatbno }" />
						<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
						<c:param name="amount" value="${pageMaker.cri.amount }" />
						<c:param name="type" value="${pageMaker.cri.type }"/>
						<c:param name="keyword" value="${pageMaker.cri.keyword }"/>
					</c:url>
					
					<a href="${getUrl }">
						${eatboard.title }
						<%-- <c:if test="${board.replyCnt >0 }">
							[${board.replyCnt }]
						</c:if> --%>
					</a>
					
					</td>
					<%-- <td>${eatboard.writerName }</td> --%>
					<td>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${eatboard.regdate }"/>
					</td>
					<%-- <td>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/>
					</td> --%>
				</tr>
			</c:forEach>			
		</tbody>
	</table>
</div>

<!--  pagination -->
<div>
<nav aria-label="Page navigation example">
  <ul id="list-pagenation1" class="pagination justify-content-center">
  
  	<c:if test="${pageMaker.prev }">
	    <li class="page-item">
	      <a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
	    </li>
  	</c:if>
	
	<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
	<%-- href value
	href="${appRoot }/board/list?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}"
	 --%>
	    <li class="page-item ${num == cri.pageNum ? 'active' : '' }"><a class="page-link" 
	    href="${num }">${num }</a></li>
	</c:forEach>

	<c:if test="${pageMaker.next }">
	    <li class="page-item">
	      <a class="page-link" href="${pageMaker.endPage - 1 }">Next</a>
	    </li>
	</c:if>
  </ul>
</nav>

<!-- 페이지 링크용 from -->
<div style="display: none;">
	<form id="actionForm" action="${appRoot }/eatboard/list" method="get">
		<input name="pageNum" value="${cri.pageNum }" />
		<input name="amount" value="${cri.amount }" />
		<input name="type" value="${cri.type }" />
		<input name="keyword" value="${cri.keyword }" />
	</form>
</div>

</div>

<c:if test="${not empty result }" >
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
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>${messageBody }</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


</c:if>
</body>
</html>