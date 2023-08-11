<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }"></c:set>
<c:if test="${duplicatedid != null }">
	<script type="text/javascript">
		alert("${duplicatedid.memberId}, 이미 회원 가입 된 아이디 입니다.");
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${conPath }/resources/css/style.css">
<style>
body {
	width: 100%;
	height: 100%;
	padding-top: 50px;
}
.g-recaptcha {
    display: flex;
    justify-content: center;
}
</style>
<meta charset="UTF-8">
<title>PomPom Developer Community</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
        async defer>
    </script>
    
</head>
<body>
	<div id="box">
		<div class="centerbox">
			<a href="/"><img alt="왜안나오지"
				src="${conPath }/resources/img/logo.png"
				style="width: 200px; padding-top: 10px;" /></a>
			<h2><b>PomPom에 오신것을 환영합니다.</b></h2>
			<p>PomPom은 소프트웨어 개발자를 위한 지식공유 플랫폼입니다.</p>
			<hr>
			<span>회원가입에 필요한 기본정보를 입력해주세요.</span><br>
			<hr>
		</div>
		<form id="registForm" action="${conPath }/member/regist" method="post" autocomplete="off" onsubmit="return mySubmit();">
			<div class="mb-3">
				<label for="email">아이디</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="memberId" id="memberId" placeholder="4~15자 이내로 입력해주세요">
					<button type="button" class="btn btn-primary" name="idcheck" onclick="checkId();">중복확인</button>
				</div>
				<div class="mb-3">
					<!-- <input type="hidden" class="form-control" name="result" id="result" /> -->
					<span id="result"></span>
				</div>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label> <input
					id="password" class="form-control" type="password"
					placeholder="최소 6자 이상(알파벳, 숫자 필수)" name="password" required />
			</div>
			<div class="mb-3">
				<label for="email">이메일</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="email" id="email"
						placeholder="info@pompom.kr">
					<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
				</div>

				<div class="mail-check-box">
					<input class="form-control mail-check-input" name="emailCheckno"
						id="emailCheckno" placeholder="인증번호 6자리를 입력해주세요!"
						disabled="disabled" maxlength="6">
				</div>
				<span id="mail-check-warn"></span>
			</div>
			<div class="mb-3">
				<label for="name" class="form-label">이름</label> <input id="name"
					class="form-control" type="text" placeholder="홍길동" name="name"
					required />
			</div>
			
			<div class="g-recaptcha" data-sitekey="6LeiYhcnAAAAAEJaqmxxd4gKuyQ4jq7IbDYG64HI" data-callback="recaptcha"></div>
		
			<br>
			<div class="service-div">
				<ul>
					<li><a href="#">서비스 이용약관</a> &nbsp; &nbsp; | &nbsp; &nbsp;</li>
					<li><a href="#">개인정보처리방침 </a></li>
				</ul>
			</div>
			<div class="registbtn">
				<button type="submit" class="btn btn-primary disabled-btn" disabled="disabled">회원가입</button>
			</div>
			<div class="registbtn">
				<span>이미 회원이신가요? <a href="<c:url value ='${conPath }/member/loginForm'/>">로그인</a></span>
			</div>
		</form>



	</div>
</body>


