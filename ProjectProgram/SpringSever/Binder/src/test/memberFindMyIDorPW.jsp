<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style type="text/css">
        div#left_idFind{
            width:300px;
            float:left;
        }

        div#right_pwFind{
            width:300px;
            float:left;
        }
    </style>
</head>
<body>
    <div class="wrapFindIDorPW">
        <div id="left_idFind" >
            <table>
                <tr>
                    <td>아이디 찾기</td>
                </tr>

                <table >
                    <tr>
                        <td>가입시 기입한 이름과 이메일을 입력해주세요.</td>
                    </tr> 
                    <tr style="text-align: center;">
                        <td style="width:110px; text-align:left;">
                    		<form action="memberFindId" method="post">
                          		  이름 :  <input type="text" id="name" name="member_name"><br>
                           		 이메일 : <input type="text" id="email" name="member_mail">
				           		<input type="submit" value="ID 확인하기">
					        </form>
                        </td>
                    </tr>
                </table>
            </table>
        </div>

        <div id="left_idFind" >
                <table >
                    <tr>
                        <td>비밀번호 재설정하기</td>
                    </tr>
    
                    <table margin:10px;">
                        <tr>
                            <td>가입시 기입한 이름과 ID를 입력해주세요.</td>
                        </tr> 
                        <tr style="text-align: center;">
                            <td style="width:110px; text-align:left;">
                            	<form action="memberFindPassword" method="post">
					                                이름 :  <input type="text" name="member_name"><br>
					               ID : <input type="text" name="member_id"><br>
					               <input type="submit" value="비밀번호 재설정하기">

					        	</form>
                            </td>
                        </tr>
                    </table>
                </table>
            </div>
    </body>
</html>