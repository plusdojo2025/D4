<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>処理結果 | けんこう日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/redirect.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">

</head>
<body>
<%-- ヘッダー --%>
<header>
<div class="logo"><%--ここにロゴ画像を入れる --%>
<img src="<c:url value='/img/情報登録w.png' />">
</div>
</header>
<%-- ヘッダーここまで --%>
<main>
 <section class="content">
<div class="container"> 
<div class="balloon3">
<p class="redirect-message">${redirect.message}</p>
</div>
<h1><img src="" alt="キャラクター表示"></h1>
<form action="${redirect.backTo}" method="get">
<button class="bt "type="submit">OK</button>
</form>
</div>
</section>
</main>
<footer>
    <p>&copy;2025HARU</p>
</footer>
</body>
</html>