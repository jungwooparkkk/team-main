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
			
		<div class="col-12">
			<form action="${appRoot }/board/write" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<textarea placeholder="제목을 입력해 주세요." class="form-control" name="title" style="height: 40px;width: 826px;"></textarea>
						
				</div>
			<!--    	<div class="column_category"><div class="FormSelectButton" candidates="[object Object]" style="
    width: 150px;
    height: 32px;
"><button type="button" aria-haspopup="true" aria-expanded="selectboxLayer" aria-pressed="selectboxLayer" class="button" style="
    width: 116px;
    height: 31px;
">
        말머리 선택
        <svg aria-hidden="true" class="svg-icon ico-common-menu-hide-big-default"><use xlink:href="#ico-common-menu-hide-big-default"></use></svg></button></div><div class="select_option" style="display: none;"><div class="option_box"><button type="button" class="option_none">
                        말머리 선택 안 함
                    </button></div><ul class="option_list" style=""><li class="item"><button type="button" class="option">
                            말머리1
                        </button></li></ul></div></div> 
                        -->
				
				<div class="form-group">
					<label for="textarea1">내용</label>
					
					<textarea id="textarea1" class="form-control" name="content" style="margin-top: 0px;margin-bottom: 0px;height: 614px;width: 1110px;"></textarea>
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='writer'>
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