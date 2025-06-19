<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー編集 | けんこう日和</title>

<link rel="stylesheet" type="text/css" href="<c:url value ='/css/userOption.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/common.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">
</head>
<body>

<%-- ヘッダー --%>
<header>
	<div class="logo">
		<img src="<c:url value='/img/regist.png' />">
	</div>
<nav class="nav-menu">
  <ul>
    <li>
      <a href="<c:url value='/HealthServlet' />">
        <img src="<c:url value='/img/regist.png' />" alt="情報登録">
        <span>情報登録</span>
      </a>
    </li>
    <li class="with-border">
      <a href="<c:url value='/EvaluationServlet' />">
        <img src="<c:url value='/img/evaluation.png' />" alt="評価">
        <span>評価</span>
      </a>
    </li>
    <li class="with-border">
      <a href="<c:url value='/RankingServlet' />">
        <img src="<c:url value='/img/ranking.png' />" alt="ランキング">
        <span>ランキング</span>
      </a>
    </li>
    <li class="with-border">
      <a href="<c:url value='/FriendListServlet' />">
        <img src="<c:url value='/img/friendw.png' />" alt="フレンド">
        <span>フレンド</span>
      </a>
    </li>
  </ul>
</nav>
	</header>
<%-- ヘッダーここまで --%>
<main>		
	<!-- サイドパネル -->
<section class="content">
<aside class="side-panel"> 
  <nav class="nav-side">
    <ul>
      <li class="with-border">
        <a href="<c:url value='/BornusServlet' />">
          <img src="<c:url value='/img/bornusw.png' />" alt="ログインボーナス">
          ログインボーナス
        </a>
      </li>
      <li class="with-border">
        <a href="<c:url value='/UserOptionServlet' />">
          <img src="<c:url value='/img/useroption.png' />" alt="ユーザー情報">
          ユーザー情報
        </a>
      </li>
      <li class="with-border logout-border">
        <a href="<c:url value='/LogoutServlet' />" onclick="return confirmLogout();">
	  		<img src="<c:url value='/img/logoutw.png' />" alt="ログアウト">
	  		ログアウト
		</a>
      </li>
    </ul>
  </nav>
</aside>
<!-- サイドパネル -->
	
<%-- メイン --%>
<div class="form-wrapper"  id="select-animate">
  <h2>プロフィールを編集</h2>
  	<p class="loginday">現在の連続ログイン日数: ${userInfo.nLogin}</p>
 	
<div class="profile"> 	    
	<form class="UserInfo form-grid" method="POST" action="<c:url value='/UserOptionServlet' />" id="UserInfo">
 
	  		<!-- アイコン表示＆選択ボタン -->
		    <div class="input-group">
		      <label>アイコン</label><br>
		      <img id="Icon" src="<c:url value='/img/${userInfo.icon}' />" alt="アイコン" class="selectable-image" onclick="openPopup('iconPopup')">
		      <input type="hidden" name="icon" id="IconId" value="${userInfo.icon}">
		      <button type="button" class="Iconbutton" onclick="openPopup('iconPopup')">アイコンを選択</button>
		    </div>
			<div class="input-group">
		      <label for="textbox1">ニックネーム</label>
		      <input type="text" name="name" value="${userInfo.name}" id="textbox5">
		    </div>
		
		    <div class="input-group">
		      <label for="textbox2">現在の身長(cm)</label>
		      <input type="text" name="height" value="${userInfo.height}"  id="textbox4">
		    </div>
		    
		    <div class="input-group">
		      <label for="textbox3">ID</label>
		      ${userInfo.id}
		      <input type="hidden" name="myId" value="${userInfo.id}" class="textbox1" id="textbox1">
		    </div>
		
		    <!-- テーマ表示＆選択ボタン -->
		    <div class="input-group">
		  		<label>テーマ</label><br>
		  		<span id="Theme">${userInfo.theme}</span>
		  		<input type="hidden" name="theme" id="ThemeName" value="${userInfo.theme}">
		  		<button type="button" class="Themebutton" onclick="openPopup('themePopup')">テーマを選択</button>
		  	</div>		
		    
		    <!-- 現在のパスワード（サーバーから渡される値） -->
			<input type="hidden" name="pw" id="pw" value="${userInfo.pw}">
		
		    <div class="input-group">
		      <label for="textbox4">新規パスワード</label>
		      <input type="password" name="newPw" id="textbox2">
		    </div>
		
		    <div class="input-group">
		      <label for="textbox5">新規パスワード(確認用)</label>
		      <input type="password" name="checkPw" id="textbox3">
		    </div>
		
		<!-- 非公開設定 -->
	    <div class="non-public">
	      非公開設定&nbsp;&nbsp;
	      食事<input type="checkbox" name="vegetable" ${userInfo.vPrivate == '1' ? 'checked' : ''}>
	      睡眠<input type="checkbox" name="sleep" ${userInfo.sPrivate == '1' ? 'checked' : ''}>
	      運動<input type="checkbox" name="walk" ${userInfo.wPrivate == '1' ? 'checked' : ''}>
	    </div>	<br>
		
		<div class="button-container">
			<button type="submit" class="save" value="保存">保存</button>

		</div>
	</form>
</div>
</div>	
	
<!-- アイコン選択ポップアップ -->
<div id="iconPopup" class="popup-overlay" style="display:none;">
  <div class="popup-window" id="select-animate">
    <h3>アイコンを選択</h3>
    <div style="display:flex; flex-wrap:wrap; gap:10px;">
      <c:forEach var="icon" items="${iconList}">
        <div style="cursor:pointer; text-align:center;" onclick="selectIcon('${icon.id}', '${icon.path}')">
          <img id="" src="<c:url value='/img/${icon.path}' />" alt="icon">
          <div>ID: ${icon.id}</div>
        </div>
      </c:forEach>
    </div>
    <button class="back" onclick="closePopup('iconPopup')">閉じる</button>
  </div>
</div>

<!-- テーマ選択ポップアップ -->
<div id="themePopup" class="popup-overlay" style="display:none;">
  <div class="popup-window" id="select-animate">
    <h3>テーマを選択</h3>
    <div>
      <c:forEach var="theme" items="${themeList}">
        <div style="cursor:pointer; margin-bottom:8px;" onclick="selectTheme('${theme.name}')">
          ${theme.name}
        </div>
      </c:forEach>
    </div>
    <button class="back" onclick="closePopup('themePopup')">閉じる</button>
  </div>
</div>

</section>
<%--　TOPボタン --%>
	<div>
		<a href="#top" class="page_top">
			<img src="<c:url value='/img/評価w.png' />" class="top-icon">
			TOP
		</a>
	</div>
</main>	

<%-- メインここまで --%>

<%-- フッター --%>
<footer>
	<p>&copy;2025HARU</p>
</footer>
<%-- フッターここまで --%>
</body>
<script src="<c:url value='/js/useroption.js' />"></script>
<script src="<c:url value='/js/common.js' />"></script>
</html>