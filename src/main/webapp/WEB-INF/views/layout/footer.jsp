<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }"></c:set>

<link rel="stylesheet" href="${conPath }/resources/css/style.css">
<style>
<!--
.list-unstyled{
	display: inline-block; 
}
-->
</style>
<hr>
<footer class="footer">
	<div class="container">
		 <div class="row">
			<div class="col-md-4">
				<a class="" href="/"><img alt="왜안나오지" src="${conPath }/resources/img/logo.png" class="logo" style="width: 150px"/></a>
				<div class="row">
					<a class="i-a" href="#"><i class="bi bi-youtube social-icons"></i></a>
					<a class="i-a" href="#"><i class="bi bi-instagram social-icons"></i></a>
					<a class="i-a" href="#"><i class="bi bi-facebook social-icons"></i></a>
				</div>
			</div>
		
			<div class="col-md-8">
				<ul class="list-unstyled">
					<li><a href="#">공지사항 </a></li>
					<li><a href="#">연락처 </a></li>
					<li><a href="#">광고문의 </a></li>
					<li><a href="#">채용 &nbsp;&nbsp;</a>|</li>
					<li><a href="#">버그제보 &nbsp;&nbsp;</a>|</li>
					<li><a href="#">개인정보 처리방 </a></li>
					<li><a href="#">서비스 이용약관</a></li>
				</ul>
				<br>
				<p class="f-p">
				상호명: <b>(주)폼폼</b> | 대표명: 김승기<br>
				사업자등록번호: 123-00-456789 | 통신판매업신고번호: 제 0000-경기도고양-01112호 | 직업정보 제공사업 신고번호: P0000020211009
				<br>주소: 서울 강남구 봉은사로 303 TGL경복빌딩 502호 (06103) 문의: info@pompom.kr <br>
				&copy; 2023 (주)폼폼, Inc. All rights reserved.
				</p>
			</div>
	
			</div>
		</div>
</footer>
