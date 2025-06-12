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

</header>	
	<%-- ヘッダーここまで --%>
	
	<%-- メイン --%>	
<div class="regist-form">
	<form method="POST" action="/D4/LoginServlet">
		<div class="regist">
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
			    <div class="input-group">
      				<label for="textbox1">現在の体重(kg)</label>
      				<input type="text" id="textbox1">
    			</div>    			    							
			    <div class="input-group">
      				<label for="textbox1">ニックネーム</label>
      				<input type="text" id="textbox1">
    			</div>	
				
				<div class="button">
					<input type="submit" class="bt"  id="log" value="登録">
					<input type="reset"  class="bt"  id="res" value="リセット">
				</div>
		</div>
	</form>
	<div class="back">
		<a href="/D4/LoginServlet">戻る</a>
	</div>
	
</div>

	<%-- メインここまで --%>	
</body>

<script src="/D4/js/regist.js"></script>
</html>