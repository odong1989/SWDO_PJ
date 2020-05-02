<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 헤더부분을 대체하는 include -->
<%@ include file="../includes/header.jsp" %>

        <div id="right-body">
        	<div class="introDiv">
		        <table class="introTable">
		        	<tr>
		        		<th class="topTd" colspan="2" >실시간 트렌드</th>
		        	</tr>
		            <c:forEach var="item" items="${hRankNow }">
		            <tr>
		            	<td class="midTd">${item.HASH_TAG }</td>
		            	<td class="midTd">${item.COUNT }</td>
		            </tr>
		            </c:forEach>
		        </table>
			</div>
			<div class="introDiv">
		        <table class="introTable">
		        	<tr>
		        		<th class="topTd" colspan="2">실시간 핫플레이스</th>
		        	</tr>
		            <c:forEach var="item" items="${tRankNow }">
		            <tr>
		            	<td class="midTd">${item.DOCUMENT_DESTINATION }</td>
		            	<td class="midTd">${item.COUNT }</td>
		            </tr>
		            </c:forEach>
		        </table>
			</div>
			<div class="introDiv">
		        <table class="introTable">
		        	<tr>
		        		<th class="topTd" colspan="2">월간 생성 그룹</th>
		        	</tr>
		            <c:forEach var="item" items="${gRankMonth }">
		            <tr>
		            	<td class="midTd">${item.GROUP_SUBCATEGORY }</td>
		            	<td class="midTd">${item.COUNT }</td>
		            </tr>
		            </c:forEach>
		        </table>
			</div>
			<div class="introDiv">
		        <table class="introTable">
		        	<tr>
		        		<th class="topTd" colspan="2">월간 윤종신</th>
		        	</tr>
		            <c:forEach var="item" items="${tRankMonth }">
		            <tr>
		            	<td class="midTd">${item.DOCUMENT_DESTINATION }</td>
		            	<td class="midTd">${item.COUNT }</td>
		            </tr>
		            </c:forEach>
		        </table>
			</div>
			<div style="both:clear;"></div>
        </div>
        
    </div>
    <style>
    	.topTd{
    		background-color:pink;
    	}
    	.introTable {
    		border: 1px solid;
    	}
    	.introTable th{
    		height: 40px;
		    vertical-align: middle;
		    text-align: center;
    	}
    	.introTable td{
    		height: 50px;
    		width: 100px;
    		vertical-align: middle;
		    text-align: center;
    	}
    	.introDiv {
    		float:left;
    		margin: 90px;
    	}
    </style>
</body>
</html>