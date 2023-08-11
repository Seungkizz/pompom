<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page pageEncoding="utf-8" language="java"%>
<html>
<head>
<title>PomPom Developer Community</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="${conPath }/resources/js/jslink.js"></script>
<style>
section {
	margin: 0 auto;
}

.serveimg-left {
	display: flex;
	justify-content: center;
}

.serveimg-right img {
	margin-left: 100px;
}

.tagdiv {
	display: flex;
	justify-content: center;
	flex-direction: column;
}

.tagdiv .item {
	margin: 0 auto;
}

.intagdiv, .inwritersdiv {
	display: flex;
	justify-content: space-between;
}

.intagdiv a {
	padding: 5px;
	color: black;
}

.intagdiv span, .inwritersdiv span {
	font-size: 20px;
	color: skyblue;
}

.topwriters {
	clear: none;
}

.center-div {
	background-color: whitesmoke;
	padding: 20px;
	font-size: 16px;
	color: black;
	border-radius: 15px;
	margin: 8px;
	width: 100%;
}

.bi-diamond {
	font-size: 5px !important;
	padding-left: 5px;
	padding-right: 5px;
}

.bi-patch-question {
	padding-right: 10px;
	color: black;
}

.d-flex a button .bi-pencil {
	color: white;
	padding: 5px;
	font-size: 14px;
}

.d-flex a .bg-primary {
	color: white;
	padding: 5px;
	font-size: 13px;
}

.col-sm-6 .questionscenterimg {
	text-align: center;
}

span {
	font-size: 25px;
}

.question-author {
	border-top: 1px solid #cccc;
}
.question-author span{
	font-size: 14px;	
}

.topic {
	background-color:#E6E6FA;
	border-radius: 5px;
	font: skyblue;
	padding: 3px;
	margin-right: 20px;
	
}

.hashtag {
	margin-right: 10px;
}

.hashtag:hover {
	color: skyblue;
}

.question-author {
	clear: left;
}

.question-container a {
	text-decoration: none !important;
	color: black;
}

.question-topik {
	float: left;
	padding: 10px;
}

.question-stats {
	float: right;
}

.question-title {
	font-size: 18px;
	font-weight: 600;
	padding: 5px;
}
.question-title span{
	font-size: 14px;
}
nav span{
	font-size: 16px;
}
.form-select{
	border-radius: 10px;
}
.question-content{
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 600px;
    height: 40px;
    color: 	#A9A9A9;
    font-size: 14px;
    padding: 5px;
}

