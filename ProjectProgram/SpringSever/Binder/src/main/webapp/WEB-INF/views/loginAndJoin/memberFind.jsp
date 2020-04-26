<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="<c:url value='/css/suggest_Page_Basic.css' />">
	<script src="http://code.jquery.com/jquery-3.4.1.js "> </script>
	<script type="text/javascript">
		$(function(){			
			var err = "${errMsg}";
			var findMemberData = "${resultMemberData}";
						
			if (err.length != 0) {
				alert("알림 : "+err);
			}
			
			if (findMemberData.length != 0) {
				alert("가입하신 ID : "+findMemberData);
			}
			
		});
	</script>
	<style>
		body, html {
			height: 100%;
		}
		#Wrap{
			height: 100%;
			display: table;
			width: 100%;
		}
		#findFormDiv{
			display: table-cell;
			vertical-align: middle;
			text-align: center;
		}
		
		/*ID찾기form의 Div, 비번찾기form의 Div을 묶어준다. */
		.findForm {
			width:670px; height:280px;
			text-align:center;
			margin: 0 auto;
			background-color: rgba(255, 255, 255, 0.5);
			padding: 25px 25px 10px 25px;
			display: -webkit-inline-box;
		}

		/*ID찾기form의 Div. */
		#left_idFind{
    	    margin:20px; padding:10px;
            width:280px; height:220px;
            background-color : #c9e0c1;
		}
		
		/*비번찾기form의 Div. */
		#right_pwFind{
    	    margin:20px; padding:10px; 
            width:280px; height:220px;
            background-color : #b0d2e8;
        }
	
		input[type=button], input[type=submit] {
			background-color:white;
			color:black;
			margin: 10px;
			border:1px solid #AAA;
		}
		input[type=text] {
			margin:10px 0;
		}
		
		body{
			background-color:#D9E5FF; 
			background-image: url("<c:url value='/img/couple-1822585_1920.jpg' />");
			background-size: cover;
			background-repeat: no-repeat;
			height: 100%;
		}
		

        
        p {
        	font-weight:bolder;
        	font-size:20px;
          	margin:10px;
        }
        
       	td#inputs {
       		padding:7px; 
       		text-align: left;
       	}
		
	</style>
	
</head>
<body>
	<div id="Wrap">	
		<div id="findFormDiv">
			<div class="findForm">
				<div id="left_idFind">
				    <p style="text-align: left;">아이디 찾기</p>
		            <form action="memberFindId" method="post">
		            	<table id="tableForm">
		            		<tr>
			            		<td colspan="2">가입시 기입한 이름과 <br>이메일을 입력해주세요.</td>
		            		</tr>
		               		<tr style="text-align: center; width:110px; text-align:left;">
		           	   	 	 	<td>이름 </td>
		                        <td id="inputs"><input type="text" id="name" name="member_name"></td>
							</tr>
							<tr>
								<td>이메일 </td>
								<td id="inputs">
								<input type="text" id="email" name="member_mail"></td>
							</tr>
							<tr>
		          				<td colspan="2">
		          					<input type="submit" value="ID 확인하기">
									<a href="<c:url value='/' />">
									<input type="button" value="로그인페이지로 이동"></a>		          				
		          				</td>
							</tr>
		           		</table>
		       		</form>
	        	</div>
	
	        	<div id="right_pwFind">
				    <p style="text-align: left;">비밀번호 재설정하기</p>        
	       			<form action="memberFindPassword" method="post">
		           		<table id="tableForm">
		            		<tr>
		            			<td colspan="2">가입시 기입한 이름과 <br>ID를 입력해주세요.</td>
		            		</tr>
		               		<tr style="text-align: center; width:110px; text-align:left;">
		           	   	 		<td>이름</td>
								<td id="inputs"><input type="text" id="name" name="member_name"></td>
							</tr>
							<tr>
								<td>ID</td>
								<td id="inputs"><input type="text" name="member_id"></td>
							</tr>
							<tr>
		          				<td colspan="2"><input type="submit" value="비밀번호 재설정하기"></td>
							</tr>
		            	</table>
	       			</form>
				</div>
			
			</div>
		</div>
	</div>
</body>
</html>