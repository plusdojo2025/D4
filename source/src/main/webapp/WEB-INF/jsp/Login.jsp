<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>けんこう日和</title>
<link rel="icon" href="<c:url value ='/img/favicon.ico' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/login.css' />"><%-- ログイン画面にしかないもの --%>
</head>
<body>
<%-- ヘッダー --%>
<header>
<div class="logo"><%--ここにロゴ画像を入れる --%>
<img src="<c:url value='/img/titlelogo_theme1.png' />">
</div>
</header>
<%-- ヘッダーここまで --%>
<main>
<div class="login-form">
	<form method="post" action="${pageContext.request.contextPath}/LoginServlet" id="loginForm">
		<div class="login">
			<div class="input-group">
				<label for="textbox1">ID</label> 
				<input type="text" id="textbox1" name="id">
			</div>
			<div class="input-group">
				<label for="textbox2">パスワード</label> 
				<input type="password" id="textbox2" name="pw">
			</div>
		</div>
		<div class="button">
			<input type="submit" class="bt" value="ログイン"> 
			<input type="reset" class="bt" value="リセット">
		</div>
	</form>



	<div class="back">
		<a href="<c:url value='/RegistServlet' />">新規登録はこちらから</a>
		
	</div>
</div>
	<%-- メインここまで --%>
	<%-- フッター --%>
	<div></div>
	<%-- フッターここまで --%>
</main>
<footer>
    <p class="copyright">&copy;2025HARU</p>
</footer>
</body>
<script src="<c:url value='/js/login.js' />"></script>

</html>