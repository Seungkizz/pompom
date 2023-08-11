<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }"></c:set>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${conPath }/resources/css/style.css">
<style>
body {
    width:100%;
    height:100%;
    padding-top: 50px;
}
.centerbox span{
	font-size: 12px;
	color: #cccc;
	font-weight: bold;
}


</style>
  <meta charset="UTF-8">
  <title>PomPom Developer Community</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<c:if test="${Success != null}">
	<script type="text/javascript">
		alert("회원 가입 성공!");
	</script>
</c:if>
<body>
<div id="box">
<div class="centerbox">
<a href="/"><img alt="왜안나오지" src="${conPath }/resources/img/logo.png" style="width: 200px; padding-top: 10px;"/></a>
<h2><b>PomPom에 오신것을 환영합니다.</b></h2>
<p>PomPom은 소프트웨어 개발자를 위한 지식공유 플랫폼입니다.</p>
 <hr>
  	<span>PomPom 아이디로 로그인</span><br>
  <hr>
</div>
<form id="loginForm" action="${conPath }/member/login" method="post">
  <div class="mb-3">
 
    <label for="memberId" class="form-label">아이디</label>
    <input id="memberId" class="form-control" type="text" name="memberId" required />
  </div>
  <div class="mb-3">
    <label for="password" class="form-label">비밀번호</label>
    <input id="password" class="form-control" type="password" name="password" required />
  </div>
  
  <div class="registbtn">
  <button class="btn btn-primary">로그인</button>
  </div>
  <div class="registbtn">
	<span>아직 회원이아니신가요? <a href="<c:url value ='${conPath }/member/registForm'/>">회원가입</a></span>
	</div>
</form>
</div>
</body>
<script type="text/javascript">
	$('#loginForm').submit(function(e)
			{
			    e.preventDefault();
			    ajax_login();
			});

	function  ajax_login(){
		
		var memberId = $("#memberId").val();
		var password = $("#password").val();
		
		memberId = $.trim(memberId);
		password = $.trim(password);
		
		if(memberId == ""){
			alert("아이디를 입력해 주세요.");
			$("#memberId").focus();
			return false;
		}
		if(password == ""){
			alert("패스워드를 입력해 주세요.");
			$("#password").focus();
			return false;
		}
		
		$("#memberId").val(memberId);
		$("#password").val(password);
		
		//serialize가 form요소하나하나를 읽어옴
		var formData = $("#loginForm").serialize();
		
		$.ajax({
			/* 전송 전 세팅 */
			type:"POST", //http메서드를 쓰면됨
			data:formData, //화면에 입력한 데이터 위에 변수 선언한거
			url:"/member/login", //데이터를 전송하여 저장시키는 url
			dataType:"text", //리턴타입, 성공여부를 text로 추출해줌

			/* 전송 후 세팅 */
			success: function(result) { //controller에서 return받은 message부분임
				if(result == "ok"){
					alert("로그인 성공");
					location="/"; //저장이 완료된 이후 이동하는 url
				}else{
					alert("로그인 실패 아이디 비밀번호를 다시 확인해주세요.");
				}
			},
		    error: function() { //시스템에러
		    	alert("오류발생");
			}
		});
	}
</script>

</html>