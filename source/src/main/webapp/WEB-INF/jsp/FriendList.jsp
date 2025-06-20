<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>けんこう日和</title>
<link rel="icon" href="<c:url value ='/img/favicon.ico' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/friendList.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/common.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">
</head>
<body>
<%-- ヘッダー --%>
<header>
	<div class="logo-set">
		<div class="logo">
		</div>
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

<!-- フォーム(id検索) -->
<form class="searchFriend" method="POST" action="<c:url value='/FriendListServlet' />" id="searchFriend_form">
<!-- テキストボックス -->
 <label for="friendId" style="margin: 0;">ID検索</label>
<input type="text" name="friendId" placeholder="idで検索">

<!-- ボタン(詳細画面に移動) -->
<input type="submit" class="bt" name="searchSubmit" value="検索">
<!-- フォーム終わり -->
</form>
<div class="application-list" id="form-fadein">
<p>申請一覧</p>
<!-- スクロールできるリスト(申請一覧を表示) -->
<ul class="application-ul">
<!-- forEach で状態が2のもののみ表示-->
<c:forEach var="e" items="${friendList}">
<c:if test="${e.state == 2}">
	<li class="application-item">
	<!-- フォーム(申請者1人を対象に詳細ページへ移動する) -->
	<form class="checkApply" method="POST" action="<c:url value='/FriendListServlet' />">
	<!-- 非表示でidを持つ -->
	<input type="hidden" name="friendId" value="${e.friendId}">
	<div class="application-row">
	<!-- テキスト(相手の名前) -->
	<p>${e.friendName}</p>
	<!-- ボタン(詳細画面に移動) -->
	<input type="submit" class="bt" name="searchSubmit" value="詳細">
	</div>
	</form>
	<!-- フォーム終わり -->
	</li>
</c:if>
</c:forEach>
<!-- 繰り返し終わり -->
</ul>
</div>
<!-- リスト終わり -->

<div class="friend-list" id="form-fadein">
<p>フレンド一覧</p>
<!-- スクロールできるリスト(フレンドを一覧表示) -->
<ul>
<!-- foreach で状態が3のもののみ表示-->
<c:forEach var="e" items="${friendList}">
<c:if test="${e.state == 3}">
	<li>
	<!-- フォーム(フレンド1人を対象に詳細ページへ移動する) -->
	<form class="check" method="POST" action="<c:url value='/FriendListServlet' />">
	<!-- 非表示でidを持つ -->
	<input type="hidden" name="friendId" value="${e.friendId}">
	<!-- テキスト(相手の名前) -->
	<p>${e.friendName}</p>
	<!-- ボタン(詳細画面に移動) -->
	<input type="submit" class="bt" name="searchSubmit" value="確認">
	</form>
	<!-- フォーム終わり -->
	</li>
</c:if>
</c:forEach>
<!-- 繰り返し終わり -->
</ul>
</div>
<!-- リスト終わり -->

</section>

	<div>
    <a href="#top" class="page_top">
      <img src="<c:url value='/img/carrot_1992.png' />" class="top-icon">
      TOP
    </a>
  </div>
 
</main>
<footer>
    <p>&copy;2025HARU</p>
</footer>
</body>
<script src="<c:url value='/js/friendList.js' />"></script>
<script src="<c:url value='/js/common.js' />"></script>
</html>