<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>処理結果 | けんこう日和</title>
</head>
<body>
<h1><img src=""></h1>
<p><c:out value="${redirect.message}" /></p>
<img src="">
<form action="${redirect.backTo}" method="get">
    <button type="submit">OK</button>
</form>
<p>&copy;2025HARU</p>
</body>
</html>