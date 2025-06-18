<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>ログインスタンプカード | 健康日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/bornus.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/common.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">

</head>
<body>
<%-- ヘッダー --%>
<header>
	<div class="logo">
		<img src="<c:url value='/img/情報登録w.png' />">
	</div>
<nav class="nav-menu">
  <ul>
    <li>
      <a href="<c:url value='/HealthServlet' />">
        <img src="<c:url value='/img/情報登録w.png' />" alt="情報登録">
        <span>情報登録</span>
      </a>
    </li>
    <li class="with-border">
      <a href="<c:url value='/EvaluationServlet' />">
        <img src="<c:url value='/img/評価w.png' />" alt="評価">
        <span>評価</span>
      </a>
    </li>
    <li class="with-border">
      <a href="<c:url value='/RankingServlet' />">
        <img src="<c:url value='/img/ランキングw.png' />" alt="ランキング">
        <span>ランキング</span>
      </a>
    </li>
    <li class="with-border">
      <a href="<c:url value='/FriendListServlet' />">
        <img src="<c:url value='/img/フレンドw.png' />" alt="フレンド">
        <span>フレンド</span>
      </a>
    </li>
  </ul>
</nav>
</header>
<%-- ヘッダーここまで --%>
	<!-- <h1>ログインボーナス</h1> -->
    <!--<p>あなたの最長連続ログイン日数は <strong>${mLogin}</strong> 日です。</p> -->  
<main>
 <section class="content">
<aside class="side-panel"> 
  <nav class="nav-side">
    <ul>
      <li class="with-border">
        <a href="<c:url value='/BornusServlet' />">
          <img src="<c:url value='/img/ボーナスw.png' />" alt="ログインボーナス">
          ログインボーナス
        </a>
      </li>
      <li class="with-border">
        <a href="<c:url value='/UserOptionServlet' />">
          <img src="<c:url value='/img/ユーザー情報w.png' />" alt="ユーザー情報">
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
<h2 style="text-align:center;">ログインスタンプカード</h2>
<div class="card-container" id="stampCard">

<c:forEach var="i" begin= "${start}" end="${end}">
<div class="bornusItem">
	<div class="stamp ${i le mLogin ? 'checked' : ''}" > 
	
		<c:forEach var="icon" items="${iconList}"> 
			<c:if test="${icon.days==i}"> 
			<img src="<c:url value='/img/${icon.path}' />" alt="報酬画像">
			</c:if>
		
		</c:forEach>
	</div>
	<div class="bornusDate">
	${i}日目
	</div></div>
</c:forEach>
</div>
</section>
</main>
<footer>
    <p>&copy;2025HARU</p>
</footer>
</body>
</html>