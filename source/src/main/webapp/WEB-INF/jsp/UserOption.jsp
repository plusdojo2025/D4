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
	
<div class="profile">
	<h2>プロフィールを編集</h2>
	<p>現在の連続ログイン日数:${userInfo.nLogin}</p>
	<form class="UserInfo" method="POST" action="/D4/UserOptionServlet">
		<div class="input-group">
 		<label for="textbox1">ID</label>
			${userInfo.id}
  			<input type="hidden" name="myId" value="${userInfo.id}" class="textbox1">
    	</div>
		<div class="input-group">
  			<label for="textbox2">新規パスワード</label>
  			<input type="text" name = "pw" id="textbox2">
   		</div>
		<div class="input-group">
			<label for="textbox3">新規パスワード(確認用)</label>
 			<input type="text" name = "checkPw" id="textbox3">
   		</div>
		<div class="input-group">
			<label for="textbox4">現在の身長(cm)</label>
			<input type="text" name="height" value="${userInfo.height}" class="textbox4">
		</div>
		<div class="input-group">
			<label for="textbox5">ニックネーム</label>
			<input type="text" name = "name" value="${userInfo.name}" id="textbox5">
		</div>
			<img src="${useInfo.icon}" alt="アイコン" style="width:100px;">
			<button>テーマボタン(仮)</button><br>
		非公開設定
		食事<input type="checkbox" name="vegetable" ${userInfo.vPrivate == '1' ? 'checked' : ''}>
		睡眠<input type="checkbox" name="sleep" ${userInfo.sPrivate == '1' ? 'checked' : ''}>
		運動<input type="checkbox" name ="walk" ${userInfo.wPrivate == '1' ? 'checked' : ''}><br>
		<button type="submit" value="保存">保存</button>
		</form>
	</div>

	<%-- メインここまで --%>
</body>
<script src="/D4/js/useroption.js"></script>
</html>