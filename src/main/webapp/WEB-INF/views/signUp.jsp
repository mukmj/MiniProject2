<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
    <h1>회원가입</h1>
	<form action="/signUp">
		<label style="margin-left: 9px;">ID: </label>
        <input type="text"><br><br>
        
        <label>PW: </label>
        <input type="password"><br><br>
        
        <button type="submit">전송</button>
	</form>
</body>
</html>