<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tv" tagdir="/WEB-INF/tags/travel" %>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<title>자유 게시판 글쓰기</title>
</head>
<body>
<tv:navbar></tv:navbar>
<div class="container">
	
	<h1>글 쓰기</h1>
	<div class="row">
			
		<div class="FlexableTextArea">
			<form action="${appRoot }/board/write" method="post" enctype="multipart/form-data" >
				<div class="FlexableTextArea">
					<textarea placeholder="제목을 입력해 주세요." class="textarea_input" name="title" style="resize: none;width: 1090px;height: 36px;"></textarea>					
				</div>
			   	
			 <!--   <form class="form-category" >
	<select name="category" class="form-control mr-sm-2" style="width:176px;">
  		<option value=""></option>
  		<option value="cate1" ${cri.type == "cate1" ? 'selected' : '' }></option>
  		<option value="cate2" ${cri.type == "cate2" ? 'selected' : '' }>내용</option>
  		<option value="cate3" ${cri.type == "cate3" ? 'selected' : '' }>작성자</option>
  	</select>
  	</form>
         -->       
                        
				<div class="form-group">
					<label for="textarea1">내용</label>
						<input id="input3" class="form-control" type="file" name="file" accept="image/*">
					
						<textarea id="textarea1" class="form-control" name="content" style="resize: none;margin-top: 0px;margin-bottom: 0px;height: 614px;width: 1110px;"></textarea>
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='writer'
					value='<c:out value="${pinfo.member.nickName }"/>' readonly="readonly">
					</div>					
					
			<!--  
				<div class="setting_area">
					<ul class="set_list">
						<li class="set_item">
							<div class="FormInputCheck">
								<input id="coment" type="checkbox" class="input_check">
								<label for="coment" class="label">
							        댓글 허용   
								</label>
							</div>					
					</ul>
				</div>
				-->
				<input style="float:right;" class="btn btn-primary" type="submit" value="등록" />
			</form>
		</div>
	</div>
</div>
</body>
</html>