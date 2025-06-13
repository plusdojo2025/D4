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
  <p>現在の連続ログイン日数: ${userInfo.nLogin}</p>
  <form class="UserInfo" method="POST" action="/D4/UserOptionServlet">

    <div class="input-group">
      <label for="textbox1">ID</label>
      ${userInfo.id}
      <input type="hidden" name="myId" value="${userInfo.id}" class="textbox1">
    </div>

    <div class="input-group">
      <label for="textbox2">新規パスワード</label>
      <input type="text" name="pw" id="textbox2">
    </div>

    <div class="input-group">
      <label for="textbox3">新規パスワード(確認用)</label>
      <input type="text" name="checkPw" id="textbox3">
    </div>

    <div class="input-group">
      <label for="textbox4">現在の身長(cm)</label>
      <input type="text" name="height" value="${userInfo.height}" class="textbox4">
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
      <button type="button" onclick="openPopup('iconPopup')">アイコンを選択</button>
    </div>

    <!-- テーマ表示＆選択ボタン -->
    <div class="input-group">
  <label>テーマ</label><br>
  <span id="Theme">${userInfo.themeName}</span>
  <input type="hidden" name="theme" id="ThemeName" value="${userInfo.theme}">
  <button type="button" onclick="openPopup('themePopup')">テーマを選択</button>
</div>

    <!-- 非公開設定 -->
    <div>
      非公開設定<br>
      食事<input type="checkbox" name="vegetable" ${userInfo.vPrivate == '1' ? 'checked' : ''}>
      睡眠<input type="checkbox" name="sleep" ${userInfo.sPrivate == '1' ? 'checked' : ''}>
      運動<input type="checkbox" name="walk" ${userInfo.wPrivate == '1' ? 'checked' : ''}>
    </div>

    <button type="submit" value="保存">保存</button>
  </form>
</div>

<!-- アイコン選択ポップアップ -->
<div id="iconPopup" class="popup" style="display:none;">
  <div class="popup-content">
    <h3>アイコンを選択</h3>
    <div class="selection-list">
      <c:forEach var="icon" items="${iconList}">
        <div class="selection-item" onclick="selectIcon('${icon.id}', '${icon.path}')">
          <img src="${icon.path}" alt="icon" class="icon-thumb">
          <div>ID: ${icon.id}</div>
        </div>
      </c:forEach>
    </div>
    <button onclick="closePopup('iconPopup')">閉じる</button>
  </div>
</div>

<!-- テーマ選択ポップアップ -->
<div id="themePopup" class="popup" style="display:none;">
  <div class="popup-content">
    <h3>テーマを選択</h3>
    <div class="selection-list">
      <c:forEach var="theme" items="${themeList}">
        <div class="selection-item" onclick="selectTheme('${theme.name}')">
          ${theme.name}
        </div>
      </c:forEach>
    </div>
    <button onclick="closePopup('themePopup')">閉じる</button>
  </div>
</div>


<%-- メインここまで --%>
</body>
<script src="/D4/js/useroption.js"></script>
</html>