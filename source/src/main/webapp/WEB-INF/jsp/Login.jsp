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
	<h1>
	<%--ここにロゴ画像を入れる --%>
	</h1>
	<%-- ヘッダーここまで --%>
	<%-- メイン --%>
	<div class="main">
	<form method="POST" action="/D4/LoginServlet">
  	<div class="login">
    <div class="input-group">
      <label for="textbox1">ID</label>
      <input type="text" id="textbox1" placeholder="入力してください">
    </div>
    <div class="input-group">
      <label for="textbox2">パスワード</label>
      <input type="text" id="textbox2" placeholder="入力してください">
    </div>
  </div>	
	<div class="button">
		<input type="submit" value="ログイン">
		<input type="reset" value="リセット">
	</div>
	</form>
	
	<div class="back">
		<a href="/D4/RegistServlet">新規登録はこちらから</a>
	</div>
	<%-- メインここまで --%>
	<%-- フッター --%>
	<div>
	</div>
	<%-- フッターここまで --%>
</div>
</body>
<script src="/D4/js/login.js"></script>
</html>