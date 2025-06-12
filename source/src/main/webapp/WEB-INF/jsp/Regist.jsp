<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規ユーザー登録 | けんこう日和</title>
<link rel="stylesheet" type="text/css" href="css/regist.css">
</head>
<body>
    <%-- ヘッダー --%>
<header>
<div class="logo">
<%--ここにロゴ画像を入れる --%>
</div>
<nav class="nav-menu">
  <ul>
    <li><img src=""><a href="">情報登録</a></li>
    <li class="with-border"><img src=""><a href="">評価</a></li>
    <li class="with-border"><img src=""><a href="">ランキング</a></li>
    <li class="with-border"><img src=""><a href="">フレンド</a></li>
  </ul>
 </nav>
</header>	
	<%-- ヘッダーここまで --%>
	
	<%-- メイン --%>	
	<form method="POST" action="/D4/RegistServlet">
  <div class="new_info">
    <div class="box">
      <label for="box1">新規ID</label>
      <input type="text" id="box1">
    </div>
    <div class="box">
      <label for="box2">新規パスワード</label>
      <input type="text" id="box2">
    </div>
    <div class="box">
      <label for="box3">新規パスワード(確認)</label>
      <input type="text" id="box3">
    </div>
    <div class="box">
      <label for="box4">現在の身長(cm)</label>
      <input type="text" id="box4">
    </div>
    <div class="box">
      <label for="box5">現在の体重(kg)</label>
      <input type="text" id="box5">
    </div>
    <div class="box">
      <label for="box6">ニックネーム</label>
      <input type="text" id="box6">
    </div>
  </div>
	
	<div class="button">
		<input type="submit" value="登録">
		<input type="reset" value="リセット">
	</div>
	</form>
	<div class="back">
		<a href= "/D4/LoginServlet">戻る</a>
	</div>
	<%-- メインここまで --%>
	<%-- フッター --%>
	<div>
	
	</div>
	<%-- フッターここまで --%>
</body>
<script src="/D4/js/regist.js"></script>
</html>