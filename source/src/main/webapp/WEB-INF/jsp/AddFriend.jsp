<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>フレンド詳細|健康日和</title>
<link rel="stylesheet" type="text/css" href="css/AddFriend.css">
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
    <li>
      <a href="/D4/HealthServlet">
        <img src="/D4/img/情報登録w.png" alt="情報登録">
        <span>情報登録</span>
      </a>
    </li>
    <li class="with-border">
      <a href="/D4/EvaluationServlet">
        <img src="/D4/img/評価w.png" alt="評価">
        <span>評価</span>
      </a>
    </li>
    <li class="with-border">
      <a href="/D4/RankingServlet">
        <img src="/D4/img/ランキングw.png" alt="ランキング">
        <span>ランキング</span>
      </a>
    </li>
    <li class="with-border">
      <a href="/D4/FriendListServlet">
        <img src="/D4/img/フレンドw.png" alt="フレンド">
        <span>フレンド</span>
      </a>
    </li>
  </ul>
</nav>
</header>
<main>
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

<!-- 詳細情報表示 -->

<!-- ボタンで送るためのフォーム -->
<form class="friendInfo" method="POST" action="/D4/FriendListServlet">
<!-- 非表示でidを持つ -->
<input type="hidden" name="friendId" value="${user.id}" class="id">
<!-- テキスト(相手の名前) -->
<p>${user.name}</p>
<!-- テキスト(連続ログイン) -->
<p>${user.nLogin}</p>

<!-- 表示制御(stateが1なら申請中、2なら申請されている状態、3ならフレンド) -->

<!-- フレンドリストに相手が登録されている場合の処理 -->
<c:if test="${hasFriend}">
<!-- ループで対象を探す -->
<c:forEach var="f" items="${friendList}">
<!-- 対象への処理 -->
<c:if test="${f.friendId == user.id}">

	<!--  ボタン(戻る/申請(押せない)の処理　状態は1) -->
	<c:if test="${f.state == 1}">
	  <div class="friend-buttons">
		<input type="submit" name="submit" value="戻る">
		<input type="submit" name="submit" value="申請済" disabled>
	   </div>
	</c:if>
	<!-- ボタン(拒否/承認の処理　状態は2) -->
	<c:if test="${f.state == 2}">
	  <div class="friend-buttons">
		<input type="submit" name="submit" value="拒否">
		<input type="submit" name="submit" value="承認">
	  </div>
	</c:if>
	<!-- ボタン(戻る/削除の処理 状態は3) -->
	<c:if test="${f.state == 3}">
	  <div class="friend-buttons">
		<input type="submit" name="submit" value="戻る">
		<input type="submit" name="submit" value="削除">
	  </div>
	</c:if>
</c:if>
<!-- 処理終了 -->
</c:forEach>
<!-- ループ終了 -->
</c:if>
<!-- リストに登録されていない場合の処理 -->
<c:if test="${hasFriend == false}">
<!-- ボタン(戻る/削除の処理) -->
	<input type="submit" name="submit" value="戻る">
	<input type="submit" name="submit" value="申請">
</c:if>

<!-- 表示制御終わり -->
</form>
<!-- フォーム終わり -->
</section>
<div>
    <a href="#top" class="page_top">
      <img src="/D4/img/評価w.png" class="top-icon">
      TOP
    </a>
  </div>
 
</main>
<footer>
    <p>&copy;2025HARU</p>
</footer>
</body>
</body>
</html>