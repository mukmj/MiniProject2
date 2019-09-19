<%@page import="com.mini2.web.bean.WriteBean"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
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
	        list-style: none;
	    }
	    
	    .dis {
	    	display: none;
	    }
	    
	    .content {
	    	float: right; 
	    	width: 600px; 
	    	background-color: #e8e8e8; 
	    	text-align: right;
	    }
	    
	    .deleteButt, #insertButt, #updateButt {
	    	border: 1px solid #b2b2b2;
	    	border-radius: 5px;
	    	cursor: pointer;
	    }
	    
	    .deleteButt:hover, #insertButt:hover, #updateButt:hover {
	    	box-shadow: 2px 2px #b2b2b2;
	    }
	    
	    .deleteButt {
	    	background-color: white;
	    }
	    
	     #insertButt, #updateButt {
	     	background-color: #f4f4f4; 
	     }
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		function writeEven(no){
			document.getElementById('num').value = no;
		}
	</script>
</head>
<body>
<div>
<%
	List<WriteBean> wbList = (List<WriteBean>) request.getAttribute("wbList");
	String writer = (String)request.getAttribute("nickname");
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
            <input type="hidden" id="num" name="num">
            <button type="submit" id="insertButt">추가</button>
            <button type="submit" formaction="/update" id="updateButt">수정</button> 
        </form>
    </div><br>
    <div>
        <ul style="border-top: 2px solid #c7c7c7; background-color: #ebebeb">
            <li>번호</li>
            <li>제목</li>
            <li>작성자</li>
        </ul>
<%
	if(wbList != null){
		for(int i = wbList.size() - 1 ; i >= 0; i--){
%>
        <ul style="clear: both;" class="line" onclick="writeEven(<%=wbList.get(i).getNo()%>)">
            <li><%=wbList.get(i).getNo()%></li>
            <li><%=wbList.get(i).getTitle()%></li>
            <li><%=wbList.get(i).getNickname()%></li>
            <div class="dis">
           		<li style="width:600px; background-color: #e8e8e8;"><%=wbList.get(i).getComment()%></li>
           		<form action="/delete" class="content">
           			<input type="hidden" name="noPar" value="<%=wbList.get(i).getNo()%>">
           			<button type="submit" class="deleteButt">삭제</button>
           		</form>
            </div>
        </ul>
<%
		}
	}
%>
    </div>
</body>
	<script>
		var nickname = "<%=id%>";

		function main(){
			location.href = "/loginView";
		}
		
		function idCheck(){
			if(nickname == "null"){
				alert("로그인 해주세요. 로그인 창으로 넘어갑니다.");
				location.href = "/loginView";
				return false;
			}else if(document.getElementById('tit').value == ""){
				document.getElementById('tit').setAttribute('style','border: 2px solid #0056a2');
				alert("제목을 입력해주세요.");
				return false;
			}else if(document.getElementById('com').value == ""){
				document.getElementById('tit').setAttribute('style','border: 1px solid #b7b7b7');
				document.getElementById('com').setAttribute('style','border: 2px solid #0056a2');
				alert("내용을 입력해주세요.");
				return false;
			}else{
				alert("작성 완료!");
			}
		}
		
		$(document).ready(function (){
			var count = 0;
			var i;
			var t;
			
			if(nickname == "null"){
				$('#tit').attr('readonly','readonly');
				$('#com').attr('readonly','readonly');
				console.log("닉넴다름1");
			}
			
			$('#updateButt').hide();
			$('#asd').hide();
			
			$('.line').click(function(){
				t = i;
				i = $(this).index();
				
				var writer = document.getElementsByClassName('line')[i - 1].getElementsByTagName('li')[2].textContent;
				var deleteButt = document.getElementsByClassName('deleteButt')[i - 1];
				if(writer == nickname){
					$('#updateButt').show();
					$('#tit').removeAttr('readonly','readonly');
					$('#com').removeAttr('readonly','readonly');
				}else{
					$('#updateButt').hide();
					$(deleteButt).attr('style','display: none');
					$('#tit').attr('readonly','readonly');
					$('#com').attr('readonly','readonly');
					console.log("닉넴다름2");
				}
				
				$('#insertButt').hide();
				
				if(i != t) {
					$('.dis').eq(t - 1).hide();
					count = 0;
				}else{
					count++;
					console.log(i+ "번째: " + count);
				}

				if(count % 2 == 1){
					document.getElementById('tit').value = "";
					document.getElementById('com').value = "";
				}else{
					document.getElementById('tit').value = document.getElementsByClassName('line')[i - 1].getElementsByTagName('li')[1].textContent;
					document.getElementById('com').value = document.getElementsByClassName('line')[i - 1].getElementsByClassName('dis')[0].getElementsByTagName('li')[0].textContent;
				}
				
				$('.dis').eq(i - 1).toggle();
				//console.log(t + "/" + i);
			});
		});
	</script>
</html>
</body>
</html>
