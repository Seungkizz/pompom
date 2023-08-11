<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page pageEncoding="utf-8" language="java"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="${conPath }/resources/js/jslink.js"></script>
<title>PomPom Developer Community</title>
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
    	margin: 10px;
    	
    }
	.bi-diamond{
		font-size: 5px !important;
		padding-left: 5px;
		padding-right: 5px;
	}
	
	.hashtagbox{
		display: flex;
		justify-content: flex-start;
	}
	.hashtagbox a{
		margin:10px;
		padding:0 5px;
		background-color: #cccc;
		border-radius: 5px;
		text-decoration: none !important;
		color: black;
	}
	.bi-hand-thumbs-up, .bi-hand-thumbs-up-fill{
		padding-right: 10px;
	}
	.col-sm-6 div{
		padding: 20px;
	}
	.replydiv{
		border: 1px solid #cccc;
		border-radius: 10px;
	}
	.replydiv .mb-3 textarea{
		height: 130px;
	}
	.replybox{
		padding: 0 !important;
	}
	.replybox > div{
		padding: 0 !important;
	}

	.replybox .bi{
		font-size: 18px;
	}
	.replybox .bi:hover{
		color: skyblue;
	}
	

	.replymember{
		display: flex;
		justify-content: space-between;
	}
	.uploadResult {
	width: 100%;
	}
	
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: flex-start;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
		width: 100%;
		height: 100%;
	}

	.uploadResult ul li img {
		width: 100px;
	}
	.bigPictureWrapper {
	  position: absolute;
	  display: none;
	  justify-content: center;
	  align-items: center;
	  top:0%;
	  width:100%;
	  height:100%;
	  z-index: 100;
	  background:rgba(255,255,255,0.5);
	}
	.bigPicture {
	  position: relative;
	  display:flex;
	  justify-content: center;
	  align-items: center;
	}
	
	.bigPicture img {
	  width:600px;
	}

	.bd-highlight{
		position: relative;
	}
	
	.menubars { 
	display: none; 
	list-style:none;
	}
	.menubars li{
	display: block;
    clear: both
	}
	i{
	cursor: pointer;
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
            <div class='col-sm-3 serveimg-left'>
				<img alt="dd" src="${conPath }/resources/img/serveimg1.png" style="width: 160px; height: 235px;">
            </div>
            <div class='col-sm-6'>
                	<div class="questionscenterimg">
					<a href="https://gdu.co.kr/process/process_010100.html" target="_blank"><img alt="" src="${conPath }/resources/img/questionscenter.png" style="max-width: 100%; max-height: 100%; padding: 15px;"></a>
				</div>
				<div class="center-div">
				<hr>
				<c:forEach var="boardView" items="${boardView }">
				<c:set var="writeMemberId" value="${boardView.memberId}" />
					<c:forEach var="Viewtopik" items="${boardView.topikDTO }" varStatus="status">
						<c:if test="${status.count eq 1}">
							<span><b>Q&A / <a href="#">${Viewtopik.topikname }</a></b></span>
						</c:if>
					</c:forEach>
				</c:forEach>
				</div>
            </div>
            <div class='col-sm-3 serveimg-right'>
            </div>
        </div>
        
        <div class='row'>
            <div class='col-sm-3 serveimg-left'>
            </div>
            <div class='col-sm-6'>
				<div>
					<c:forEach var="boardView" items="${boardView }">
					<c:set var="parentbno" value="${boardView.bno }" />
						<div class="d-flex bd-highlight mb-3">
							<div>
							<c:choose>
				    		<c:when test="${fileCallPath == null }">
		           			<img src="<c:url value='${conPath }/resources/img/basic.jpg'/>" class="rounded-circle" style="width: 25px; height: 25px;" id="profileImage">
		           			</c:when>
		           			<c:otherwise>
		           			<img src="<c:url value='${fileCallPath}'/>" class="rounded-circle" style="width: 25px; height: 25px;" id="profileImage">
		           			</c:otherwise>
		           			</c:choose>
							${boardView.memberId }<i class="bi bi-diamond"></i><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${boardView.createDate}" /></div>
							<div style="margin: 0 0 0 auto;">
						      <i class="bi bi-bookmark" id="boardbookmark" style="font-size: 25px;"></i>
							  <i class="bi bi-hand-thumbs-up" id="boardlikes" style="font-size: 25px;"></i>
						    </div>
						</div>

						<div><h1>${boardView.title }</h1></div>
						<div>${boardView.content }</div>
						
						<div class='bigPictureWrapper'>
							<div class='bigPicture'>
							</div>
						</div>
						
						<div class="hashtagbox">
							<c:forEach var="boardTagDTO" items="${boardView.boardTagDTO}">
			    	  			<c:forEach var="hashtag"  items="${boardTagDTO.tagDTO}" >
			    	  				<a href="#" class="hashtag">#${hashtag.name}</a>
			    	 			 </c:forEach>
		    	 		 </c:forEach>
		    	 		 </div>
		    	 		 
		    	 		 <div class='uploadResult'> 
					         <ul>
					         
					         </ul>
				         </div>
				        
		    	 		 <div class="d-flex justify-content-end">
			    	 		 <c:if test="${boardView.memberId == auth.memberId }">
				    	 		 <a href="<c:url value ='${conPath }/board/questionsModify?Bno=${boardView.bno}'/>" class="btn btn-primary">수정하기</a>
				    	 		 <a href="<c:url value ='${conPath }/board/questionsDelete?Bno=${boardView.bno}'/>" class="btn btn-danger" onclick="return confirm('정말 삭제 하시겠습니까?');">삭제하기</a>
			    	 		 </c:if>
		    	 		 </div>
					</c:forEach>
				</div>
            </div>
            <div class='col-sm-3 serveimg-right'>
            </div>
        </div>
        
        <div class='row'>
            <div class='col-sm-3 serveimg-left'>
            
            </div>
            <div class='col-sm-6'>
            
				<div class="center-div">
					<div class="questionscenterimg">
						<img alt="" src="${conPath }/resources/img/main.jpg" style="max-width: 100%; max-height: 100%; padding: 15px;">
					</div>
					<hr>
					<div>
						<span id="cnt"> </span><span>개의 답변</span>
					</div>
					
					<div class="replydiv">
						<div class="mb-3">
							<input type="hidden" class="form-control" name="bno" id="bno" value="${parentbno }" />
	                        <textarea class="form-control" name="content" id="content"></textarea>
	                    </div>
	                    <div class="d-flex justify-content-end">
	                    <button type="button" class="btn btn-primary" id="replywrite">댓글등록</button>
	                    </div>
                    </div>
                  
                    <div id="replylist" style="margin-top: 20px;"> 
                    
	                </div>

				
				</div>
            </div>
            <div class='col-sm-3 serveimg-right'>
            </div>
        </div>
        
        

</section>

<%@ include file="../layout/footer.jsp"%>

</body>

<script type="text/javascript">

$(document).ready(function() {
	// 댓글가져오기실행
	if(!'${auth.memberId}') {
		$('#replywrite').prop("disabled",true);
		$('#content').prop("placeholder","로그인 후 작성해주세요.");
	}else{
		$('#replywrite').prop("disabled",false);
		$('#content').prop("placeholder","댓글을 작성해주세요.");
	}
	getList();
	getattachList();
	
	// 댓글달기
	$('#replywrite').click(function() {
		//alert("wow");

		let bno = ${parentbno };
		let content = $('#content').val();
			
		console.log(bno);
		console.log(content);
		let data = {
				"bno":bno,
				"content":content,
			};
		console.log(data);
		$.ajax({
			type:'post',
			url:'<c:url value="${conPath}/reply/insert"/>',
			data: JSON.stringify(data),
			contentType: 'application/json',
			success:function(data){
					if(data === "success"){
						console.log('댓글 등록 완료');
						$('#content').val("");
						getList();
					}
				},
			error:function(){
				alert('댓글 등록 실패');
			}
		});
	});
	
 });
 
// 댓글 수정시
$(document).on('click', '#replymodifyForm', function() {
	let rno = $(this).parents('.replybox').find('input').val();
	console.log("rno >> ",rno);
	let textbox = $(this).parent().prev().html("<textarea class='form-control' name='content' id='content'></textarea>");
	textbox.next().html("<button class='btn-sm bg-primary' id='replymodify'>저장</button>").append("<button class='btn-sm' id='modifycancel'>취소</button>");
});

//댓글 수정 시 저장 버튼
$(document).on('click', '#replymodify', function() {
	let rno = $(this).parents('.replybox').find('input').val();
	console.log("#replymodify >> ",rno);
	let content = $(this).parent().prev().find('textarea').val();
	console.log("#replymodify >> ",content);
	
		$.ajax({
			type:'post',
			url: '<c:url value="${conPath}/reply/modify"/>/' + rno + '/' + content,
			data: JSON.stringify({
				"rno":rno,
				"content":content
			}),
			success:function(data){
				if(data === 'success'){
					console.log("수정성공");
					getList();
				}
				
			}
		});

});

//댓글 수정 시 취소 버튼
$(document).on('click', '#modifycancel', function() {
	getList();
});


// 댓글 삭제
$(document).on('click', '#replydelete', function() {
	let rno = $(this).parents('.replybox').find('input').val();
	let result = confirm('댓글을 삭제 하시겠습니까?');
	if(result){
		$.ajax({
			 type:'delete',
			 url: '<c:url value="${conPath}/reply/delete"/>/' + rno,
			 success : function(data){
				 if(data === 'success'){
					console.log("수정성공");
					getList();
				}
			 }
		});
	}
	
});

// 북마크 아이콘 클릭시(스크랩) 
$(document).on('click', '#boardbookmark', function() {
	var loginMemberId = '${loginMemberId}';
	console.log(loginMemberId);
	var writeMemberId = '${writeMemberId}';
	console.log(writeMemberId);
	if(loginMemberId == ''){
		alert("로그인 후 이용해주세요.");
		return;
	}
	if(loginMemberId != writeMemberId){
		var bno = ${parentbno};
		
		 $.ajax({
			 type:'post',
			 url :'<c:url value="${conPath}/board/scrap"/>/' + bno + '/' + loginMemberId,
			 data: JSON.stringify({
					"bno":bno,
					"loginMemberId":loginMemberId
				}),
			success : function(data){
				if(data == 0){
					$('#boardbookmark').removeClass('bi-bookmark').addClass('bi-bookmark-fill');
					console.log("스크랩");
				}else{
					$('#boardbookmark').removeClass('bi-bookmark-fill').addClass('bi-bookmark');
					console.log("스크랩 취소");
				}
			 }
		 });
		 
	}else{
		alert("자신이 쓴 글은 스크랩 할 수 없습니다.");
	}
	
});

 //좋아요 게시판아이콘 클릭시
$(document).on('click', '#boardlikes', function() {
	let bno = ${parentbno };
	if (document.cookie.includes('board_like_' + bno)) {
        alert('이미 좋아요를 눌렀습니다.');
        return; 
    }
	 $.ajax({
		 type:'get',
		 url :'<c:url value="${conPath}/board/like"/>?bno=' + bno,
		 success : function(data){
			 console.log(data);
			 if(data == 'success'){
				 $('#boardlikes').removeClass('bi-hand-thumbs-up').addClass('bi-hand-thumbs-up-fill');
				 console.log("좋아요 업");
			 }
		 }
	 });

});

 //댓글좋아요 리플아이콘 클릭시
$(document).on('click', '#replylike', function() {
	let rno = $(this).parents('.replybox').find('input').val();
	 $.ajax({
		 type:'post',
		 url :'<c:url value="${conPath}/reply/like"/>/' + rno,
		 success : function(data){
			 console.log(data);
			 if(data == 'success'){
				 getList();
			 }
		 }
	 });

});
 
// 
$(".uploadResult").on("click","li", function(e){
    
    console.log("view image");
    
    var liObj = $(this);
    
    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
    
    if(liObj.data("type")){
      showImage(path.replace(new RegExp(/\\/g),"/"));
    }else {
      //download 
      self.location ="${conPath}/upload/download?fileName="+path
    }
    
    
  });
  
  function showImage(fileCallPath){
	    
    //alert(fileCallPath);
    
    $(".bigPictureWrapper").css("display","flex").show();
    
    $(".bigPicture")
    .html("<img src='${conPath}/upload/display?fileName="+fileCallPath+"' >")
    .animate({width:'100%', height: '100%'}, 1000);
    
  }

  $(".bigPictureWrapper").on("click", function(e){
    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
    setTimeout(function(){
      $('.bigPictureWrapper').hide();
    }, 1000);
  });




 
 // 댓글 가져오기
 function getList() {
	let bno = ${parentbno }; 
	 
	 $.ajax({
		 type:'GET',
		 url :'<c:url value="${conPath}/reply/list"/>?bno=' + bno,
		 success : function(data){

			 var html = "";
	         var cnt = data.length;
			 if(data.length > 0){
				 for(i=0; i < data.length; i++){
					 html += "<div class='replybox'>";
					 html += "<input type='hidden' name='rno' id='rno' value='" + data[i].rno + "'/>";
	                 html += "<div class='d-flex justify-content-between'><h6><strong>"+data[i].memberId+"</strong></h6><span>"+displayTime(data[i].createDate, data[i].modifyDate)+"</span></div>";
	                 html += "<div class='replycontent'>"+data[i].content+"</div>";
	                 html += "<div class='d-flex justify-content-end'>"+data[i].likes+"<i class='bi bi-hand-thumbs-up' id='replylike'></i>";
	                 if ('${auth.memberId}' === data[i].memberId) {
		                 html += "<i id='replymodifyForm' class='bi bi-pencil'></i>";
		                 html += "<i id='replydelete' class='bi bi-trash'></i>";
	                 }
	                 html += "</div>";
	                 html += "</div>";
	                 html += "<hr>";
	                 console.log("data[i].memberId >>>"+data[i].memberId);
	                 console.log('${auth.memberId}'==data[i].memberId);

				 }
			 }
			 
			 $("#cnt").html(cnt);
	         $("#replylist").html(html);
		 },
		 error:function(request,status,error){
	            
	       }
	 });
 }

// 첨부파일 가져오는 함수
function getattachList() {
	  
	    let bno = ${parentbno };

	    // getJSON: get방식으로 보내고 json으로 받아온다
	    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
	        
	       console.log(arr);
	       
	       var str = "";
	       
	       $(arr).each(function(i, attach){
	       
	         //image type
	         if(attach.filetype){
	           var fileCallPath =  encodeURIComponent( attach.uploadpath+ "/s_"+attach.uuid +"_"+attach.filename);
	           
	           str += "<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"' ><div>";
	           str += "<img src='${conPath}/upload/display?fileName="+fileCallPath+"'>";
	           str += "</div>";
	           str +"</li>";
	         }else{
	             
	           str += "<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"' ><div>";
	           str += "<span> "+ attach.filename+"</span><br/>";
	           str += "<img src='/resources/img/file.png'></a>";
	           str += "</div>";
	           str +"</li>";
	         }
	       });
	       
	       $(".uploadResult ul").html(str);
	       
	       
	});//end getjson
}

</script>

</html>
