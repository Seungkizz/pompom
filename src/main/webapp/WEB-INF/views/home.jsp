<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page pageEncoding="utf-8" language="java" %>
<html>
<head>
   <title>PomPom Developer Community</title>

</head>
<style>
section {
	margin: 0 auto;
}

.center-div {
	background-color: mediumorchid;
	padding: 20px;
	font-size: 16px;
	color: white;
	border-radius: 15px;
	margin: 8px;
	width: 100%;
}

.bi-exclamation-square {
	padding-left: 100px;
	padding-right: 10px;
	color: white;
}

.btn-light {
	font-size: 12px;
}
.col-sm-6 .questionscenterimg{
	text-align: center;
}
.serveimg-left img{
	margin-left: 180px;
}
.serveimg-right img{
	margin-left: 100px;
}
.maintable h3{
	border-radius: 15px;
	padding: 15px;
}

@media screen and (max-width: 1350px) {
	.serveimg-left , .serveimg-right{
		display: none;
	}
	.col-sm-6, .maintable{
	margin: 0 auto;
	}
}
</style>

<body>
<%@ include file="./layout/header.jsp" %>
	<hr>
	<section>
	<div>
		<div class='row'>
			<div class='col-sm-3 serveimg-left'>
				<img alt="dd" src="${conPath }/resources/img/serveimg1.png" style="width: 160px; height: 235px;">
			</div>
			<div class='col-sm-6'>
				<div class="questionscenterimg">
					<img alt="" src="${conPath }/resources/img/main.jpg" style="max-width: 100%; max-height: 100%; padding: 15px;">
				</div>
				<div class="center-div">
					<i class="bi bi-exclamation-square"></i><b>폼폼잡스 베타 신규오픈 - 나에게 딱 맞는 새로운 커리어 기회를 경험해 보세요!</b>
					<button type="button" class="btn btn-light">바로가기</button>
				</div>
			</div>
			<div class='col-sm-3 serveimg-right'>
				<img alt="dd" src="${conPath }/resources/img/serveimg3.jpg" style="width: 180px; height: 300px; margin-bottom: 20px;">
			</div>
		</div>
	</div>	
	
	<div>
		<div class='row'>
			<div class='col-sm-3 serveimg-left'>
				<img alt="dd" src="${conPath }/resources/img/serveimg2.jpg" style="width: 160px; height: 235px; ">
			</div>
				<div class='col-sm-3 maintable'>
				<div>
					<h3 style="background-color: whitesmoke">Q&A</h3>
				</div>
				<div>
					<c:forEach var="mainQuestionsList" items="${mainQuestionsList }" varStatus="status">
					<c:if test="${status.count <= 5}">
					<div>
						<span>${mainQuestionsList.memberId }</span>
						<span><fmt:formatDate pattern="yyyy-MM-dd" value="${mainQuestionsList.createDate }"/></span>
						<span>${mainQuestionsList.views }</span>
						<br>
						<span>${mainQuestionsList.title }</span>
						
					</div>
					</c:if>
					</c:forEach>
				</div>
			</div>
			<div class='col-sm-3 maintable'>
				<div>
					<h3 style="background-color: whitesmoke">커뮤니티</h3>
				</div>
				<table>
						<tr>
						<th>이름</th>
						<th>내용</th>
						<th>나이</th>
						<th>ㄴㅇ</th>
						<th>ㅇㅇ</th>
					</tr>
					<tr>
						<td>gd</td>
						<td>gd</td>
						<td>gd</td>
						<td>gd</td>
						<td>gd</td>
					</tr>
				</table>
			</div>
			<div class='col-sm-3 serveimg-right'>
				<a href="https://hyphen.im/?utm_source=okky&utm_medium=banner&utm_campaign=%EB%B8%8C%EB%9E%9C%EB%94%A9&utm_content=7%EC%9B%94_%EC%84%9C%EB%B9%84%EC%8A%A4_%EC%88%98%EC%83%81" target="_blank"><img alt="dd" src="${conPath }/resources/img/serveimg4.png" style="width: 180px; height: 380px;"></a>
			</div>
		</div>
	</div>
	
	
	</section>
<%@ include file="./layout/footer.jsp" %>
</body>
</html>