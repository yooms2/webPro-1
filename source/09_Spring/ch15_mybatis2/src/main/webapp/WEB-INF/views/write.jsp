<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/emp.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
<body>
	<form action="${conPath }/write.do" method="post" name="frm">
		<table>
			<tr>
				<th>사번</th>
				<td>
					<input type="number" name="empno" required="required">
					<input type="button" value="중복확인" onclick="idConfirmChk()"><br>
					<span> ${idConfirmMsg } </span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>직책</th>
				<td><input type="text" name="job"></td>
			</tr>
			<tr>
				<th>상사사번</th>
				<td>
					<select name="mgr">
						<option></option>
						<c:forEach var="mgrEmp" items="${managerList }">
							<option value="${mgrEmp.empno }">
								${mgrEmp.empno }-${mgrEmp.ename }
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td><input type="date" name="hiredate" required="required"></td>
			</tr>
			<tr>
				<th>급여</th>
				<td><input type="number" name="sal" required="required"></td>
			</tr>
			<tr>
				<th>상여</th>
				<td><input type="number" name="comm"></td>
			</tr>
			<tr>
				<th>부서번호</th>
				<td>
					<select name="deptno">
						<c:forEach var="dept" items="${deptList}">
							<option value="${dept.deptno }">
								${dept.deptno } - ${dept.dname } - ${dept.loc }
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록">
					<input type="button" value="목록"
						onclick="${conPath}/empDeptList.do">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>















