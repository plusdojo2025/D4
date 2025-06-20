<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Ranking" %>
<%@ page import="dto.Users" %>

<%
    List<Ranking> rankingList = (List<Ranking>) request.getAttribute("rankingList");
		Users loginUser = (Users) session.getAttribute("users");
		String currentUserId = loginUser != null ? loginUser.getId() : null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>けんこう日和</title>
    <link rel="icon" href="<c:url value ='/img/favicon.ico' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/ranking.css' />">
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
<div class="rankinglist" id="form-fadein">
    <h2>ランキング</h2>
    <table class="ranking">
        <tr>
            <th>順位</th>
            <th>ニックネーム</th>
            <th>スコア</th>
            <th></th>
        </tr>
        <%
            for (Ranking r : rankingList) {
                boolean isMyself = r.getId().equals(currentUserId);
        %>
        <tr>
            <td><%= r.getRank() %></td>
            <td><%= isMyself ? r.getName() + "（あなた）" : r.getName() %></td>
            <td>スコア：<%= String.format("%.2f", r.getScore()) %></td>
            <td>
                <% if (!isMyself) { %>
                	<form action="<c:url value='/RankingServlet' />" method="post">
                		<input type="hidden" name="friendId" value="<%= r.getId() %>">
            			<input type="submit" class="bt" value="詳細を表示">
            		</form>
    			<% } else { %>
    			<% } %>	
            </td>
        </tr>
        <%
            }
        %>
    </table>
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
</body>
<script src="<c:url value='/js/common.js' />"></script>
</html>