<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規ユーザー登録 | けんこう日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/regist.css' />">
</head>
<body>
    <%-- ヘッダー --%>
<header>
<div class="logo"><%--ここにロゴ画像を入れる --%>
<img src="<c:url value='/img/titlelogo_theme1.png' />">
</div>

</header>	
	<%-- ヘッダーここまで --%>
	
	<%-- メイン --%>	
<main>	
	<div class="regist-form" id="select-animate">
		<form method="POST" action="<c:url value='/RegistServlet' />" id="registForm">
			<div class="regist">
			    <div class="input-group">
      				<label for="textbox1">新規ID</label>
      				<input type="text" id="textbox1" name="id">
    			</div>
			    <div class="input-group">
      				<label for="textbox2">新規パスワード</label>
      				<input type="text" id="textbox2" name="pw">
    			</div>
			    <div class="input-group">
      				<label for="textbox3">新規パスワード(確認用)</label>
      				<input type="text" id="textbox3" name="pw2">
    			</div>
			    <div class="input-group">
      				<label for="textbox4">現在の身長(cm)</label>
      				<input type="text" id="textbox4" name="height">
    			</div>
			    <div class="input-group">
      				<label for="textbox5">現在の体重(kg)</label>
      				<input type="text" id="textbox5" name="weight">
    			</div>
			    <div class="input-group">
      				<label for="textbox6">ニックネーム</label>
      				<input type="text" id="textbox6" name="name">
    			</div>	
				
				<div class="button">
					<input type="submit" class="bt"  id="log" value="登録">
					<input type="reset"  class="bt"  id="res" value="リセット">
				</div>
		</div>
	</form>
	<div class="back">
		<a href="<c:url value='/LoginServlet' />">戻る</a>
	</div>
	
	</div>
</main>
<footer>
    <p class="copyright">&copy;2025HARU</p>
</footer>
	<%-- メインここまで --%>	
</body>

<script src="<c:url value='/js/regist.js' />"></script>
</html>