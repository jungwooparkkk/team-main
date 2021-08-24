<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<nav class="navbar navbar-expand-sm navbar-light bg-light">
  <a class="navbar-brand" href="${appRoot }/main/mainPage" style="
    width: 500px;"><img src="${appRoot }/resources/img/logo.jpg" style="width: 40px;height: 30px;"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>


	<form class="form-inline my-2 my-lg-0" >
	<select name="type" class="form-control mr-sm-2">
  		<option value="">--</option>
  		<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목</option>
  		<option value="C" ${cri.type == "C" ? 'selected' : '' }>내용</option>
  		<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자</option>
  	</select>
      <input name="keyword" value="${cri.keyword }" form-control mr-sm-0" type="search" placeholder="" aria-label="Search">
      <button  class="btn btn-outline-success my-2 my-sm-0-right" type="submit">검색</button>
    </form>
    
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav ml-auto">
      <li class="nav-item dropdown">
         <a  class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         	<i class="fas fa-list"></i>메뉴
        </a>
        <div class="dropdown-menu dropdown-menu-right"  aria-labelledby="navbarDropdown">
          <sec:authorize access="!isAuthenticated()">
				<a href="${appRoot }/member/loginMem" class="dropdown-item">로그인</a>
				<a href="${appRoot }/member/signupMem" class="dropdown-item" href="#">회원 가입</a>  
  		  </sec:authorize>
  		  <sec:authorize access="isAuthenticated()">
	  			<form action="${appRoot }/logout" method="post">
	  			<input type="submit" class="dropdown-item" value="로그아웃">
	  			<a href="${appRoot }/member/infoMem" class="dropdown-item" href="#">내정보</a>
	  			<a href="${appRoot }/member/infoModify" class="dropdown-item" href="#">정보 수정</a>
	 			</form>
  		  </sec:authorize>
  		 
          
          <a href="${appRoot }/eatboard/list" class="dropdown-item" href="#">맛집</a>
          <a href="${appRoot }/T_board/T_list" class="dropdown-item" href="#">여행</a>
          <a class="dropdown-item" href="${appRoot }/board/list">
          <div class="dropdown-divider" ></div>자유 게시판</a>
        </div>
      </li>
   </ul>
  </div>
</nav>