<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="conPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>404 Not Found - PomPom Developer Community</title>
<style>
body {
	text-align: center;
	font-family: Arial, sans-serif;
	margin-top: 150px;
}

h1 {
	font-size: 36px;
}

p {
	font-size: 18px;
}
</style>
</head>
<body>
	<img src="/resources/img/404.png" alt="" style="width: 400px" />
	<h1>404 해당 URL은 존재하지 않습니다.</h1>
	<p>The requested URL was not found on this server.</p>
	<span><a href="/" style="text-decoration: none; color: skyblue;">다시 돌아가기</a></span>
</body>
</html>
