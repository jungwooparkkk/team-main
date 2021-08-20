<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="bd" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>자유 게시판</title>
  
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
	<h2>자유 게시판</h2>
	<table class="table table-striped">
		<thead>
			<tr>
				
				<th style="
					width: 74px;
					"
					>말머리</th>
				<th>제목</th>
				<th style="
					width: 94px;
					">작성자</th>
				<th style="
					width: 74px;
					">작성일</th>
				<th style="
					width: 74px;
					">조회수</th>
				<th style="
    				padding-left: 2px;
    				padding-right: 0.5;
    				padding-right: 0.5;
    				padding-right: 1px;
    				width: 53px;
					">좋아요</th>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="board">
				<tr>
					<td style=text-align:center>${board.bno }</td>
					<td>
					
					<c:url value="/board/get" var="getUrl">
						<c:param name="bno" value="${board.bno }" />
						<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
						<c:param name="amount" value="${pageMaker.cri.amount }" />
					
					</c:url>
					
					<a href="${getUrl}">
						${board.title } 
					</a>
					
						
					
					</td>
					<td style=text-align:center>${board.writer }</td>
					<td style=text-align:center>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/>
					</td>
					<td style=text-align:center>${board.views }</td>
					<td style=text-align:center>${board.likesCnt }</td>
				</tr>
			</c:forEach>			
		</tbody>
	</table>
		<a class="btn btn-primary" href="${appRoot }/board/write" role="button" id="writebutton" style="float:right;">글쓰기</a>
	
</div>

<!--  pagenation -->
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
	      <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
	    </li>
	</c:if>
  </ul>
</nav>
<%-- 페이지 링크용 form --%>
<div style="display: none;">
	<form id="actionForm" action="${appRoot }/board/list" method="get">
	<select name='type'>
					<option value="">--</option>
					<option value="T">제목</option>
					<option value="C">내용</option>
					<option value="W">작성자</option>
	</select>
		<input name="pageNum" value="${pageMaker.cri.pageNum }" />
		<input name="amount" value="${pageMaker.cri.amount }" />
	
	</form>
	
</div>


</div>



</body>
</html>













