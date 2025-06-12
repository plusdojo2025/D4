<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログインページ|けんこう日和</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
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
<div class="login-form">
	<form method="post" action="${pageContext.request.contextPath}/LoginServlet">
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
		<a href="/D4/RegistServlet">新規登録はこちらから</a>
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
<!-- <script src="/D4/js/login.js"></script> -->

</html>