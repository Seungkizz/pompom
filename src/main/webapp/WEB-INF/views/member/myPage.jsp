<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page pageEncoding="utf-8" language="java"%>
<html>
<head>
<title>PomPom Developer Community</title>
<style>

section {
	margin: 0 auto;
}
.myPagenav{
	border-right: 1px solid #cccc;
	padding: 50px; 
}
.myPageinfo{
	padding: 50px; 
}
.deleteinfo , .emailinfo{
	border-top: 1px solid #cccc;
	padding: 20px;
}
.deletetext{
	border: 1px solid #cccc;
}
.deletetext p{
	margin: 5px;
	font-size: 16px;
	color: slategray;
}
.deletetext a{
	text-decoration: underline;
}
.deletebtn{
	display: flex;
	justify-content: flex-end;
}
.bi-exclamation-diamond{
	margin-bottom: 20px;
}





@media screen and (max-width: 1350px) {
	.serveimg-left , .serveimg-right{
		display: none;
	}
	.col-sm-6{
	margin: 0 auto;
	}
}
</style>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<hr>
	<section>
	
		<div class="container" id="reload">
		  	<div class="row">
			    <div class="col-4 myPagenav">
			    	<h3>내계정</h3>
			    	<div><a href="<c:url value ='${conPath }/member/myPage'/>"><i class="bi bi-person"></i>회원정보</a></div>
			    	<div><a href="<c:url value ='${conPath }/member/activity'/>"><i class="bi bi-clock-history"></i>활동내역</a></div>
			    </div>
			    <div class="col-8 myPageinfo">
			    	<h3>회원정보</h3>
			    	<div class="card">
			    		<c:choose>
			    		<c:when test="${fileCallPath == null }">
	           			<img src="<c:url value='${conPath }/resources/img/basic.jpg'/>" class="rounded-circle" style="width: 100px; height: 100px;" id="profileImage">
	           			</c:when>
	           			<c:otherwise>
	           			<img src="<c:url value='${fileCallPath}'/>" class="rounded-circle" style="width: 100px; height: 100px;" id="profileImage">
	           			</c:otherwise>
	           			</c:choose>
		                <input type="file" name="uploadFile" multiple="multiple" onchange="readURL(this);">
		                <input type="hidden" name="sourceType" value="1">
		                <div class="d-flex justify-content">
		               	<button type="submit" class="btn btn-primary" id="uploadBtn" style="width: 80%">사진변경</button>
		               	<button type="submit" class="btn btn-Secondary" id="basicBtn">기본이미지사용</button>
		               	</div>
		            </div>
		            <br />
		            		<label for="name" class="form-label">이름</label><br />
				    	<div class="mb-3 input-group">
				    		<input id="memberId" class="form-control" type="hidden" name="memberId" value="${memberinfo.memberId }"/>
							<input id="name" class="form-control" type="text" name="name" oninput="enableButton()" value="${memberinfo.name }"/>
							<button type="button" class="btn btn-primary" id="nameModify" disabled="disabled">수정</button>
						</div>
						<div>
							<i id="nameMsg" class=""></i>
						</div>
						<div class="mb-3">
							<label for="email">이메일</label>
							<input type="text" class="form-control" name="email" id="email" readonly="readonly" value="${memberinfo.email }">
						</div>
						<div class="emailinfo">
							<p style="font-size: 16px; font-weight: 600;">이메일수신동의</p>
							<p style="font-size: 14px; color: #cccc;">OKKY에서 주최하는 다양한 이벤트, 정보성 뉴스레터 및 광고 수신여부를 설정할 수 있습니다.</p>
							<p style="font-size: 16px; font-weight: 600;">뉴스레터 및 마케팅 메일 수신</p>
							<p style="font-size: 14px; color: #cccc;">유저가 만드는 다양한 컨텐츠를 뉴스레터로 받습니다.</p>
						</div>
						<div class="deleteinfo">
							<h3>계정삭제</h3>
							<div class="deletetext">
							<p>회원 탈퇴일로부터 계정과 닉네임을 포함한 계정 정보(아이디/이메일/닉네임)는<br><a href="">개인정보 보호방침</a>에 따라 <b>60일간 보관(잠김)되며</b>, 60일 경과된 후에는 모든 개인 정보는 완전히 삭제되며 더 이상 복구할 수 없게 됩니다.</p>
							</div>
							<div class="form-check" style="padding-top: 15px;">
  								<input class="form-check-input" type="checkbox" value="" id="emailCheck">
  								<label class="form-check-label" for="flexCheckDefault">계정 삭제에 관한 정책을 읽고 이에 동의합니다.</label>
							</div>
							<div class="deletebtn">
  								<button type="button" class="btn btn-danger disabled-btn" disabled="disabled" onclick="deleteinfo();">회원탈퇴</button>
							</div>

						</div>
			    </div>
	  		</div>
		</div>

	</section>
	<%@ include file="../layout/footer.jsp"%>
