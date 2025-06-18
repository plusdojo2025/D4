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
    <title>ランキング ｜ けんこう日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/ranking.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/common.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">
</head>

<body>
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
<main>
	<!-- サイドパネル -->
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
			<img src="<c:url value='/img/評価w.png' />" class="top-icon">
			TOP
		</a>
	</div>  
</main>
<%-- フッター --%>
<footer>
	<p>&copy;2025HARU</p>
</footer>
</body>
</html>