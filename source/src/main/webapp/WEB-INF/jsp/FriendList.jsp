<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>フレンド一覧|健康日和</title>
<link rel="stylesheet" type="text/css" href="css/friendList.css">
</head>
<body id="top">
<%-- ヘッダー --%>
<header>
<div class="logo">
<img src="/D4/img/情報登録w.png">
<%--ここにロゴ画像を入れる --%>
</div>
<nav class="nav-menu">
  <ul>
    <li><img src="/D4/img/情報登録w.png"><a href="/D4/HealthServlet">情報登録</a></li>
    <li class="with-border"><img src="/D4/img/評価w.png"><a href="/D4/EvaluationServlet">評価</a></li>
    <li class="with-border"><img src="/D4/img/ランキングw.png"><a href="/D4/RankingServlet">ランキング</a></li>
    <li class="with-border"><img src="/D4/img/フレンドw.png"><a href="/D4/FriendListServlet">フレンド</a></li>
  </ul>
 </nav>
</header>
<main>
 <section class="content">
<aside class="side-panel"> 
<nav class="nav-side">
  <ul>
  <li class="with-border"><img src="/D4/img/ボーナスw.png"><a href="/D4/BornusServlet">ログインボーナス</a></li>
  <li class="with-border"><img src="/D4/img/ユーザー情報w.png"><a href="/D4/UserOptionServlet">ユーザー情報</a></li>
  <li class="with-border logout-border"><img src="/D4/img/logoutw.png"><a href="/D4/LoginServlet">ログアウト</a></li>
</ul>
  
 </nav>
</aside>
<!-- フォーム(id検索) -->
<form class="searchFriend" method="POST" action="/D4/FriendListServlet" id="searchFriend_form">
<!-- テキストボックス -->
<label>ID検索<br>
<input type="text" name="friendId" placeholder="idで検索"></label>

<!-- ボタン(詳細画面に移動) -->
<input type="submit" name="searchSubmit" value="検索">
<!-- フォーム終わり -->
</form>

<p>申請一覧</p>
<!-- スクロールできるリスト(申請一覧を表示) -->
<ul>
<!-- forEach で状態が2のもののみ表示-->
<c:forEach var="e" items="${friendList}">
<c:if test="${e.state == 2}">
	<li>
	<!-- フォーム(申請者1人を対象に詳細ページへ移動する) -->
	<form class="checkApply" method="POST" action="/D4/FriendListServlet">
	<!-- 非表示でidを持つ -->
	<input type="hidden" name="friendId" value="${e.friendId}">
	<!-- テキスト(相手の名前) -->
	<p>${e.friendName}</p>
	<!-- ボタン(詳細画面に移動) -->
	<input type="submit" name="searchSubmit" value="詳細">
	</form>
	<!-- フォーム終わり -->
	</li>
</c:if>
</c:forEach>
<!-- 繰り返し終わり -->
</ul>
<!-- リスト終わり -->


<p>フレンド一覧</p>
<!-- スクロールできるリスト(フレンドを一覧表示) -->
<ul>
<!-- foreach で状態が3のもののみ表示-->
<c:forEach var="e" items="${friendList}">
<c:if test="${e.state == 3}">
	<li>
	<!-- フォーム(フレンド1人を対象に詳細ページへ移動する) -->
	<form class="check" method="POST" action="/D4/FriendListServlet">
	<!-- 非表示でidを持つ -->
	<input type="hidden" name="friendId" value="${e.friendId}">
	<!-- テキスト(相手の名前) -->
	<p>${e.friendName}</p>
	<!-- ボタン(詳細画面に移動) -->
	<input type="submit" name="searchSubmit" value="確認">
	</form>
	<!-- フォーム終わり -->
	</li>
</c:if>
</c:forEach>
<!-- 繰り返し終わり -->
</ul>
<!-- リスト終わり -->
<div>
    <a href="#top" class="page_top">
      <img src="top-icon.png" class="top-icon" alt="トップへ">
      TOP
    </a>
  </div>
 </section>
</main>
<footer>
    <p>&copy;2025HARU</p>
</footer>
</body>
<script src="/webapp/friendList.js"></script>
</html>