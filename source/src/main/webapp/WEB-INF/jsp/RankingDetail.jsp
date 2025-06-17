<!-- Copyright (c) 2014-2024 Chart.js Contributors -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Ranking, dto.Health, java.util.List" %>

<%
    Ranking friend = (Ranking) request.getAttribute("friend");
    Ranking myself = (Ranking) request.getAttribute("myself");

    List<Health> friendHealth = friend.getHealthList();
    List<Health> myHealth = myself.getHealthList();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= friend.getName() %>とあなたの比較 ｜ けんこう日和</title>

    <!-- Chart.js -->
    <script src="<c:url value='/WEB-INF/lib/chart.js' />"></script>
    <!-- 外部JS -->
    <script src="<c:url value='/js/ranking.js' />" defer></script>
    
    <style>
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        .tab {
            cursor: pointer;
            display: inline-block;
            padding: 5px 10px;
            border: 1px solid #ccc;
            margin-right: 4px;
        }
        canvas {
            max-width: 600px;
            max-height: 400px;
            width: 100%;
            height: auto;
        }
    </style>

</head>
<body>

<h2><%= friend.getName() %>さんのユーザー情報</h2>
<p>ID: <%= friend.getId() %></p>
<p>ログイン日数: <%= friendHealth.size() %>日</p>

<h2><%= friend.getName() %>さんとあなたの比較</h2>

<!-- タブ -->
<div id="tab-menu">
    <div class="tab active" data-tab="average">平均</div>
    <div class="tab" data-tab="food">食事</div>
    <div class="tab" data-tab="sleep">睡眠</div>
    <div class="tab" data-tab="walk">運動</div>
</div>

<!-- タブコンテンツ -->
<div id="tab-content">
    <div class="tab-content active" id="tab-average">
        <h3>平均：食事</h3>
        <canvas id="chart-average-food"></canvas>
        <h3>平均：睡眠</h3>
        <canvas id="chart-average-sleep"></canvas>
        <h3>平均：運動</h3>
        <canvas id="chart-average-walk"></canvas>
    </div>
    <div class="tab-content" id="tab-food"><h3>食事</h3><canvas id="chart-food"></canvas></div>
    <div class="tab-content" id="tab-sleep"><h3>睡眠</h3><canvas id="chart-sleep"></canvas></div>
    <div class="tab-content" id="tab-walk"><h3>運動</h3><canvas id="chart-walk"></canvas></div>
</div>

<!-- グラフ用データ -->
<script>
    const sleepLabels = [<% for (int i = 0; i < myHealth.size(); i++) { %>"<%= myHealth.get(i).getDate() %>"<%= (i < myHealth.size() - 1) ? "," : "" %><% } %>];
    const mySleepData = [<% for (int i = 0; i < myHealth.size(); i++) { %><%= myHealth.get(i).getSleep() %><%= (i < myHealth.size() - 1) ? "," : "" %><% } %>];
    const friendSleepData = [<% for (int i = 0; i < friendHealth.size(); i++) { %><%= friendHealth.get(i).getSleep() %><%= (i < friendHealth.size() - 1) ? "," : "" %><% } %>];

    const myAverageData = [
        <%= myself.getHealthList().stream().mapToInt(h -> h.getVegetable()).average().orElse(0) %>,
        <%= myself.getHealthList().stream().mapToInt(h -> h.getSleep()).average().orElse(0) %>,
        <%= myself.getHealthList().stream().mapToInt(h -> h.getWalk()).average().orElse(0) %>
    ];
    const friendAverageData = [
        <%= friend.getHealthList().stream().mapToInt(h -> h.getVegetable()).average().orElse(0) %>,
        <%= friend.getHealthList().stream().mapToInt(h -> h.getSleep()).average().orElse(0) %>,
        <%= friend.getHealthList().stream().mapToInt(h -> h.getWalk()).average().orElse(0) %>
    ];

    const foodLabels = sleepLabels;
    const myFoodData = [<% for (int i = 0; i < myHealth.size(); i++) { %><%= myHealth.get(i).getVegetable() %><%= (i < myHealth.size() - 1) ? "," : "" %><% } %>];
    const friendFoodData = [<% for (int i = 0; i < friendHealth.size(); i++) { %><%= friendHealth.get(i).getVegetable() %><%= (i < friendHealth.size() - 1) ? "," : "" %><% } %>];
    const myWalkData = [<% for (int i = 0; i < myHealth.size(); i++) { %><%= myHealth.get(i).getWalk() %><%= (i < myHealth.size() - 1) ? "," : "" %><% } %>];
    const friendWalkData = [<% for (int i = 0; i < friendHealth.size(); i++) { %><%= friendHealth.get(i).getWalk() %><%= (i < friendHealth.size() - 1) ? "," : "" %><% } %>];

    const friendName = "<%= friend.getName() %>";
</script>

<form action="<c:url value='/RankingServlet' />" method="get">
    <input type="submit" value="← ランキング画面へ戻る">
</form>

</body>
</html>
