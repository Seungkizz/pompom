<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Not Found - PomPom Developer Community</title>
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

<%--   <h4><c:out value="${exception.getMessage()}"></c:out></h4>

  <ul>
   <c:forEach items="${exception.getStackTrace() }" var="stack">
     <li><c:out value="${stack}"></c:out></li>
   </c:forEach>
  </ul> --%>

	<img src="/resources/img/error.jpg" alt="" style="width: 400px" />
	<h1>잘못된 접근 방식 입니다.</h1>
	<p>The requested URL was not found on this server.</p>
	<span><a href="/" style="text-decoration: none; color: skyblue;">다시 돌아가기</a></span>
</body>
</html>
