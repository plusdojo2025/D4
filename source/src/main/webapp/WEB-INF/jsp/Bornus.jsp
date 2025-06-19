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
<div class="form-wrapper"  id="select-animate">
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
</div>
</section>
<%--　TOPボタン --%>
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
<script src="<c:url value='/js/common.js' />"></script>
</html>