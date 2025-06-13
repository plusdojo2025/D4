<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>処理結果 | けんこう日和</title>
</head>
<body>
<h1><img src="" alt="キャラクター"></h1>
<p>${redirect.message}</p>
<img src="">
<form action="${redirect.backTo}" method="get">
    <button type="submit">OK</button>
</form>
<p>&copy;2025HARU</p>
</body>
</html>