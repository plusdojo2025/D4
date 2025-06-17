<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログインボーナス確認 | 健康日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/bornus.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/common.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">
</head>
<body>
	<h1>ログインボーナス</h1>
    <p>あなたの最長連続ログイン日数は <strong>${mLogin}</strong> 日です。</p>
</body>
<script src="<c:url value='/js/bornus.js' />"></script>
</html>