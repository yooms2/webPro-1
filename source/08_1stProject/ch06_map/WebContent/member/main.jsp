<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<style>
		td{text-align: center;}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
<body>
	<c:set var="SUCCESS" value="1"/>
	<c:set var="FAIL" value="0"/>
	<c:if test="${joinResult ==SUCCESS}">
		<script>swal('회원가입 성공','감사합니다','success');</script>
	</c:if>
	<c:if test="${joinResult ==FAIL}">
		<script>swal('회원가입 실패','다시 시도하시던지','error');</script>
	</c:if>
	<button onclick="location='${conPath}/joinView.do'">회원가입</button>
	<h1>MAIN</h1>
	<table>
		<tr>
			<c:forEach var="dto" items="${memberList }">
				<td>
					<b>${dto.name }(${dto.id })</b><br>
					우 : ${dto.postcode }<br>
					${dto.address }<br>
					${dto.detailAddress }<br>
					<fmt:formatDate value="${dto.rdate }" pattern="yy-MM-dd(E) hh:mm:ss(a)"/>
				</td>	
			</c:forEach>
		</tr>
	</table>
</body>
</html>