<!-- 240109내용 수정되어서 8일 내용 백업함 -->
<%@page import="java.sql.Connection"%>
<%@page import="com.poseidon.db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link href = "./css/index.css" rel="stylesheet">
<link href = "./css/menu.css" rel="stylesheet">
<script type="text/javascript" src=./js/menu.js></script>
</head>
<body>
<header>
<%@ include file="menu.jsp" %>
</header>

	<h1>index입니다</h1>
<%-- 	<%
	DBConnection db = DBConnection.getInstance();
	Connection conn = db.getConnection();
	
	Connection conn2 = DBConnection.getInstance().getConnection();
	
	%> --%>

	<a href = "./board">board</a>


</body>
</html>