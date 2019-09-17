<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script>

function main(){
	location.href = "/loginView";
}

function test(){
	var id = document.getElementById('id').value;
	document.getElementById('id2').value = id;
	console.log(document.getElementById('id2').value);
}
</script>
</head>
<body>
<%
	String num = (String) request.getAttribute("num");
	if(num == null){
		num = "3";
	}
%>
    <h1>회원가입</h1>
	<form action="/signUp" method="post" onsubmit="return viewTest()">
        <div style="float: left; margin-right: 10px;">
		  <label style="margin-left: 9px;">ID: </label>
          <input type="text" name="id" id="id">
        </div>
<%
	String msg = (String)request.getAttribute("msg");
	if(msg != null){
%>        
        <p><%=msg %></p>
<%
	}
%>
        <label>PW: </label>
        <input type="password" name="pw" id="pw"><br><br>
        
        <button type="submit">전송</button>
        <button type="button" onclick="main()">취소</button>
	</form>
	<form action="/idTest" method="post">
		<button type="submit" onclick="test()">
			<input type="hidden" id="id2" name="id2">        
        	중복확인
        </button>
	</form>
</body>
<script>
function viewTest(){
	var id = document.getElementById('id');
	var pw = document.getElementById('pw');
	if(id.value == ""){
		alert("ID를 입력해주세요.");
		return false;
	}else if(pw.value == ""){
		alert("패스워드를 입력해주세요.");
		return false;
	}
}
</script>
</html>