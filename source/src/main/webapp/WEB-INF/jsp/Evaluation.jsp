<!-- Copyright (c) 2014-2024 Chart.js Contributors -->


<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
  Integer year = (Integer) request.getAttribute("year");
  Integer month = (Integer) request.getAttribute("month");

  if (year == null || month == null) {
    java.time.LocalDate now = java.time.LocalDate.now();
    year = now.getYear();
    month = now.getMonthValue();
  }

  java.time.LocalDate current = java.time.LocalDate.of(year, month, 1);
  java.time.LocalDate prev = current.minusMonths(1);
  java.time.LocalDate next = current.plusMonths(1);

  int lastDay = current.lengthOfMonth();
  int firstWeekDay = current.getDayOfWeek().getValue() % 7; 

  int dayCounter = 1;
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<c:url value ='/img/favicon.ico' />">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<meta charset="UTF-8">
<title>けんこう日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/evaluation.css' />">
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
	
<%-- メイン --%>
<div class="form-wrapper"  id="select-animate">
<div class="calendar-wrapper">
<div class="nav-links">
  <a href="EvaluationServlet?year=<%= prev.getYear() %>&month=<%= prev.getMonthValue() %>">＜ 先月</a>
  <span><%= year %>年 <%= month %>月</span>
  <a href="EvaluationServlet?year=<%= next.getYear() %>&month=<%= next.getMonthValue() %>">翌月 ＞</a>
</div>

<table class="calendar">
  <thead>
    <tr>
      <th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th>
    </tr>
  </thead>
  <tbody>
  <%
    for (int row = 0; row < 6; row++) {
  %>
  <tr>
    <%
      for (int col = 0; col < 7; col++) {
        if (row == 0 && col < firstWeekDay) {
    %>
      <td></td>
    <%
        } else if (dayCounter <= lastDay) {
          String dayStr = String.format("%04d-%02d-%02d", year, month, dayCounter);
    %>
      <td class="calendar-cell" data-date="<%= dayStr %>" style="cursor:pointer;">
        <div class="day-number"><%= dayCounter %></div>
        <%
          Map<String, String> icons = (Map<String, String>)request.getAttribute("calendarIcons");
          if (icons != null && icons.containsKey(dayStr)) {
        %>
          <img src="<%= icons.get(dayStr) %>" alt="スタンプ" class="stamp-img">
        <%
          }
        %>
      </td>
    <%
          dayCounter++;
        } else {
    %>
      <td></td>
    <%
        }
      }
    %>
  </tr>
  <%
      if (dayCounter > lastDay) break;
    }
  %>
  </tbody>
</table>
</div>
</div>
<div class="grid-container">
<div class="class1">
	<div class="overall-score">
	  全体スコア 
	  <c:forEach var="i" begin="1" end="5">
    	<c:choose>
        	<c:when test="${i <= averageRating}">
            	<span class="star filled">★</span>
        	</c:when>
        	<c:otherwise>
        		<span class="star">★</span>
       		</c:otherwise>
    	</c:choose>
		</c:forEach>
	</div>
	<div class="vegetable">
	  野菜 ${vegetableRating}点
	  <c:forEach var="i" begin="1" end="5">
    	<c:choose>
        	<c:when test="${i <= vegetableRating}">
            	<span class="star filled">★</span>
        	</c:when>
        	<c:otherwise>
        		<span class="star">★</span>
       		</c:otherwise>
    	</c:choose>
	</c:forEach>
	
	  <span class="difference">
	  	<c:if test="${showDiff}">
	    	前日比: <c:out value="${vegetableDiff}" />
	    </c:if>
	  </span> 
	  <span class="comment">
	    <c:out value="${vegetableComment}" />
	  </span>
	</div>


	<div class="sleep">
	  睡眠 ${sleepRating}点
	  <c:forEach var="i" begin="1" end="5">
      	<c:choose>
        	<c:when test="${i <= sleepRating}">
            	<span class="star filled">★</span>
        	</c:when>
        	<c:otherwise>
            	<span class="star">★</span>
        	</c:otherwise>
    	</c:choose>
	</c:forEach>
	
	  <span class="difference">
	  	<c:if test="${showDiff}">
	    	前日比: <c:out value="${sleepDiff}" />
	    </c:if>
	  </span> 
	  <span class="comment">
	    <c:out value="${sleepComment}" />	    
	  </span>
	  
	</div>


	<div class="steps">
	  運動量 ${walkRating}点
	<c:forEach var="i" begin="1" end="5">
		<c:choose>
	    	<c:when test="${i <= walkRating}">
		    	<span class="star filled">★</span>
		    </c:when>
		    <c:otherwise>
		    	<span class="star">★</span>
		    </c:otherwise>
	    </c:choose>
	</c:forEach>

	  <span class="difference">
	  	<c:if test="${showDiff}">
	    	前日比: <c:out value="${walkDiff}" />
	  	</c:if>
	  </span> 
	  <span class="comment">
	    <c:out value="${walkComment}" />
	  </span>	  
	</div>	
</div>
<div class="image-box">	
<img src="<c:url value='/img/kasikoiusa.png' />" class="kasikoiusa">
</div>

 <div class="class2">
	<p>あなたのBMI</p>
	<p>BMI : <c:out value="${bmiValue}" /></p>
	<p>標準値の<c:out value="${paValue}" />%</p>
	<div class="chart-container">
  		<div class="chart-box">
    		<canvas id="bmiChart"></canvas>
  		</div>
	</div>
