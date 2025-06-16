<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー編集 | けんこう日和</title>

<link rel="stylesheet" type="text/css" href="css/userOption.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/theme1.css">
</head>
<body>
	<%-- ヘッダー --%>
	<header>
	<h1>
	<%--ここにロゴ画像を入れる --%>
	</h1>
	<nav>
	<ul>
		<li class=""><a href = "/D4/HealthServlet">情報登録</a></li>
		<li class=""><a href= "/D4/EvaluationServlet">評価</a></li>
		<li class=""><a href="/D4/RankingServlet">ランキング</a></li>
		<li class=""><a href="/D4/FriendListServlet">フレンド</a></li>
	</ul>
	</nav>
	</header>
	<%-- ヘッダーここまで --%>
	
	<!-- サイドパネル -->
<section class="content">
<aside class="side-panel"> 
  <nav class="nav-side">
    <ul>
      <li class="with-border">
        <a href="/D4/BornusServlet">
          <img src="/D4/img/ボーナスw.png" alt="ログインボーナス">
          ログインボーナス
        </a>
      </li>
      <li class="with-border">
        <a href="/D4/UserOptionServlet">
          <img src="/D4/img/ユーザー情報w.png" alt="ユーザー情報">
          ユーザー情報
        </a>
      </li>
      <li class="with-border logout-border">
        <a href="/D4/LoginServlet">
          <img src="/D4/img/logoutw.png" alt="ログアウト">
          ログアウト
        </a>
      </li>
    </ul>
  </nav>
</aside>
<!-- サイドパネル -->
	
	<%-- メイン --%>
  <div class="form-wrapper">
  <h2>プロフィールを編集</h2>
  <p>現在の連続ログイン日数: ${userInfo.nLogin}</p>
	  <form class="UserInfo form-grid" method="POST" action="/D4/UserOptionServlet" id="UserInfo">
	
	    <div class="input-group">
	      <label for="textbox1">ID</label>
	      ${userInfo.id}
	      <input type="hidden" name="myId" value="${userInfo.id}" class="textbox1">
	    </div>
	    
	    <!-- 現在のパスワード（サーバーから渡される値） -->
		<input type="hidden" name="pw" id="pw" value="${userInfo.pw}">
	
	    <div class="input-group">
	      <label for="textbox2">新規パスワード</label>
	      <input type="password" name="newPw" id="textbox2">
	    </div>
	
	    <div class="input-group">
	      <label for="textbox3">新規パスワード(確認用)</label>
	      <input type="password" name="checkPw" id="textbox3">
	    </div>
	
	    <div class="input-group">
	      <label for="textbox4">現在の身長(cm)</label>
	      <input type="text" name="height" value="${userInfo.height}"  id="textbox4">
	    </div>
	
	    <div class="input-group">
	      <label for="textbox5">ニックネーム</label>
	      <input type="text" name="name" value="${userInfo.name}" id="textbox5">
	    </div>
	
	    <!-- アイコン表示＆選択ボタン -->
	    <div class="input-group">
	      <label>アイコン</label><br>
	      <img id="Icon" src="${userInfo.icon}" alt="アイコン" class="selectable-image" onclick="openPopup('iconPopup')">
	      <input type="hidden" name="icon" id="IconId" value="${userInfo.icon}">
	      <button type="button" class="Iconbutton" onclick="openPopup('iconPopup')">アイコンを選択</button>
	    </div>
	
	    <!-- テーマ表示＆選択ボタン -->
	    <div class="input-group">
	  		<label>テーマ</label><br>
	  		<span id="Theme">${userInfo.theme}</span>
	  		<input type="hidden" name="theme" id="ThemeName" value="${userInfo.theme}">
	  		<button type="button" class="Themebutton" onclick="openPopup('themePopup')">テーマを選択</button>
	  	</div>
	
	    <!-- 非公開設定 -->
	    <div>
	      非公開設定
	      食事<input type="checkbox" name="vegetable" ${userInfo.vPrivate == '1' ? 'checked' : ''}>
	      睡眠<input type="checkbox" name="sleep" ${userInfo.sPrivate == '1' ? 'checked' : ''}>
	      運動<input type="checkbox" name="walk" ${userInfo.wPrivate == '1' ? 'checked' : ''}>
	    </div>
	
		<div class="button-container">
			<button type="submit" class="save" value="保存">保存</button>
		</div>
		</form>
	</div>	

<!-- アイコン選択ポップアップ -->
<div id="iconPopup" class="popup-overlay" style="display:none;">
	  <div class="popup-window">
	    <h3>アイコンを選択</h3>
	    <div style="display:flex; flex-wrap:wrap; gap:10px;">
	      <c:forEach var="icon" items="${iconList}">
	        <div style="cursor:pointer; text-align:center;" onclick="selectIcon('${icon.id}', '${icon.path}')">
	          <img src="${icon.path}" alt="icon" style="width:50px; height:50px;">
	          <div>ID: ${icon.id}</div>
	        </div>
	      </c:forEach>
	    </div>
	    <button onclick="closePopup('iconPopup')">閉じる</button>
	  </div>
	</div>
	
	<!-- テーマ選択ポップアップ -->
	<div id="themePopup" class="popup-overlay" style="display:none;">
	  <div class="popup-window">
	    <h3>テーマを選択</h3>
	    <div>
	      <c:forEach var="theme" items="${themeList}">
	        <div style="cursor:pointer; margin-bottom:8px;" onclick="selectTheme('${theme.name}')">
	          ${theme.name}
	        </div>
	      </c:forEach>
	    </div>
	    <button onclick="closePopup('themePopup')">閉じる</button>
	  </div>
	</div>
</section>
<%-- メインここまで --%>
	<%--　TOPボタン --%>
	<a href="#" id="to-top">
	<img src="" alt="TOP">
	</a>
	<%-- メインここまで --%>
	<%-- フッター --%>
	<footer>
		<div>

		<a href="#top" class="page_top">ページのトップへ戻る</a>
		</div>
		<p>&copy;2025HAL</p>
	</footer>
	<%-- フッターここまで --%>

</body>
<script src="/js/useroption.js"></script>
</html>