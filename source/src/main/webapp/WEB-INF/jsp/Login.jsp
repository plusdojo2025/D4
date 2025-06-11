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
<div>
	<%-- ヘッダー --%>
	<h1>
	<%--ここにロゴ画像を入れる --%>
	</h1>
	<%-- ヘッダーここまで --%>
	<%-- メイン --%>
	<form method="POST" action="/D4/LoginServlet">
		<table>
			<tr>
				<td>
					<label>ID<br>
					<input type="text" name="id">
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>パスワード<br>
					<input type="password" name="pw">
					</label>
				</td>
			<tr>
			<tr>
				<td>
					<input type="submit" value="ログイン">
					<input type="reset" value="リセット">
					<span id="error_message"></span>
				</td>
			<tr>
			
		</table>
	</form>
	<a href="/D4/RegistServlet">新規登録はこちらから</a>
	<%-- メインここまで --%>
	<%-- フッター --%>
	<div>
		<p>&copy;2025HAL</p>
	</div>
	<%-- フッターここまで --%>
</div>
</body>
<script src="/D4/js/login.js"></script>
</html>