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

</script>
</head>
<body>
    <h1>회원가입</h1>
    <div style = "float: left;">
		<form action="/signUp" method="post" onsubmit="return viewTest()">
		<div>
		  <label style="margin-left: 9px;">ID: </label>
	      <input type="text" name="id" id="id">
	    </div>
<%
	String id2 = (String)request.getAttribute("id2");
	String msg = (String)request.getAttribute("msg");
%>       
		<div>
	        <label>PW: </label>
	        <input type="password" name="pw" id="pw">
	    </div>
	    <div style = "margin-top: 20px;">    
	        <button type="submit">전송</button>
	        <button type="button" onclick="main()">취소</button>
	    </div>
		</form>
	</div>
	<div style = "float: left; margin-left: 10px;">
		<form action="/idTest" method="post">
			<button type="submit" onclick="test()">
			<input type="hidden" id="id2" name="id2">        
	       	중복확인
	       </button>
<%
	if(msg != null){
%>	       
	       <p style="font-size: 13px; display: inline;"><%=msg%></p>
<%
	}
%>
		</form>
	</div>
</body>
<script>
var id2 = "<%=id2%>";
var result = 0;

function test(){
	var id = document.getElementById('id').value;
	document.getElementById('id2').value = id;
	result = 1;
}

if(id2 == "null"){
	document.getElementById('id').value = "";
}else{
	document.getElementById('id').value = id2;
	result = 2;
}

function viewTest(){
	var id = document.getElementById('id');
	var pw = document.getElementById('pw');
	
	if(id.value == ""){
		alert("ID를 입력해주세요.");
		document.getElementById('id').setAttribute('style','border: 1px solid red');
		return false;
	}else if(pw.value == ""){
		alert("패스워드를 입력해주세요.");
		document.getElementById('id').setAttribute('style','border: 1px solid grey');
		document.getElementById('pw').setAttribute('style','border: 1px solid red');
		return false;
	}else if(result == 0){
		alert("아이디 중복체크를 해주세요.");
		return false;
	}else if(result == 1){
		alert("중복된 아이디입니다. 다른 아이디로 입력해주세요.");
		return false;
	}else{
		alert("가입성공!");
		result = 0;
		return true;
	}
}
</script>
</html>