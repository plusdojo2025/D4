<!-- Copyright (c) 2014-2024 Chart.js Contributors -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dto.Ranking, dto.Health, dto.Users, java.util.List" %>

<%
    Ranking friend = (Ranking) request.getAttribute("friend");
    Ranking myself = (Ranking) request.getAttribute("myself");
    Users frienddata = (Users) request.getAttribute("frienddata");

    List<Health> friendHealth = friend.getHealthList();
    List<Health> myHealth = myself.getHealthList();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>けんこう日和</title>
    <link rel="icon" href="<c:url value ='/img/favicon.ico' />">
    <link rel="stylesheet" href="<c:url value='/css/rankingDetail.css' />">
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

<div class="user-profile" id="select-animate">
	<h2><%= friend.getName() %>さんのユーザー情報</h2>
	<img src="<c:url value='/img/${frienddata.icon}' />" alt="アイコン">
	<p>ID: <%= friend.getId() %></p>
	<p>連続ログイン日数: <%= frienddata.getnLogin() %>日目</p>



	<h2><%= friend.getName() %>さんとあなたの比較</h2>
	
	<!-- タブメニュー -->
	<div id="tab-menu">
	    <div class="tab active" data-tab="average">平均</div>
	    <div class="tab" data-tab="food" data-disabled="${frienddata.vPrivate == 1 ? '1' : '0'}">野菜</div>
	    <div class="tab" data-tab="sleep" data-disabled="${frienddata.sPrivate == 1 ? '1' : '0'}">睡眠</div>
	    <div class="tab" data-tab="walk" data-disabled="${frienddata.wPrivate == 1 ? '1' : '0'}">運動</div>
	</div>
	
	<!-- タブコンテンツ -->
	<div class="tab-content active" id="tab-average">
	    <div id="average-score-block">
	        <h3>今週の平均スコア（15点満点）</h3>
	        <canvas id="chart-average-score"></canvas>
	    </div>
	</div>
	
	<div class="tab-content" id="tab-food">
	    <h3>野菜</h3>
	    <canvas id="chart-food"></canvas>
	</div>
	
	<div class="tab-content" id="tab-sleep">
	    <h3>睡眠</h3>
	    <canvas id="chart-sleep"></canvas>
	</div>
	
	<div class="tab-content" id="tab-walk">
	    <h3>運動</h3>
	    <canvas id="chart-walk"></canvas>
	</div>
<!-- グラフ用データ -->
<script>
    const sleepLabels = [
        <% for (int i = 0; i < myHealth.size(); i++) { %>
            "<%= myHealth.get(i).getDate() %>"<%= (i < myHealth.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const mySleepData = [
        <% for (int i = 0; i < myHealth.size(); i++) { %>
            <%= myHealth.get(i).getSleep() %><%= (i < myHealth.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const friendSleepData = [
        <% for (int i = 0; i < friendHealth.size(); i++) { %>
            <%= friendHealth.get(i).getSleep() %><%= (i < friendHealth.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const myAverageData = [<%= String.format("%.2f", myself.getScore()) %>];
    const friendAverageData = [<%= String.format("%.2f", friend.getScore()) %>];

    const foodLabels = sleepLabels;

    const myFoodData = [
        <% for (int i = 0; i < myHealth.size(); i++) { %>
            <%= myHealth.get(i).getVegetable() %><%= (i < myHealth.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const friendFoodData = [
        <% for (int i = 0; i < friendHealth.size(); i++) { %>
            <%= friendHealth.get(i).getVegetable() %><%= (i < friendHealth.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const myWalkData = [
        <% for (int i = 0; i < myHealth.size(); i++) { %>
            <%= myHealth.get(i).getWalk() %><%= (i < myHealth.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const friendWalkData = [
        <% for (int i = 0; i < friendHealth.size(); i++) { %>
            <%= friendHealth.get(i).getWalk() %><%= (i < friendHealth.size() - 1) ? "," : "" %>
        <% } %>
    ];

    const friendName = "<%= friend.getName() %>";
    const isFoodPrivate = <%= frienddata.getvPrivate() == 1 %>;
    const isSleepPrivate = <%= frienddata.getsPrivate() == 1 %>;
    const isWalkPrivate = <%= frienddata.getwPrivate() == 1 %>;
</script>

<form action="<c:url value='/RankingServlet' />" method="get">
    <input type="submit" class="bt" value="← ランキング画面へ戻る">
</form>
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
<%-- フッター --%>
<footer>
	<p>&copy;2025HARU</p>
</footer>

<!-- JavaScript -->
<script src="<c:url value='/js/chart.umd.js' />"></script>
<script src="<c:url value='/js/ranking.js' />" defer></script>

</body>
</html>