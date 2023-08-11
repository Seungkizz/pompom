<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page pageEncoding="utf-8" language="java"%>
<html>
<head>
<title>PomPom Developer Community</title>

<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${conPath }/resources/css/style.css" >
<script src='https://www.google.com/recaptcha/api.js'></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
	
<!-- 소스 다운 -->
<script src="https://unpkg.com/@yaireo/tagify"></script>
<!-- 폴리필 (구버젼 브라우저 지원) -->
<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>

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
	
	.form-label span {
		color: skyblue;
	}
	
	#content {
		height: 300px;
	}
	
	.mb-3:nth-child(5) {
		display: flex;
		justify-content: center;
	}
	
	.mb-3:last-child {
		display: flex;
		justify-content: flex-end;
	}
	
	.btn {
		width: 100px;
		height: 40px;
		margin: 10px;
	}
	
	.tagify {
		width: 100%;
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
	.uploadResult button{
		padding: 0px;
		margin: 0px;
		width: 30px;
	}
	

@media screen and (max-width: 1350px) {
	.serveimg-left, .serveimg-right {
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
		<div>
			<div class='row'>
				<div class='col-sm-3 serveimg-left'></div>
				<div class='col-sm-6'>
					<div class="center-div">
						<h3>기술 궁금증 해결하기</h3>
						<p>${auth.name }님지식공유 플랫폼 OKKY에서 최고의 개발자들과 함께 궁금증을 해결하세요.</p>
						<form role='form' id="modifyForm" action="${conPath }/board/questionsModify" method="post">
							<c:forEach var="boardModify" items="${boardModify }">
								<c:forEach var="topikDTO" items="${boardModify.topikDTO }"
									varStatus="status">
									<c:if test="${status.count eq 1}">
										<div class="mb-3">
											<input type="hidden" class="form-control" name="boardId"
												id="boardId" value="1" /> <label for="topikId"
												class="form-label">토픽</label> <select name="topikId"
												class="form-select form-control" aria-label=".form-select">
												<option selected>토픽을 선택해주세요.</option>
												<option value="1"
													<c:out value="${topikDTO.topikname eq '기술'?'selected':''}"/>>기술</option>
												<option value="2"
													<c:out value="${topikDTO.topikname eq '커리어'?'selected':''}"/>>커리어</option>
												<option value="3"
													<c:out value="${topikDTO.topikname eq '기타'?'selected':''}"/>>기타</option>
											</select>
										</div>
									</c:if>
								</c:forEach>

								<div class="mb-3">
								<input type="hidden" class="form-control" name="bno" id="bno" value="${boardModify.bno }" />
								<input type="hidden" class="form-control" name="memberId" id="memberId" value="${boardModify.memberId }" />
									<label for="memberId" class="form-label">제목</label> <input
										type="text" class="form-control" name="title" id="title"
										value="${boardModify.title }" />
								</div>

								<div class="mb-3">
									<label for="tag" class="form-label">태그 <span>-내용을 대표하는 태그 3개 정도 입력해주세요.</span></label><br>
									<input name='tag' value="" onkeyup="searchTag()" id="tag" />
									<c:forEach var="boardTagDTO" items="${boardModify.boardTagDTO }">
										<c:forEach var="hashTag" items="${boardTagDTO.tagDTO }">
											<c:set var="hashTagname" value="${hashTag.name}"></c:set>
											<script type="text/javascript">
												var tagName = "${hashTag.name}";
												console.log(tagName);
												document.getElementById("tag").value += tagName + ", ";
											</script>
										</c:forEach>
									</c:forEach>
								</div>
								
								<div class="mb-3">
									<label for="formFileMultiple" class="form-label">파일첨부</label>
									<input type="hidden" name="sourceType" value="2">
									<input class="form-control" type="file" name="uploadFile" multiple>
								</div>
								
								<div class="uploadResult"> 
							        <ul>
							          
							        </ul>
						        </div>
								<br>
								<div class="mb-3">
									<label for="content" class="form-label">본문</label>
									<textarea class="form-control" name="content" id="content">${boardModify.content }</textarea>
								</div>

								<div class="mb-3">
									<button type="button" class="btn btn-light" onclick="javascript:history.back();">취소</button>
									<button type="submit" class="btn btn-primary disabled-btn">수정</button>
								</div>
							</c:forEach>
						</form>
					</div>
				</div>
				<div class='col-sm-3 serveimg-right'>
					<img alt="dd" src="${conPath }/resources/img/1688434275710.png"
						style="width: 180px; height: 300px; margin-bottom: 20px;">
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../layout/footer.jsp"%>


	<!-- <script>
function recaptcha(token) {
	$('.disabled-btn').prop('disabled' , false);
}
</script> -->
	<script>
		const input = document.querySelector('input[name=tag]');
		let tagify = new Tagify(input); // initialize Tagify

		// 태그가 추가되면 이벤트 발생
		tagify.on('add', function() {
			console.log(tagify.value); // 입력된 태그 정보 객체

		});
		
	$(document).ready(function() {
			getattachList();
			
			// javascript로 전송할 form 선택하고 ajax로 전송한 사진들의 정보를 붙여주고 전송
		    // 폼 생성
		    var formObj = $("form[role='form']");
			
		      // 위에 폼에서 서블릿 누르면
		      $("button[type='submit']").on("click", function(e){
		        
		        e.preventDefault();
		        
		        console.log("submit clicked");
		        
		        var str = "";
		        // uploadResult ul li 값들이 있으면 하나꺼내서 ( 파일이 있으면)
		        $(".uploadResult ul li").each(function(i, obj){
		          
		          var jobj = $(obj);
		          
		          console.dir(jobj);
		          console.log("-------------------------");
		          console.log(jobj.data("filename"));
		          
		          
		          str += "<input type='hidden' name='attachList["+i+"].filename' value='"+jobj.data("filename")+"'>";	
		          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
		          
		        });
		        
		        console.log(str);
		        console.log(formObj);
		        
		        formObj.append(str).submit();
		        
		      });
		      
		      // 정규표현식 만들어줘가지고 실행 파일 업로드 방지
		      var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		      // 전송 파일 최대 크기
		      var maxSize = 5242880; //5MB
		      // 정규식 이용하여 전송 할 종류 및 크기 제한 걸리는지 여부 확인
		      function checkExtension(fileName, fileSize){
		        
		        if(fileSize >= maxSize){
		          alert("파일 사이즈 초과");
		          return false;
		        }
		        
		        if(regex.test(fileName)){
		          alert("해당 종류의 파일은 업로드할 수 없습니다.");
		          return false;
		        }
		        return true;
		      }
		      
		      // 파일 선택하면 체크하고 통과되면 자바스크립트로 encTpye 폼에 붙여서 ajax로 전송
		      // 사진 선택하면 ajax 전송하고 처리 결과를 받음
		      $("input[type='file']").change(function(e){

		    	// 자바스크립트로 multipart 폼 생성
		        var formData = new FormData();
		        // form에 있는 input 요소중 name=uploadFile 인걸 잡았음
		        var inputFile = $("input[name='uploadFile']");
		        
		        var sourceType = $("input[name='sourceType']");
		        console.log("inputFile >>>>>>>>>> ", inputFile);
		        
		        // 선택 한 파일들의 정보들이 들어가있음 files
		        //inputFile[0].으로 잡아도 여러개가 잡힘
		        var files = inputFile[0].files;
		        	
		        // 파일을 하나씩 꺼내서 확장자 검사 checkExtension 메소드
		        // 확장자 검사 통과하면 uploadFile 파라미터 붙여줌
		        for(var i = 0; i < files.length; i++){

		          if(!checkExtension(files[i].name, files[i].size) ){
		            return false;
		          }
		          formData.append("uploadFile", files[i]);
		          formData.append("sourceType", 2);
		        }
		        
		        // 전송 파일 데이터를 저장한 폼을 ajax로 전송
		        // form안에 이미지 파일있을때  processData: false, contentType: false, 잇어야함
		          
		        $.ajax({
		          url: '<c:url value="${conPath}/upload/memberImg"/>',
		          processData: false, 
		          contentType: false,
		          data:formData,
		          type:'POST',
		          dataType:'json',
		            success: function(result){
		              console.log("result>>>>>>>>> ",result); 
		    		  showUploadResult(result); //업로드 결과 처리 함수 

		          }
		        }); //$.ajax
		        
		      });

	});
		
		function getattachList() {
			  
		    let bno = $('#bno').val();

		    // getJSON: get방식으로 보내고 json으로 받아온다
		    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
		        
		       console.log(arr);
		       
		       var str = "";
		       
		       $(arr).each(function(i, attach){
		           
		           //image type
		           if(attach.filetype){
		             var fileCallPath =  encodeURIComponent( attach.uploadpath+ "/s_"+attach.uuid +"_"+attach.filename);
		             
		             str += "<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' "
		             str +=" data-filename='"+attach.filename+"' data-type='"+attach.filetype+"' ><div>";
		             str += "<span> "+ attach.filename+"</span>";
		             str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
		             str += "class='btn btn-circle'><i class='bi bi-x-circle'></i></button><br>";
		             str += "<img src='${conPath}/upload/display?fileName="+fileCallPath+"'>";
		             str += "</div>";
		             str +"</li>";
		           }else{
		               
		             str += "<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' "
		             str += "data-filename='"+attach.filename+"' data-type='"+attach.filetype+"' ><div>";
		             str += "<span> "+ attach.filename+"</span>";
		             str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
		             str += " class='btn btn-circle'><i class='bi bi-x-circle'></i></button><br>";
		             str += "<img src='/resources/img/file.png'></a>";
		             str += "</div>";
		             str +"</li>";
		           }
		        });
		       
		       $(".uploadResult ul").html(str);
		       
		       
		});//end getjson
	}
		
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
			if(confirm("첨부파일을 삭제 하시겠습니까?")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
	});
	
    // 파입 업로드 결과 처리 - ul > li로 업로한 사진들을 다시 다운로드 하여 보여줌 - 사진 태그에 여러 데이터 추가
    function showUploadResult(uploadResultArr){
  	    
      if(!uploadResultArr || uploadResultArr.length == 0){
      	return; 
      	}
      
      var uploadUL = $(".uploadResult ul");
      
      var str ="";
      
      $(uploadResultArr).each(function(i, obj){

  		if(obj.filetype){
  			var fileCallPath =  encodeURIComponent( obj.uploadpath+ "/s_"+obj.uuid +"_"+obj.filename);
  			str += "<li data-path='"+obj.uploadpath+"'";
  			str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.filetype+"'"
  			str +" ><div>";
  			str += "<span> "+ obj.filename+"</span>";
  			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
  			str += "data-type='image' class='btn btn-circle'><i class='bi bi-x-circle'></i></button><br>";
  			str += "<img src='${conPath}/upload/display?fileName="+fileCallPath+"'>";
  			str += "</div>";
  			str +"</li>";
  		}else{
  			var fileCallPath =  encodeURIComponent( obj.uploadpath+"/"+ obj.uuid +"_"+obj.filename);			      
  		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
  			str += "<li "
  			str += "data-path='"+obj.uploadpath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.filetype+"' ><div>";
  			str += "<span> "+ obj.filename+"</span>";
  			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
  			str += "class='btn btn-circle'><i class='bi bi-x-circle'></i></i></button><br>";
  			str += "<img src='/resources/img/file.png'></a>";
  			str += "</div>";
  			str +"</li>";
  		}

      });
      
      uploadUL.append(str);
    }

	
	
	</script>
	
</body>
</html>
