<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.select {
		background-color : #9087ff;
	}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		$('img').mouseenter(function(){
			$(this).css('height', 100);
		});
		$('img').mouseleave(function(){
			$(this).css('height', 'auto');
		});
		
		$('p').mouseenter(function(){
			$(this).addClass('select');
		});
		
		$('p').mouseleave(function(){
			$(this).removeClass('select');
		});
		
		$("button").click(function() {
			$("p").each(function(index, item) {
				setTimeout(function() {
					$(item).addClass("select");
				}, index * 500);
			});
		});
	});
</script>
</head>
<body>
	<h2> [ css 함수 ]</h2>
	<div>
		<img src="http://bit.ly/goback11" > &nbsp;
		<img src="http://bit.ly/goback11" > &nbsp;
		<img src="http://bit.ly/goback11" >
	</div>
	<hr>
	
	<h2>[ class 함수 ]</h2>
	<p>첫 번째 문장</p>
	<p>두 번째 문장</p>
	<p>세 번째 문장</p>
	<p>네 번째 문장</p>
	<p>다섯 번째 문장</p>
	<p>여섯 번째 문장</p>
	<hr>
	
	<h2>[ each + setTimeout 함수 ]</h2>
	<button>눌러라</button>
</body>
</html>
