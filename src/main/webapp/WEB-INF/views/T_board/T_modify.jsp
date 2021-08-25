<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bd" tagdir="/WEB-INF/tags/travel" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file ="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>여행 리스트</title>

<script>
$(document).ready(function(){
	var modifyUrl = "${appRoot }/T_board/T_modify";
	var removeUrl = "${appRoot }/T_board/T_remove";
	$("#board-remove-btn1").click(function(){
		if(confirm("삭제 하시겠습니까?")){
			$("#modify-form1").attr("action", removeUrl);
			$("#modify-form1").submit();
		}
	});
});
</script>
</head>
<body>
<bd:navbar></bd:navbar>
<div class="container">
	<h1>글 수정 / 삭제</h1>
	
	<div class="row">
		<div class="col-12">
			<form id="modify-form1" action="${appRoot}/T_board/T_modify" method="post" enctype="multipart/form-data">
				<input hidden name="bno" value="${board.bno }" />
				<div class="form-group">
					<label for="input1">제목</label>
					<input id="input1" value="${board.title }" class="form-control" name="title">
				</div>
				
				<div class="form-group">
					<label for="address1">주소</label>
					<input id="address1" class="form-control" name="address" value="${board.address}">
				</div>
				
				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea id="textarea1" class="form-control" name="content"><c:out value="${board.content }"></c:out></textarea>
				</div>
				<c:if test="${not empty board.fileName }">
					<div>
						<img class="img-fluid" 
						src="${imgRoot}travel_file/${board.bno }/${board.fileName}">
					</div>
				</c:if>
				<div class="form-group">
					<label for="input3">파일</label>
					<input id="input3" class="from-control" type="file" name="file" accept="image/*">
				</div>  
				
				<div class="form-group">
					<label for="input2">작성자</label>
					<input type="hidden" readonly="readonly" id="input2" class="form-control" name="writer" value="${board.writer}">
					<input readonly="readonly" class="form-control" value="${board.writerName }">
				</div>	
				
				<input hidden name="pageNum" value="${cri.pageNum }" />
				<input hidden name="amount" value="${cri.amount }" />			
				<input hidden name="type" value="${cri.type}" />			
				<input hidden name="keyword" value="${cri.keyword }" />			
				<input class="btn btn-warning" type="submit" value="수정" />
				<input id="board-remove-btn1" class="btn btn-danger" type="button" value="삭제" />
				
								<c:url value="/T_board/T_list" var="listUrl">
					<c:if test="${not empty cri.pageNum }">
						<c:param name="pageNum" value="${cri.pageNum }"></c:param>
					</c:if>
					<c:if test="${not empty cri.amount }">
						<c:param name="amount" value="${cri.amount }"></c:param>
					</c:if>
						<c:param name="keyword" value="${cri.keyword }"></c:param>
						<c:param name="type" value="${cri.type }"></c:param>
				</c:url>
				<a class="btn btn-secondary" href="${listUrl }">글 목록</a>
			</form>
		</div>
	</div>
	
	
</div>
</body>
</html>