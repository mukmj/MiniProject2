<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
	<style>
		a {
			float: left;
   			margin-right: 20px;
		}
	</style>
</head>
<body>
<div>
<%
	String id = (String)request.getAttribute("id");
	if(id.equals("") || id.equals(null)){
%>
	<a href="/loginView">로그인</a>
<%
	} else {
%>	
	<a href="/logout">로그아웃</a>
	
	<p>[<%=id%>]님</p>
<%
	}
%>
</div>

</body>
</html>
