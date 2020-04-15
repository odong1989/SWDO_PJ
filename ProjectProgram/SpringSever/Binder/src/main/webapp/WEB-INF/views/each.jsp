<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function() {
		var temp1 = ['가', '나', '다', '라'];
		
		$("#btn1").click(function() {
			$.each(temp1, function(index, item) {
				alert(index);
				alert(item);
			});
		});

		$("#btn2").click(function() {
// 			var hobbyArr = $("[name='hobby']:checked");
			var hobbyArr = $(":checked");
			
			// 준비된 배열(javascript 배열 / jquery 배열) 에 대해 반복문 작업 실시
			$.each(hobbyArr, function(index, item) {
				// alert(item.value);
				alert($(item).val());
			});
		});

		$("#btn3").click(function() {
			
			// jquery 배열 생성과 동시에 반복문 작업 실시
			$(":checked").each(function(index, item) {
				// alert(item.value);
				alert($(item).val());
			});
		});
	});
</script>
</head>
<body>
	<input type="button" id="btn1" value="test1"><br>
	<input type="button" id="btn2" value="취미 확인1"><br>
	<input type="button" id="btn3" value="취미 확인2"><br>
	
	<input type="checkbox" name="hobby" value="운동">운동
	<input type="checkbox" name="hobby" value="영화">영화
	<input type="checkbox" name="hobby" value="독서">독서
</body>
</html>
