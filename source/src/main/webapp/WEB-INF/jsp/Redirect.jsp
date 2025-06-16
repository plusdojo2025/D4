<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>処理結果 | けんこう日和</title>
<link rel="stylesheet" type="text/css" href="css/redirect.css">
<link rel="stylesheet" type="text/css" href="/css/${sessionScope.users.theme}.css">
</head>
<body>
<%-- ヘッダー --%>
<header>
<div class="logo"><%--ここにロゴ画像を入れる --%>
<img src="/D4/img/情報登録w.png">
</div>
</header>
<%-- ヘッダーここまで --%>
<main>
 <section class="content">
<h1><img src="" alt="キャラクター表示"></h1>
<p>${redirect.message}</p>
<img src="">
<form action="${redirect.backTo}" method="get">
<button class="bt "type="submit">OK</button>
</form>
</section>
</main>
<footer>
    <p>&copy;2025HARU</p>
</footer>
</body>
</html>