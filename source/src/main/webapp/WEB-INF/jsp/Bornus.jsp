<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログインボーナス確認 | 健康日和</title>
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
	<h1>ログインボーナス</h1>
    <p>あなたの最長連続ログイン日数は <strong>${mLogin}</strong> 日です。</p>   
<body>
  <div class="card">
    <div class="stamps">
      <c:forEach var="icon" items="${iconList}" varStatus="status">
        <div class="stamp" style="background-color: ${icon.color};">
          <img src="${icon.imagePath}" alt="${icon.name}" />
          <div class="day-label">${status.index + 1}日目</div>
        </div>
      </c:forEach>
    </div>
    
</body>
<script src="<c:url value='/js/bornus.js' />"></script>
</html>