@media screen and (max-width: 1350px) {
	.serveimg-left, .serveimg-right, .tagdiv {
		display: none;
	}
	.col-sm-6 {
		margin: 0 auto;
	}
}
</style>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	
	<c:if test="${Success != null}">
		<script type="text/javascript">
			alert("삭제성공!");
		</script>
	</c:if>
	<c:if test="${SuccessWrite != null}">
		<script type="text/javascript">
			alert("작성완료!");
		</script>
	</c:if>
	<hr>
	<section>
		<div class='row'>

			<div class='col-sm-3 serveimg-left'>
				<img alt="dd" src="${conPath }/resources/img/serveimg1.png"
					style="width: 160px; height: 235px;">
			</div>

			<div class='col-sm-6'>
				<div class="questionscenterimg">
					<a href="https://gdu.co.kr/process/process_010100.html"
						target="_blank"><img alt=""
						src="${conPath }/resources/img/questionscenter.png"
						style="max-width: 100%; max-height: 100%; padding: 15px;"></a>
				</div>
				<div class="center-div">
					<span><b>Q&A</b></span>
					<p>좋은 질문과 답변으로 동료의 시간을 아껴주세요.</p>
				</div>
				<div class="d-flex justify-content-around">
					<a href="<c:url value ='${conPath }/board/writeForm'/>"><button class="btn bg-primary"> <i class="bi bi-pencil"></i>질문하기</button></a>
					<a href="#"><button class="btn">기술</button></a>
					<a href="#"><button class="btn">커리어</button></a>
					<a href="#"><button class="btn">기타</button></a>
					<a href="#"><button class="btn active">전체</button></a>
				<select id="cntPerPage" name="sel" class="form-select" onchange="selChange()">
				    <option value="7" <c:if test="${paging.cntPerPage == 7}">selected</c:if>>기본값</option>
				    <option value="10" <c:if test="${paging.cntPerPage == 10}">selected</c:if>>10개씩 보기</option>
				    <option value="15" <c:if test="${paging.cntPerPage == 15}">selected</c:if>>15개씩 보기</option>
				    <option value="20" <c:if test="${paging.cntPerPage == 20}">selected</c:if>>20개씩 보기</option>
				</select>
				</div>
			</div>

			<div class='col-sm-3 serveimg-right'>
				<img alt="dd" src="${conPath }/resources/img/1688434275710.png"
					style="width: 180px; height: 300px; margin-bottom: 20px;">
			</div>

		</div>

		<div class='row'>
			<div class='col-sm-3 tagdiv'>
				<div class="item"
					style="width: 160px; height: 235px; margin-bottom: 120px;">
					<h5>#인기태그</h5>
					<hr>
					<c:forEach items="${tagCount}" var="tagCount">
						<div class="intagdiv">
							<a href="#" class="hashtag">#${tagCount.name}</a><span>${tagCount.usage_count}</span>
						</div>
					</c:forEach>
				</div>

				<div class="topwriters">
					<div class="item" style="width: 160px; height: 235px;">
						<h5>Top Writers</h5>
						<hr>
						<c:forEach items="${topWriters}" var="topWriters">
							<div class="inwritersdiv">${topWriters.memberId}<span>${topWriters.total_posts}</span>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			
			<div class='col-sm-6' id="center">
				<div class="question-container" id="questioncontainer">
					<c:forEach items="${questionsList}" var="questionsList">
						<div class="question-author">
							<c:choose>
							<c:when test="${imgMap.containsKey(questionsList.memberId)}">
								<c:set var="fileCallPaths" value="${imgMap.get(questionsList.memberId)}" />
							    <c:forEach items="${fileCallPaths}" var="fileCallPath">
							        <img src="<c:url value='${fileCallPath}'/>" class="rounded-circle" style="width: 25px; height: 25px;" id="profileImage">
							    </c:forEach>
							</c:when>
							<c:otherwise>
							<img src="<c:url value='${conPath }/resources/img/basic.jpg'/>" class="rounded-circle" style="width: 25px; height: 25px;" id="profileImage">
							</c:otherwise>
							</c:choose>
							<a href="#">${questionsList.memberId}</a><i class="bi bi-diamond"></i>
							<input type="hidden" id="createDate" value="${questionsList.createDate}">
							<input type="hidden" id="modifyDate" value="${questionsList.modifyDate}">
							<span class="timeago"></span>
						</div>
						<div class="question-title">
							<a href="<c:url value ='${conPath }/board/questionsView?Bno=${questionsList.bno}'/>">${questionsList.title}</a>
						</div>
						<div class="question-content">
							${questionsList.content}
						</div>

						<div class="question-topik">
							<c:forEach items="${questionsList.topikDTO}" var="questionsListTopikDTO" varStatus="status">
								<c:if test="${status.count eq 1}">
									<a href="#" class="topic">${questionsListTopikDTO.topikname}</a>
								</c:if>
							</c:forEach>

							<c:forEach items="${BoardTagList}" var="BoardTagList">
								<c:if test="${BoardTagList.bno == questionsList.bno}">
									<a href="#" class="hashtag">#${BoardTagList.name}</a>
								</c:if>
							</c:forEach>
						</div>
						<div class="question-stats">
							<i class="bi bi-hand-thumbs-up"></i>${questionsList.likes}&nbsp;&nbsp;<i class="bi bi-chat-dots"></i>${questionsList.replyCnt }&nbsp;&nbsp;<i class="bi bi-eye"></i>${questionsList.views}
						</div>
					</c:forEach>
				</div>
			</div>

			<div class='col-sm-3 serveimg-right'>
				<img alt="dd" src="${conPath }/resources/img/serveimg4.png"
					style="width: 180px; height: 380px;">
			</div>
		</div>

		<div class='row'>
			<div class='col-sm-3 '></div>

			<div class="col-sm-6" id="pagingcontainer">
			<hr>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">

						<!-- Previous Page -->
						<c:if test="${paging.startPage != 1}">
							<li class="page-item"><a class="page-link"
								href="${conPath}/board/questions?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}"
								aria-label="Previous"> <span aria-hidden="true">Previous</span>
							</a></li>
						</c:if>

						<!-- Page Numbers -->
						<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
							var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage}">
									<li class="page-item active"><span class="page-link">${p}</span>
									</li>
								</c:when>
								<c:when test="${p != paging.nowPage}">
									<li class="page-item"><a class="page-link"
										href="${conPath}/board/questions?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
									</li>
								</c:when>
							</c:choose>
						</c:forEach>

						<!-- Next Page -->
						<c:if test="${paging.endPage != paging.lastPage}">
							<li class="page-item"><a class="page-link"
								href="${conPath}/board/questions?nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}"
								aria-label="Next"> <span aria-hidden="true">Next</span>
							</a></li>
						</c:if>

					</ul>
				</nav>
			</div>
		</div>
	</section>

	<%@ include file="../layout/footer.jsp"%>
	
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="${conPath}/board/questions?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
	
	// server Date 파싱
	$(document).ready(function() {
		
        $(".question-author").each(function() {
            var serverCreateDate = $(this).find("#createDate").val();
            var parsedCreateDateString = serverCreateDate.replace(" KST", "");
            var createDate = Date.parse(parsedCreateDateString);
            
            var serverModifyDate = $(this).find("#createDate").val();
            var parsedModifyDateString = serverModifyDate.replace(" KST", "");
            var modifyDate = Date.parse(parsedModifyDateString);
            
           	//console.log(createDate);
           	//console.log(modifyDate);
            
            var time = displayTime(createDate, modifyDate);
            $(this).find("span.timeago").text(time);
        }); 
	});
	
	// 가져온 태그 클릭시 
	document.addEventListener("DOMContentLoaded", function() {
	    const tagLinks = document.querySelectorAll(".hashtag");
	    tagLinks.forEach(link => {
	      link.addEventListener("click", function(event) {
	        event.preventDefault();
	        const tagName = this.textContent.substring(1); // '#'제거
	        loadPostsByTag(tagName);
	      });
	    });
	  });

	// ajax로 해당 태그 리스트 가져와서 뿌리기
	    function loadPostsByTag(tagName) {
	    	$.ajax({
	    		type: 'post',
	    		url: '<c:url value="/board/questionsHashTag"/>/'+tagName+'/',
	    		success: function(data) {
	    			var html = "";
	    			if(data.length > 0){
	    				$('#questioncontainer').remove();
	    				$('#pagingcontainer').remove();
	    				if (data.length > 0) {
	 	    				for(var i=0; i < data.length; i++){
	 	    					var fileCallPath = "";
	 	    					if(data[i].uploadpath != null && data[i].uuid != null && data[i].filename != null){
	 	    						fileCallPath = data[i].uploadpath + "/" + data[i].uuid + "_" + data[i].filename;
	 	    					}
	 	    					
		    					html += "<div class='question-container' id='questioncontainer'>";
		    					html += "<div class='question-author'>";
		    					if(fileCallPath.length == 0){
		    						html += "<img src='<c:url value='${conPath }/resources/img/basic.jpg'/>' class='rounded-circle' style='width: 25px; height: 25px;' id='profileImage'>";
		    					}else{
		    						html += "<img src='<c:url value='/upload/"+fileCallPath+"'/>' class='rounded-circle' style='width: 25px; height: 25px;' id='profileImage'>";
		    						
		    					}
		    					
		    					html += "<a href='#' style='padding-left:5px;'>" + data[i].memberId + "</a><i class='bi bi-diamond'></i>";
		    					html += "<input type='hidden' id='createDate' value="+data[i].createDate+">";
		    					html += "<input type='hidden' id='modifyDate' value="+data[i].modifyDate+">";
		    					html += "<span class='timeago'>"+fomatDate(data[i].createDate)+"</span>";
		    					html += "</div>";
		    					html += "<div class='question-title'>";
		    					html += "<a href='<c:url value ='${conPath }/board/questionsView?Bno="+data[i].bno+"'/>'>"+data[i].title+"</a>";
		    					html += "</div>";
		    					html += "<div class='question-content'>"+data[i].content;				
		    					html += "</div>";
		    					html += "<div class='question-topik'>#"+data[i].hashtag;
			    				html += "</div>";
		    					html += "<div class='question-stats'>";
		    					html += "<i class='bi bi-hand-thumbs-up'></i>"+data[i].likes+"&nbsp;&nbsp;<i class='bi bi-chat-dots'></i>"+data[i].replyCnt+"&nbsp;&nbsp;<i class='bi bi-eye'></i>"+data[i].views;
		    					html += "</div>";
		    					html += "</div>";
	 	    				}
	    				}  
 	    				
	    				$("#center").html(html);
	    				
	    			}
	    		}
	    	});
	    }

		
	
	function fomatDate(e){
		
		 var fomatdate = new Date(e);
		 
		 var year = fomatdate.getFullYear();    //0000년 가져오기
		 var month = fomatdate.getMonth() + 1;  //월은 0부터 시작하니 +1하기
		 var day = fomatdate.getDate();        //일자 가져오기

		 return year+"/"+month+"/"+day;
	 }
	


</script>
</body>

</html>