<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>수정 페이지</title>
</head>

<script type="text/javascript">
$(document).ready(function(){
	
	var formObj = $("form");
	
	$('button').on("click", function(e){
		
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if(operation === 'remove'){
			formObj.attr("action", "${appRoot}/board/remove");
		}else if(operation === 'list'){
		formObj.attr("action", "${appRoot}/board/list").attr("method", "get");
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		var keywordTag = $("input[name='keyword']").clone();
		var typeTag = $("input[name='type']").clone();
		
		formObj.empty();
		formObj.append(pageNumTag);
		formObj.append(amountTag);		
		formObj.append(keywordTag);
		formObj.append(typeTag);
	}
	formObj.submit();
	});
});

</script>
<body>
<div class="container">
	<form role="form" action="${appRoot }/board/modify" method="post">
	
	<input hidden name="bno" value="${board.bno }" />
	<div class="form-group">
			<label for="input1">제목</label>
			<input id="input1" value="${board.title }" class="form-control" name="title">
	</div>
	
	<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea id="textarea1" class="form-control" 
					name="content"><c:out value="${board.content }" /></textarea>
				</div>
	<input hidden name="writer" value="${board.writer }" />
	<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
	
	<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
	
	</form>
</div>
</body>
</html>