<script>
// 폼체크

	var emailCheck = false;
	var idCheck = false;

	function mySubmit() {	
		console.log("wow");
			
		//var registForm = $('#registForm');
		var memberId = $('#memberId').val();
		var password = $('#password').val();
		var email = $('#email').val();
		var name = $('#name').val();
	   
		var check_id = RegExp(/^[a-zA-Z0-9]{4,15}$/); // 아이디 유효성 검사 ( 4~15자 이내의 영문자와 숫자)
		var check_pw = RegExp(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{6,20}$/); // 비밀번호 유효성 검사 (영문 및 숫자 6-20글자)
		var check_email = RegExp(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/); // 이메일 형식
		var check_name = RegExp(/^[가-힣a-zA-Z]{2,}$/); //이름은 2자 이상의 한글 또는 영문
		
		// 아이디 유효성 체크
		if (!check_id.test(memberId)) {
			alert("아이디를 영문 및 숫자만 4-15자리이내로 입력해주세요.");
			$('#memberId').val("");
			$('#memberId').focus();
			return false;
		}
		
		// 아이디 공백 확인
		if (memberId == "" || memberId == null) {
			alert("아이디를 입력해주세요");
			$('#memberId').focus();
			return false;
		}
		
		// 아이디 중복 체크 여부
		if (idCheck == false) {
			alert("아이디 중복체크를 해주세요.");
			console.log("idCheck>>>>>>>> "+ idCheck);
			return false;
		}

		// 비밀번호 유효성 체크
		if (!check_pw.test(password)) {
			alert("영문 및 숫자, 특수문자를 포함한 비밀번호를 입력해주세요.");
			$('#password').val("");
			$('#password').focus();
			return false;
		}
		
		// 비밀번호 공백 확인
		if (password == "" || password == null) {
			alert("비밀번호를 입력해주세요");
			$('#password').focus();
			return false;
		}

		// 이메일 유효성 체크
		if(!check_email.test(email)){
			alert("이메일 형식에 맞게 입력해주세요.");
			$('#email').val("");
			$('#email').focus();
			return false;
		}
	    
		// 이메일 공백확인
		if(email == "" || email == null){
			alert("이메일을 입력해주세요");
			$('#email').focus();
			return false;
		}
	    
	 	
		// 이메일 체크 여부
		if (emailCheck == false) {
			alert("이메일 본인인증을 해주세요.");
			console.log("emailCheck>>>>>>>> " +emailCheck);
			return false;
		}
	 	
		// 이름 유효성 체크
		if(!check_name.test(name)){
			alert("이름은 2자 이상의 한글 또는 영문으로 입력해주세요.");
			$('#name').val("");
			$('#name').focus();
			return false;
		}
		
		// 이름 공백 확인
		if(name == "" || name == null){
			alert("이름을 입력해주세요");
			$('#name').focus();
			return false;
		}
	    
		
	}

	//이메일 체크 버튼
	$('#mail-Check-Btn').click(function() {
		const email = $('#email').val(); // 이메일 주소값 얻어오기!
		if(email.length == 0){
			alert("이메일을 입력하세요.");
			return;
		}
		console.log('이메일 : ' + email); // 이메일 오는지 확인
		console.log('이메일 : ' + email.length); // 이메일 오는지 확인
		const checkInput = $('.mail-check-input'); // 인증번호 입력하는곳 
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/mailCheck?email="/>' + email,
			success: function(data) {
				console.log("data: " + data);
				checkInput.attr('disabled', false);
				code = data;
				emailCheck = true;
				alert('인증번호가 전송되었습니다.');
			},error:function(){
 				console.log('통신오류');
 			}			
		}); // end ajax
	}); // end send email

	// 인증번호 비교 
	// blur -> focus가 벗어나는 경우 발생
	$('.mail-check-input').blur(function() {
		const inputCode = $(this).val();
		const $resultMsg = $('#mail-check-warn');
		
		if (inputCode === code) {
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color', 'green');
			$('#mail-Check-Btn').attr('disabled', true);
			$('#email').attr('readonly', true);
			$('#email').attr('onFocus', 'this.initialSelect = this.selectedIndex');
			$('#email').attr('onChange', 'this.selectedIndex = this.initialSelect');
		} else {
			$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
			$resultMsg.css('color', 'red');
		}
	});

	

// 아이디 중복체크
function checkId() {
	if($('#memberId').val().length == 0){
		alert("아이디를 입력하세요.");
		return;
	}
	$.ajax({
		type: 'get',
		url: '/member/idCheck/?memberId=' + $('#memberId').val(),
		success: function(result) {
			console.log("결과로 나온 >> " + result);
			if (result === 'useId') {
				console.log("사용 불가능 아이디 입니다.");
				//$('#result').val("사용 불가능 한 아이디 입니다.").prop('type', 'text').prop('readonly', true).prop('disabled','disabled');
				$('#result').html('사용 불가능 한 아이디 입니다.').css('color','red');
				$('#memberId').val(" ");
			} else {
				console.log(result + "사용 가능 아이디 입니다.");
				//$('#result').val(" 사용 한 아이디 입니다.").prop('type', 'text').prop('readonly', true).prop('disabled','disabled');
				$('#result').html('사용 가능 한 아이디 입니다.').css('color','green');
				idCheck = true;
			}
		},error:function(){
				console.log('통신오류');
			}
	});
}
</script>

<script>
// 로봇 체크하면 회원가입 버튼 활성화
function recaptcha(token) {
	$('.disabled-btn').prop('disabled' , false);
}
</script>

</html>
