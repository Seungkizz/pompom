<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page pageEncoding="utf-8" language="java"%>
<html>
<head>
<title>PomPom Developer Community</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="${conPath }/resources/js/jslink.js"></script>
<c:if test="${auth.memberId != null }">
	<c:set var="loginMemberId" value="${auth.memberId }"/>
</c:if>
	<style>
    section {
        margin: 0 auto;
    }

    .serveimg-left img {
        margin-left: 180px;
    }

    .serveimg-right img {
        margin-left: 100px;
    }

    .btn{
    	width: 100px;
    	height: 40px;
    	margin: 0px;
    	padding: 0px;
    	
    }
    .center-Activity-profile{
    	float: left;
    }
    .meunbtn{
    	border-top: 1px solid lightgrey;
    	clear: both;
    	padding-top: 15px;
    }
    #center-Activity{
    	border: 1px solid lightgrey;
    	padding: 20px; 
    	width: 100%;
    	border-radius: 12px;
    }
    #profileImage{
    	padding: 10px;
    }
    #profile-name{
    	padding-top: 10px;
    }
    #profile-activeScore p{
    	color: darkgray;
    }
    .meunbtn .btn:hover{
    	border-bottom: 3px solid dodgerblue;
    	
    }
    .profile .bi-lightning-charge-fill{
    	font-size: 18px;
    }

    #profile-name{
    	font-size: 30px;
    }
    #profile-name p{
    	margin: 0px;
    	font-weight: 600;
    }
    .topic {
		background-color:#E6E6FA;
		border-radius: 5px;
		font: skyblue;
		padding: 3px;
		margin-right: 20px;
	}
	#scrapTitle{
		text-decoration:none;
		color:black;
	}
	#scrapTitle:hover {
		color:skyblue;
	}
    



    @media screen and (max-width: 1350px) {
        .serveimg-left,
        .serveimg-right {
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
<hr>
<section>
        <div class='row'>
          
            <div class='col-sm-8' id="center-Activity" style="float: none; margin: 0 auto;">
            	<div class="center-Activity-profile">
			    	<c:choose>
				    	<c:when test="${fileCallPath == null }">
		           			<img src="<c:url value='${conPath }/resources/img/basic.jpg'/>" class="rounded-circle" style="width: 100px; height: 100px;" id="profileImage">
		           		</c:when>
		           		<c:otherwise>
		           			<img src="<c:url value='${fileCallPath}'/>" class="rounded-circle" style="width: 100px; height: 100px;" id="profileImage">
		           		</c:otherwise>
	           		</c:choose>
		        </div>
		        <input id="memberId" class="form-control" type="hidden" name="memberId" value="${memberinfo.memberId }"/>
		        <div class="profile" id="profile-name">
					<p>${memberinfo.name }</p>
				</div>
				<div class="profile" id="profile-activeScore">
					<p><i class="bi bi-lightning-charge-fill"></i> 활동점수 ${memberinfo.activeScore }</p>
				</div>
				<div class="d-flex justify-content-end" style="margin-bottom: 20px;">
					<a href="<c:url value ='${conPath }/member/myPage'/>"><button class="btn btn-outline-secondary">나의계정</button></a>
				</div>
				
				<div class="d-flex justify-content-start meunbtn">
					<a href="#"><button class="btn">활동내역</button></a>
					<a href="#"><button class="btn" id="myQuestions">Q&A</button></a>
					<a href="#"><button class="btn" id="myBoard">게시글</button></a>
					<a href="#"><button class="btn active" id="scrapBtn">스크랩</button></a>
            	</div>
            </div>
            <div class='col-sm-8' id="scrapResult" style="float: none; margin: 0 auto; padding-top: 40px;">

            <hr>
            </div>
            
        </div>

</section>

<%@ include file="../layout/footer.jsp"%>

<script type="text/javascript">

	$(document).ready(function(){
		
		var memberId = $('#memberId').val();
		memberId = encodeURIComponent(memberId);
		console.log(memberId);
		$("#scrapBtn").on("click", function(e){
			console.log("wow");
			
			$.ajax({
				type:'post',
				url:'<c:url value="${conPath}/board/scrapList"/>/',
				contentType: "application/json; charset:UTF-8",
				data: JSON.stringify({
					"memberId":memberId,
				}),
				success: function(data){
					var html = "";
					if(data.length > 0){
						for(i=0; i < data.length; i++){
							html += "<div class='test' style='background:red'>"
							
							html += "<div style='float: left;'>";
							html += "<a href='#' class='topic'>"+data[i].topikname+"</a>";
							html += "<span style='font-size:14px; align-items: center; justify-content: center;'>카테고리의";
							html += "<span style='color:blue'> 질문</span> 을 스크랩하였습니다.</span>";

							html += "</div>";
							

							
							html += "<div style='float: right;'>";
							html += "<span style='color:gray;'>"+fomatDate(data[i].createDate)+"</span>";
							//html += "<span>"+data[i].createDate+"</span>";
							html += "</div>";
							
							html += "</div>";
							
							html += "<div style='clear:both; margin: 20px; padding: 10px; font-size: 20px; font-weight: 600;'>";
							html += "<a href='<c:url value ='${conPath }/board/questionsView?Bno="+data[i].bno+"'/>' id='scrapTitle'>"+data[i].title+"</a>";
							html += "</div>";
							html += "<hr>";
								

							
						}
					}
					$("#scrapResult").html(html);
				},
			});
		});
	});
	
	function fomatDate(e){
		
		var fomatdate = new Date(e);
				 
		var year = fomatdate.getFullYear();    
		var month = fomatdate.getMonth() + 1; 
		var day = fomatdate.getDate();        
		var hours = fomatdate.getHours()
		var min = fomatdate.getMinutes()
		var sec = fomatdate.getSeconds()
		
		return year+"-"+month+"-"+day+" "+hours+":"+min+":"+sec;
	}
	 
	
</script>
</body>
</html>