</body>

<script>
  const emailCheckbox = document.getElementById('emailCheck');
  const deleteButton = document.querySelector('.deletebtn button');

  emailCheckbox.addEventListener('change', function() {
    deleteButton.disabled = !this.checked;
  });
  
</script>

<script type="text/javascript">
// 탈퇴버튼
function deleteinfo() {
	var result = confirm("정말 탈퇴 하시겠습니까?");
	if(result){
	    alert("수고하셨어요! 2018년에도 화이팅!!");
	}else{
	    
	}
   };
   
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	//크기 제한
	var maxSize = 5242880; //5MB
	
	// 파일 체크
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


// 프로필 사진 변경
$(document).ready(function(){
	$("#uploadBtn").on("click", function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var sourceType = $("input[name='sourceType']");
		
		var files = inputFile[0].files;
		
		for(var i = 0; i < files.length; i++){
			
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
			formData.append("sourceType", 1);
		}
		
		$.ajax({
			url:'<c:url value="${conPath}/upload/memberImg"/>',
			processData: false,	
			contentType: false,
			data:formData,
			type: 'post',
			success: function(result){
				console.log(result);
				if(result.length > 0){
					alert("프로필 등록완료!");
					location.reload();
				}
			}
		});
	});
});

// 기본 이미지 사용
$(document).ready(function(){
	
	var memberId = $('#memberId').val();
	
	$("#basicBtn").on("click", function(e){

		console.log(memberId);
		$.ajax({
			type:'delete',
			url:'<c:url value="${conPath}/upload/deleteImg"/>/' + memberId,
			success : function(data){
				console.log(data);
				if(data == 'success'){
					location.reload();
				}
			}
		});
	});
	
	$('#nameModify').on("click", function(e){
		var newName = $('#name').val();

		console.log(newName);
		console.log(newName.length);
		if(newName == null || newName.length == 0 || newName.length < 2){
			$('#nameMsg').html(" 이름은 최소 2자 이상으로 입력해주세요.").addClass("bi-exclamation-diamond").css('color','red').css("font-size","14px");
			return;
		}
		// 물음표 값도 받기 위해서 encodeURIComponent 사용하기
		$.ajax({
			type:'post',
			url:'<c:url value="${conPath}/member/nameUpdate"/>/' + encodeURIComponent(newName) +'/' + memberId,
			success : function(data){
				//console.log(data);
				if(data == 'ok'){
					location.reload();
				}
			}
		});
	});
});

// 업로드 프로필 미리보기
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            $('#profileImage').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

var inputName = document.getElementById('name');
var inputNameValue = document.getElementById('name').value;
var nameModifyButton = document.getElementById('nameModify');
inputName.addEventListener('keyup', enableButton);

// 이름 버튼 키보드 입력시 활성화
function enableButton() {

	  if (inputName.value == inputNameValue) {
		  nameModifyButton.disabled = true;
	  }else if(inputName.value.length > inputNameValue.length){
		  nameModifyButton.disabled = false;
	  }else if(inputName.value.length == 0){
		  nameModifyButton.disabled = false;
	  }else if(inputName.value.length < inputNameValue.length){
		  nameModifyButton.disabled = false;
	  }else if(inputName.value.length >= 1){
		  $('#nameMsg').html("").removeClass("bi-exclamation-diamond");
	  }
	}
   
</script>



</html>