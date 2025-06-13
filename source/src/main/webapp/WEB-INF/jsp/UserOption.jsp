<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー編集 | けんこう日和</title>
<link rel="stylesheet" type="text/css" href="css/userOption.css">
</head>
<body>
	<%-- ヘッダー --%>
	<h1>
	<%--ここにロゴ画像を入れる --%>
	</h1>
	<%-- ヘッダーここまで --%>
	<%-- メイン --%>
<div class="profile">
	<h2>プロフィールを編集</h2><p>現在のログイン日数:</p>
	<form>
        <button>アイコンボタン(仮)</button><br>
		<label>ID<br>
			<input type="text"><br>
		</label>
		<label>ニックネーム<br>
			<input type="text"><br>
		</label>
		<label>身長(cm)<br>
			<input type="text"><br>
		</label>
		<button>テーマボタン(仮)</button><br>
		非公開設定食事<input type="checkbox">睡眠<input type="checkbox">運動<input type="checkbox"><br>
        <button type="submit">保存</button>
	</form>
</div>	
	<%-- メインここまで --%>
</body>
<script src="/D4/js/useroption.js"></script>
</html>