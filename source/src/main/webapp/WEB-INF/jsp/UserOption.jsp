<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<h2>プロフィールを編集</h2><p>現在のログイン日数:</p>
	<form>
	<div class="profileBox">
		<div class="input-group">	
			<button>アイコンボタン(仮)</button>
		</div>	
		<div class="input-group">
			<div class="profile">
			    <div class="input-group2">
      				<label for="textbox1">ニックネーム</label>
      				<input type="text" id="textbox1">
    			</div>
			    <div class="input-group2">
      				<label for="textbox1">身長</label>
      				<input type="text" id="textbox1">
    			</div>
			    <div class="input-group2">
      				<label for="textbox1">ID</label>
      				<input type="text" id="textbox1">
    			</div>

			<div class="input-group2">
				<button>テーマボタン(仮)</button>
			</div>
	</div>
	</div>
        </div>	
        <div class="noPublic">
			非公開設定食事<input type="checkbox">睡眠<input type="checkbox">運動<input type="checkbox">
		</div>
		<div class="save">
        	<button type="submit">保存</button>
        </div>
	</form>	
	<%-- メインここまで --%>
</body>
<script src="/D4/js/useroption.js"></script>
</html>