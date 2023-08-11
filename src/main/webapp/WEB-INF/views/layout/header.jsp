<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<style type="text/css">
.dropdown-toggle{
width: 70px;
text-align: center;
}
.dropdown-menu{
width: 500px;
}
.collapse .navbar-nav li a:hover{
	background-color: #cccc;
}
.bi-bell, .bi-bookmark, .bi-bookmark-fill{
color: black;
padding-right: 15px;
}
.bi{
	font-size: 22px;
}
@media screen and (min-width: 980px) {
	.service-nav{
		display: none;
	}
}
</style>

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light mx-5">
		<a class="navbar-brand" href="/"><img alt="왜안나오지" src="${conPath }/resources/img/logo.png" style="width: 120px; padding-top: 10px;"/></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
			
				<li class="nav-item" style="margin-right: 30px;"><a class="nav-link active" aria-current="page" href="<c:url value ='${conPath }/board/questions'/>">Q&A</a></li>
				<li class="nav-item" style="margin-right: 30px;"><a class="nav-link" href="#">지식</a></li>
				<li class="nav-item" style="margin-right: 30px;"><a class="nav-link" href="#">커뮤니티</a></li>
				<li class="nav-item" style="margin-right: 100px;"><a class="nav-link" href="#">공지사항</a></li>
				<c:if test="${auth != null }">
				<hr>
				<li class="nav-item service-nav" style="margin-right: 30px;">${auth.name }</li>
				<li class="nav-item service-nav" style="margin-right: 30px;"><a class="nav-link" href="#">회원정보</a></li>
				<li class="nav-item service-nav" style="margin-right: 30px;"><a  class="nav-link" href="#">계정</a></li>
				<li class="nav-item service-nav" style="margin-right: 30px;"><a class="nav-link" href="#">활동내역</a></li>
				<hr>
				<li class="nav-item service-nav" style="margin-right: 30px;"><a class="nav-link" href="<c:url value ='${conPath}/member/logout'/>">로그아웃</a></li>
				</c:if>
			</ul>
		</div>
		<div class="collapse navbar-collapse">
			<form class="form-inline my-2 my-lg-0" action="https://www.google.com/search" method="GET" target="_blank">
				<input class="form-control mr-sm-2" type="text" name="q" placeholder="검색" aria-label="Search">
				<button class="btn btn-outline-dark my-2 my-sm-0" type="submit">검색</button>
			</form>
			
			<ul class="navbar-nav ml-auto mb-2 mb-lg-0">
			
			<c:choose>
				<c:when test="${auth == null}"> 
					<li class="nav-item rounded-pill bg-light" style="margin-right: 20;"><a class="nav-link active" href="<c:url value ='${conPath }/member/loginForm'/>">로그인</a></li>
					<li class="nav-item rounded-pill bg-primary"><a class="nav-link text-white" href="<c:url value ='${conPath }/member/registForm'/>">회원가입</a></li>
				</c:when>
				<c:otherwise>
				
				<li class="nav-item rounded-pill"><a class="nav-link text-white" href="<c:url value ='${conPath }/member/activity'/>"><i class="bi bi-bookmark"></i></a></li>
				<li class="nav-item rounded-pill"><a class="nav-link text-white" href="#"><i class="bi bi-bell"></i></a></li>
				
            <li class="nav-item rounded-pill bg-light dropdown" style="margin-right: 20;">
                <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="bi bi-three-dots"></i>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
               				 
                    <a class="dropdown-item" href="<c:url value ='${conPath }/member/myPage'/>">내정보</a>
                    <a class="dropdown-item" href="<c:url value ='${conPath }/member/activity'/>">활동내역</a>
                    <hr>
                    <a class="dropdown-item" href="<c:url value ='${conPath}/member/logout'/>">로그아웃</a>
                </div>
            </li>
        </c:otherwise>
			</c:choose>
			</ul>
			
		</div>
		
	</nav>
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
</body>
</html>

