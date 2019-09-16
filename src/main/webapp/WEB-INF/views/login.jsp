<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script>
	function signUp(){
		location.href="/signUpView";
	}
</script>
</head>
<body>
	<h1>로그인</h1>
	<form action="">
		<label style="margin-left: 9px;">ID: </label>
		<input type="text" name="id"><br>
		
		<label>PW: </label>
		<input type="password" name="pw"><br><br>
		
		<button type="submit">로그인</button>
        <button type="button" onclick="signUp()">회원가입</button>
    </form>
</body>
</html>