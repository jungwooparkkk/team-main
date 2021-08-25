<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
  <meta name="generator" content="Hugo 0.80.0">
  <title>맛집여행정보</title>
  <link rel="shortcut icon" href="favicon.ico">
  <link rel="icon" href="favicon.ico">

  <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/carousel/">



  <!-- Bootstrap core CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">



  <style>
    .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
    }

    @media (min-width: 768px) {
      .bd-placeholder-img-lg {
        font-size: 3.5rem;
      }
    }
  </style>


  <!-- Custom styles for this template -->
  <link href="${appRoot }/resources/css/carousel.css" rel="stylesheet">
  <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
    <a class="navbar-brand" href="#"><img src="${appRoot }/resources/img/logo.jpg"width="40" height="30""></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  
    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
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
	  			<a href="${appRoot }/member/infoMem" class="dropdown-item" href="#">정보 수정</a>
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
</head>

<body>
   
 

  <main role="main">


    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="carousel-item active">
     	<a href="${appRoot }/eatboard/list" ><img src="${appRoot }/resources/img/coffe.jpg" width="100%" height="100%"></a>

          <div class="container">
            <div class="carousel-caption">
              <h1>맛집</h1>
             
            </div>
          </div>
        </div>
        <div class="carousel-item">
          <a href="${appRoot }/T_board/T_list" > <img src = "${appRoot }/resources/img/mainT.jpg"  width="100%" height="100%">

          <div class="container">
            <div class="carousel-caption">
              <h1>여행</h1>
              

            </div>
          </div>
        </div>
        <div class="carousel-item">
          <a href="${appRoot }/board/list" > <img src = "${appRoot }/resources/img/mainF.jpg"  width="100%" height="100%">

          <div class="container">
            <div class="carousel-caption">
              <h1>자유게시판</h1>
             
            </div>
          </div>
        </div>
      </div>
      <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
	
	<br>
	<br>
	<br>
	<br>
	<br>

    <!-- Marketing messaging and featurettes
  ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container marketing">

      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-4">
        <a href="${appRoot }/eatboard/list" ><img src="${appRoot }/resources/img/fboard.jpg"width="140" height="140""></a>
            <rect width="100%" height="100%" fill="#777" /><text x="50%" y="50%" fill="#777" dy=".3em"></text>
          </svg>

          <h2>맛집게시판</h2>
         

        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
         <a href="${appRoot }/T_board/T_list" ><img src="${appRoot }/resources/img/tboard.jpg"width="140" height="140""></a>
            <rect width="100%" height="100%" fill="#777" /><text x="50%" y="50%" fill="#777" dy=".3em"></text>
          </svg>

          <h2>여행게시판</h2>
       
<!-- width="140" height="140" -->
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
         
          <a href="${appRoot }/board/list" ><img src="${appRoot }/resources/img/board.jpg"width="140" height="140""></a>

          <h2>자유게시판</h2>
          

        </div><!-- /.col-lg-4 -->
      </div><!-- /.row -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
      <section class="page-section" id="contact">
        <div class="container">
          <div class="text-center">
            <h2 class="section-heading text-uppercase">문의하기</h2>
            
          </div>
          <form id="contactForm" data-sb-form-api-token="API_TOKEN">
            <div class="row align-items-stretch mb-5">
              <div class="col-md-6">
                <div class="form-group">
                  <!-- Name input-->
                  <input class="form-control" id="name" type="text" placeholder="Your Name *"
                    data-sb-validations="required" />
                  <div class="invalid-feedback" data-sb-feedback="name:required">A name is required.</div>
                </div>
                <div class="form-group">
                  <!-- Email address input-->
                  <input class="form-control" id="email" type="email" placeholder="Your Email *"
                    data-sb-validations="required,email" />
                  <div class="invalid-feedback" data-sb-feedback="email:required">An email is required.</div>
                  <div class="invalid-feedback" data-sb-feedback="email:email">Email is not valid.</div>
                </div>
                <div class="form-group mb-md-0">
                  <!-- Phone number input-->
                  <input class="form-control" id="phone" type="tel" placeholder="Your Phone *"
                    data-sb-validations="required" />
                  <div class="invalid-feedback" data-sb-feedback="phone:required">A phone number is required.</div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group form-group-textarea mb-md-0">
                  <!-- Message input-->
                  <textarea class="form-control" id="message" placeholder="Your Message *"
                    data-sb-validations="required"></textarea>
                  <div class="invalid-feedback" data-sb-feedback="message:required">A message is required.</div>
                </div>
              </div>
            </div>
            <!-- Submit success message-->
            <!---->
            <!-- This is what your users will see when the form-->
            <!-- has successfully submitted-->
            <div class="d-none" id="submitSuccessMessage">
              <div class="text-center text-white mb-3">
                <div class="fw-bolder">Form submission successful!</div>
                To activate this form, sign up at
                <br />
                <a
                  href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>
              </div>
            </div>
            <!-- Submit error message-->
            <!---->
            <!-- This is what your users will see when there is-->
            <!-- an error submitting the form-->
            <div class="d-none" id="submitErrorMessage">
              <div class="text-center text-danger mb-3">Error sending message!</div>
            </div>
            <!-- Submit Button-->
            <div class="text-center"><button class="btn btn-primary btn-xl text-uppercase disabled" id="submitButton"
                type="submit">Send Message</button></div>
          </form>
        </div>
      </section>


      <!-- FOOTER -->
      <footer class="container">
        <p class="float-right"><a href="#">위로</a></p>
        
      </footer>
  </main>


  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="${appRoot }/resources/js/bootstrap.bundle.min.js"></script>


</body>

</html>