</div>
</div>
	
	
	<script>
  // JSPのリストをJS配列に変換
  const dates = [
    <c:forEach var="date" items="${dates}" varStatus="status">
      '${date}'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];

  const vegetableRatings = [
    <c:forEach var="v" items="${vegetableRatings}" varStatus="status">
      ${v}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];

  const sleepRatings = [
    <c:forEach var="s" items="${sleepRatings}" varStatus="status">
      ${s}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];

  const walkRatings = [
    <c:forEach var="w" items="${walkRatings}" varStatus="status">
      ${w}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];
</script>
<div class="zenjituhi">
<div class="center">	
<h2>前日比</h2>

<div class="chart-container">
<div></div>
  <div class="chart-box">
    <h4>野菜スコア</h4>
    <canvas id="vegetableChart" width="300" height="200"></canvas>
  </div>
  <div class="chart-box">
    <h4>睡眠スコア</h4>
    <canvas id="sleepChart" width="300" height="200"></canvas>
  </div>
  <div class="chart-box">
    <h4>運動スコア</h4>
    <canvas id="walkChart" width="300" height="200"></canvas>
  </div>
</div>

<script>
  const labels = [
    <c:forEach var="label" items="${dayLabelList}" varStatus="s">
      '${label}'<c:if test="${!s.last}">,</c:if>
    </c:forEach>
  ];

  const vegDiff = [
    <c:forEach var="v" items="${vegDiffList}" varStatus="s">
      ${v}<c:if test="${!s.last}">,</c:if>
    </c:forEach>
  ];

  const sleepDiff = [
    <c:forEach var="val" items="${sleepDiffList}" varStatus="s">
      ${val}<c:if test="${!s.last}">,</c:if>
    </c:forEach>
  ];

  const walkDiff = [
    <c:forEach var="w" items="${walkDiffList}" varStatus="s">
      ${w}<c:if test="${!s.last}">,</c:if>
    </c:forEach>
  ];
</script>

<!-- 野菜グラフ -->
<script>
    const ctxVeg = document.getElementById('vegetableChart').getContext('2d');
    new Chart(ctxVeg, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="label" items="${dayLabelList}" varStatus="loop">"${label}"<c:if test="${!loop.last}">,</c:if></c:forEach>],
            datasets: [
                {
                    label: '当日スコア',
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',	//グラフ色
                    data: [<c:forEach var="score" items="${vegScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                },
                {
                    label: '前日スコア',
                    backgroundColor: 'rgba(128, 128, 128, 0.6)',	//グラフ色
                    data: [<c:forEach var="score" items="${vegPrevScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    suggestedMax: 5,
                    title: {
                        display: true,
                        text: '評価 (1〜5)'
                    },
                    ticks: {
                        stepSize: 1 
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }

    });
</script>

<!-- 睡眠グラフ -->
<script>
    const ctxSleep = document.getElementById('sleepChart').getContext('2d');
    new Chart(ctxSleep, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="label" items="${dayLabelList}" varStatus="loop">"${label}"<c:if test="${!loop.last}">,</c:if></c:forEach>],
            datasets: [
                {
                    label: '当日スコア',
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',	//グラフ色
                    data: [<c:forEach var="score" items="${sleepScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                },
                {
                    label: '前日スコア',
                    backgroundColor: 'rgba(128, 128, 128, 0.6)',	//グラフ色
                    data: [<c:forEach var="score" items="${sleepPrevScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    suggestedMax: 5,
                    title: {
                        display: true,
                        text: '評価 (1〜5)'
                    },
                    ticks: {
                        stepSize: 1 
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }

    });
</script>

<!-- 運動グラフ -->
<script>
    const ctxWalk = document.getElementById('walkChart').getContext('2d');
    new Chart(ctxWalk, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="label" items="${dayLabelList}" varStatus="loop">"${label}"<c:if test="${!loop.last}">,</c:if></c:forEach>],
            datasets: [
                {
                    label: '当日スコア',
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',	//グラフ色
                    data: [<c:forEach var="score" items="${walkScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                },
                {
                    label: '前日スコア',
                    backgroundColor: 'rgba(128, 128, 128, 0.6)',	//グラフ色
                    data: [<c:forEach var="score" items="${walkPrevScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    suggestedMax: 5,
                    title: {
                        display: true,
                        text: '評価 (1〜5)'
                    },
                    ticks: {
                        stepSize: 1 
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }

    });
</script>

<script>
  createBarChart('vegetableChart', '野菜', vegDiff, 'steelblue');
  createBarChart('sleepChart', '睡眠', sleepDiff, 'seagreen');
  createBarChart('walkChart', '運動', walkDiff, 'orange');
</script>

<script>
  const dataDates = [
    <c:forEach var="date" items="${calendarIcons.keySet()}" varStatus="status">
      '${date}'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];
</script>

<script>
  const ctxBMI = document.getElementById('bmiChart').getContext('2d');
  new Chart(ctxBMI, {
    type: 'bar',
    data: {
      labels: ['標準BMI', 'あなたのBMI'],
      datasets: [{
        label: 'BMI比較',
        data: [22, parseFloat('${bmiValue}')],  
        backgroundColor: ['#aaa', '#4CAF50']
      }]
    },
    options: {
      indexAxis: 'y',  
      responsive: true,
      scales: {
        x: {
          beginAtZero: true,
          suggestedMax: 30,
          title: {
            display: true,
            text: 'BMI'
          }
        }
      },
      plugins: {
        legend: {
          display: false
        }
      }
    }
  });
</script>
</div>

<script src="<c:url value='/js/calendar.js' />"></script>


<script src="<c:url value='/js/calendar.js' />"></script>
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

<%-- メインここまで --%>

<%-- フッター --%>
<footer>
	<p>&copy;2025HARU</p>
</footer>
<%-- フッターここまで --%>
</body>

<script src="<c:url value='/js/evaluation.js' />"></script>
</html>
