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
			<div class="profile">
			    <div class="input-group">
      				<label for="textbox1">新規ID</label>
      				<input type="text" id="textbox1">
    			</div>
			    <div class="input-group">
      				<label for="textbox1">新規パスワード</label>
      				<input type="text" id="textbox1">
    			</div>
			    <div class="input-group">
      				<label for="textbox1">新規パスワード(確認用)</label>
      				<input type="text" id="textbox1">
    			</div>
			    <div class="input-group">
      				<label for="textbox1">現在の身長(cm)</label>
      				<input type="text" id="textbox1">
    			</div>

				<button>テーマボタン(仮)</button><br>
		非公開設定食事<input type="checkbox">睡眠<input type="checkbox">運動<input type="checkbox"><br>
        <button type="submit">保存</button>
        </div>
	</form>
</div>	
	<%-- メインここまで --%>
</body>
<script src="/D4/js/useroption.js"></script>
</html>