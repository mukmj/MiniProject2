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
		
		.titleBox,.contBox {
	        margin-bottom: 10px;
	        width: 500px;
	    }
	    
	    .titleBox input {
	        border-radius: 5px;
	        border: 1px solid #b7b7b7;
	        width: 300px;
	        box-shadow: none;
	        height: 20px;
	    }
	    
	    .contBox textarea {
	        width: 300px;
	        height: 80px;
	        resize: none;
	        border-radius: 5px;
	    }
	    
	    ul {
	        list-style: none;
	        width: 600px;
	        height: 30px;
	        margin: 0;
	        padding: 0;
	        border-bottom: 1px solid #c7c7c7;
	    }
	    
	    li {
	        width: 200px;
	        height: 30px;
	        float: left;
	        text-align: center;
	        padding-top: 3px;
	    }
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<div>
<%
	String id = (String)request.getAttribute("id");
	
	if(id == null || id.equals("")){
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
</div><br>
<h1>게시판</h1>
   <div>
        <form action="/insert" method="post" onsubmit="return idCheck()">
            <div class="titleBox">
                <label>제목</label><br>
                <input type="text" name="title" id="tit">
            </div>
            <div class="contBox">
                <label>내용</label><br>
                <textarea name="comment" id="com"></textarea>
            </div>
            <button type="submit">추가</button>
        </form>
    </div><br>
    <div>
        <ul style="border-top: 1px solid #c7c7c7; background-color: #ebebeb">
            <li>번호</li>
            <li>제목</li>
            <li>작성자</li>
        </ul>
        <ul style="clear: both;">
            <li>1</li>
            <li>asd</li>
            <li>작성자1</li>
        </ul>
    </div>
</body>
	<script>
		function main(){
			location.href = "/loginView";
		}
		
		function idCheck(){
			var nickname = "<%=id%>";
			
			if(nickname == "null"){
				alert("로그인 해주세요. 로그인 창으로 넘어갑니다.");
				location.href = "/loginView";
				return false;
			}
				
			alert("작성 완료!");
			
			if(document.getElementById('tit').value == ""){
				
			}else if(document.getElementById('com').value == ""){
				
			}
			
		}
	</script>
</html>
</body>
</html>
