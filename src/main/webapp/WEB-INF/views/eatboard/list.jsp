<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="bd" tagdir="/WEB-INF/tags/board" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<link rel="stylesheet" href="${appRoot }/resources/css/eatboard.css"/>
<title>Insert title here</title>

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
	<div class="container">
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
	<a class="btn btn-secondary" href="${registerUrl }">글작성</a>
	
 	<table class="table table-striped">
		<thead>
			<tr>
				<th>이미지</th>
				<th>#</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<!-- <th>수정일</th> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="board">
				<tr>
					<td>
						<img class="img-fluid" 
						src="${imgRoot}${board.eatbno }/${board.fileName}">
					</td>
					<td>${board.eatbno }</td>
					<td>
					
					<c:url value="/eatboard/get" var="getUrl">
						<c:param name="eatbno" value="${board.eatbno }" />
						<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
						<c:param name="amount" value="${pageMaker.cri.amount }" />
						<c:param name="type" value="${pageMaker.cri.type }"/>
						<c:param name="keyword" value="${pageMaker.cri.keyword }"/>
					</c:url>
					
					<a href="${getUrl }">
						${board.title }
					</a>
					<c:if test="${board.replyCnt > 0 }">
						<i class="far fa-comment-dots"></i> ${board.replyCnt }
					</c:if>
					
					
					</td>
					<td>${board.writerName}</td>
					<td>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/>
					</td>
					 <%-- <td>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/>
					</td>  --%>
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