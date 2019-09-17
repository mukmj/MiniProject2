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
	
	function inputCheck(){
		var id = document.getElementById('id');
		var pw = document.getElementById('pw');
		if(id.value == ""){
			id.setAttribute('style','border: 1px solid red;');
			alert("ID를 입력해주세요.");
			return false;
		}else if(pw.value == ""){
			id.setAttribute('style','border: 1px solid grey;');
			pw.setAttribute('style','border: 1px solid red;');
			alert("비밀번호를 입력해주세요.");
			return false;
		}
	}
</script>
</head>
<body>
	<h1>로그인</h1>
	<form action="/login" method="post" onsubmit="return inputCheck()">
		<label style="margin-left: 9px;">ID: </label>
		<input type="text" name="id" id="id"><br>
		
		<label>PW: </label>
		<input type="password" name="pw" id="pw"><br><br>
		
		<button type="submit">로그인</button>
        <button type="button" onclick="signUp()">회원가입</button>
    </form>
</body>
</html>