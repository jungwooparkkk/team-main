<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<<<<<<< HEAD
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

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="#">로고</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="#">홈 <span
					class="sr-only">(current)</span></a></li>
					
					 <sec:authorize access="!isAuthenticated()">
				<a href="${appRoot }/member/loginMem" class="dropdown-item">로그인</a>  
  		  </sec:authorize>
  		  <sec:authorize access="isAuthenticated()">
	  			<form action="${appRoot }/logout" method="post">
	  			<input type="submit" class="dropdown-item" value="로그아웃">
	 			</form>
  		  </sec:authorize>
  		  
  		  
			<li class="nav-item">
			<li class="nav-item"><a class="nav-link" href="#">맛집리스트</a></li>
			<li><a class="nav-link" href="${listUrl }">여행리스트</a></li>
			<li class="nav-item"><a class="nav-link" href="#">자유게시판</a></li>
		</ul>


	  <form action="${listUrl }" method="get" class="form-inline">
  	<select name="type" class="form-control mr-sm-2">
  		<option value="TWC" ${cri.type == "TWC" ? 'selected' : '' }>전체검색</option>
  		<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목</option>
  		<option value="C" ${cri.type == "C" ? 'selected' : '' }>내용</option>
  		<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자</option>
=======
<c:url value="/eatboard/list" var="listUrl">
	<c:if test="${not empty cri.pageNum }">
		<c:param name="pageNum" value="${cri.pageNum }"></c:param>
	</c:if>
	<c:if test="${not empty cri.amount }">
		<c:param name="amount" value="${cri.amount }"></c:param>
	</c:if>
		<c:param name="keyword" value="${cri.keyword }"></c:param>
		<c:param name="type" value="${cri.type }"></c:param>
</c:url>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="#">로고</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="#">홈 <span
					class="sr-only">(current)</span></a></li>
					
					 <sec:authorize access="!isAuthenticated()">
				<a href="${appRoot }/member/loginMem" class="dropdown-item">로그인</a>  
  		  </sec:authorize>
  		  <sec:authorize access="isAuthenticated()">
	  			<form action="${appRoot }/logout" method="post">
	  			<input type="submit" class="dropdown-item" value="로그아웃">
	 			</form>
  		  </sec:authorize>
  		  
  		  
			<li class="nav-item">
			<a class="nav-link" href="${listUrl }">맛집리스트</a></li>
			<li class="nav-item"><a class="nav-link" href="#">여행리스트</a></li>
			<li class="nav-item"><a class="nav-link" href="#">자유게시판</a></li>
		</ul>


	  <form action="${listUrl }" method="get" class="form-inline">
  	<select name="type" class="form-control mr-sm-2">
  		<option value="TWCA" ${cri.type == "TWCA" ? 'selected' : '' }>전체검색</option>
  		<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목</option>
  		<option value="C" ${cri.type == "C" ? 'selected' : '' }>내용</option>
  		<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자</option>
  		<option value="A" ${cri.type == "A" ? 'selected' : '' }>주소</option>
>>>>>>> branch 'master' of https://github.com/twp3379/team-main.git
  	</select>
  
    <input  name="keyword" value="${cri.keyword }" class="form-control mr-sm-2" type="search" placeholder="맛집, 여행 찾아보기" aria-label="Search">
    
    <input type="hidden" name="pageNum" value="1">
    <input  type="hidden" name="amount" value="${cri.amount }">
    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
  </form>
		<button class="btn btn-outline-dark" type="submit">
			<i class="bi-cart-fill me-1"></i> 찜리스트 <span
				class="badge bg-dark text-white ms-1 rounded-pill">0</span>
		</button>
	</div>
	
	
</nav>