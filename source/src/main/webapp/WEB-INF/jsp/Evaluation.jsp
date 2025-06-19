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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<meta charset="UTF-8">
<title>評価表示 | 健康日和</title>
<style>
  table.calendar {
    border-collapse: collapse;
    width: 100%;
    max-width: 600px;
  }
  table.calendar th, table.calendar td {
    border: 1px solid #ccc;
    width: 14.28%;
    height: 60px;
    text-align: center;
    vertical-align: top;
  }
  table.calendar th {
    background-color: #eee;
  }
  .nav-links {
    margin-bottom: 10px;
  }
  .nav-links a {
    margin: 0 10px;
    text-decoration: none;
    font-weight: bold;
  }
  
  input[type='radio'] {
  display: none;
}

label {
  font-size: 30px;
  color: #ccc;
}

input:checked + label {
  color: gold;
}
  
.star {
  color: #ccc;
  font-size: 30px;
}

.star.filled {
  color: gold;
}
  .chart-container {
    display: flex;
    justify-content: space-around;
    gap: 16px;                      
    margin-top: 20px;
    flex-wrap: wrap;               
  }

  .chart-box {
    width: 30%;                    
    min-width: 250px;            
  }
  canvas {
    width: 100% !important;
    height: auto !important;
  }
  
</style>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/evaluation.css' />">
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
      // その日の LocalDate を文字列で作成（yyyy-MM-dd形式）
      String dayStr = String.format("%04d-%02d-%02d", year, month, dayCounter);
%>
      <td>
        <%= dayCounter %>
        <%
          // calendarIconsはMap<LocalDate,String>だがJSP側でLocalDateは扱いづらいのでキーを文字列に変換している想定
          // リクエストスコープのcalendarIconsをMap<String, String>として取得
          Map<String, String> icons = (Map<String, String>)request.getAttribute("calendarIcons");
          if (icons != null && icons.containsKey(dayStr)) {
        %>
          <img src="<%= icons.get(dayStr) %>" alt="スタンプ" style="width:20px; height:20px;">
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


	<p>あなたのBMI</p>
	<p>BMI : <c:out value="${bmi}" /> </p>
	
	
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
	
<h2>前日比</h2>
<div class="chart-container">
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
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',
                    data: [<c:forEach var="score" items="${vegScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                },
                {
                    label: '前日スコア',
                    backgroundColor: 'rgba(128, 128, 128, 0.6)',
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
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',
                    data: [<c:forEach var="score" items="${sleepScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                },
                {
                    label: '前日スコア',
                    backgroundColor: 'rgba(128, 128, 128, 0.6)',
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
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',
                    data: [<c:forEach var="score" items="${walkScoreList}" varStatus="loop">${score}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                },
                {
                    label: '前日スコア',
                    backgroundColor: 'rgba(128, 128, 128, 0.6)',
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
  console.log("dates:", dates);
  console.log("vegetableRatings:", vegetableRatings);
  console.log("sleepRatings:", sleepRatings);
  console.log("walkRatings:", walkRatings);
</script>

</body>
<script src="<c:url value='/js/evaluation.js' />"></script>
</html>
