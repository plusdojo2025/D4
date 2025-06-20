<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>フレンド詳細|健康日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/AddFriend.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/common.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">
</head>
<body id="top">
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
        <a href="<c:url value='/LoginServlet' />">
          <img src="<c:url value='/img/logoutw.png' />" alt="ログアウト">
          ログアウト
        </a>
      </li>
    </ul>
  </nav>
</aside>
<!-- サイドパネル -->

<!-- 詳細情報表示 -->
<!-- ボタンで送るためのフォーム -->
<form class="friendInfo" method="POST" action="<c:url value='/AddFriendServlet' />" id="friendInfo">
<!-- 非表示でidを持つ -->
<input type="hidden" name="friendId" value="${user.id}" class="id">

<!-- ユーザーが存在しない場合 -->
<c:if test="${UserExist == false}">
    <p>対象のユーザーは存在しません。</p>
    <input type="submit" name="submit" value="戻る">
</c:if>

<!-- ユーザーが存在する場合 -->
<c:if test="${UserExist == true}">
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
		<div class="friend-buttons">
			<input type="submit" name="submit" value="戻る">
			<input type="submit" name="submit" value="申請">
		</div>
	</c:if>
</c:if>
<!-- 表示制御終わり -->
</form>
<!-- フォーム終わり -->
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
<script src="<c:url value ='/js/addFriend.js' />"></script>
</html>