<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>けんこう日和</title>
<link rel="icon" href="<c:url value ='/img/favicon.ico' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/health.css' />">
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

<div class="health" id="select-animate">
	<form  method="POST" name="health" action="<c:url value='/HealthServlet' />"> 
	 <!--  <input type="text" name="health">-->

    
		<p>野菜摂取量</p>
		 一日の目標摂取量：３５０ｇ<br>【手のひらサイズの小鉢一皿分（約７０ｇ）】<br>
			<div class="rating">
				<c:forEach var="i" begin="1" end="5">
				    <input type="radio" id="star${i}" name="vegetable" value="${i}"
				    <c:if test="${not empty health && health.vegetable == i}">checked</c:if>
				    <c:if test="${empty health && i == 1}">checked</c:if>>
				    <label for="star${i}" title="${i} stars"></label>
			  	</c:forEach>
			</div>
			
	<!-- 時間（0～10時間） -->
	<c:set var="sleep_hour" value="${empty health || health.sleep == null ? 0 : ((health.sleep - (health.sleep % 60)) / 60)}" />
	<c:set var="sleep_minute" value="${empty health || health.sleep == null ? 0 : health.sleep % 60}" />

	<div class="box"> 
		<div class="info">  
		  	<p>睡眠時間<br>
		  		<select name="sleep_hour" class="pull">
					<option value="0" <c:if test="${sleep_hour == 0}">selected</c:if>>0時間</option>
					<option value="1" <c:if test="${sleep_hour == 1}">selected</c:if>>1時間</option>
					<option value="2" <c:if test="${sleep_hour == 2}">selected</c:if>>2時間</option>
					<option value="3" <c:if test="${sleep_hour == 3}">selected</c:if>>3時間</option>
					<option value="4" <c:if test="${sleep_hour == 4}">selected</c:if>>4時間</option>
					<option value="5" <c:if test="${sleep_hour == 5}">selected</c:if>>5時間</option>
					<option value="6" <c:if test="${sleep_hour == 6}">selected</c:if>>6時間</option>
					<option value="7" <c:if test="${sleep_hour == 7}">selected</c:if>>7時間</option>
					<option value="8" <c:if test="${sleep_hour == 8}">selected</c:if>>8時間</option>
					<option value="9" <c:if test="${sleep_hour == 9}">selected</c:if>>9時間</option>
					<option value="10"<c:if test="${sleep_hour == 10}">selected</c:if>>10時間</option>
	  			</select>
	
	  <!-- 分（0分, 15分, 30分, 45分） -->
				<select name="sleep_minute" class="pull">
					<option value="0" <c:if test="${sleep_minute == 0}">selected</c:if>>0分</option>
					<option value="15"<c:if test="${sleep_minute == 15}">selected</c:if>>15分</option>
					<option value="30"<c:if test="${sleep_minute == 30}">selected</c:if>>30分</option>
					<option value="45"<c:if test="${sleep_minute == 45}">selected</c:if>>45分</option>
				</select>
		</div>
	 	 		<br><br>
				<div class="info">
					<p>運動量(歩数)<br><input type="text" name="walk" value="<c:out value='${health.walk}' default=''/>"><br><br>
				</div>
	
			<div class="info stress-level"> 
				<div class="label"><p>ストレスレベル</p></div>
					<div class="radio-group">
					<input type="radio" id="stress1" name="stress" value="1"
					  <c:if test="${empty health || health.stress == 1}">checked</c:if>>
					<label for="stress1"><span>良い</span></label>
					    
					  
						<input type="radio" id="stress2" name="stress" value="2"
							<c:if test="${not empty health && health.stress == 2}">checked</c:if>>
						<label for="stress2"><span>普通</span></label>

					    				 
						<input type="radio" id="stress3" name="stress" value="3"
					    	<c:if test="${not empty health && health.stress == 3}">checked</c:if>>						
						<label for="stress3"><span>悪い</span></label>

					</div>
				</div>
				
			<div class="info"> 
				<p>体重（ｋｇ）<br><input type="text" name="weight" value="<c:choose><c:when test='${not empty health.weight}'>${health.weight}</c:when><c:when test='${not empty sessionScope.weight}'>${sessionScope.weight}</c:when><c:otherwise></c:otherwise></c:choose>"><br>
				<br>
			</div>
		</div>	
		
		<div class="button">
			<input type="submit" class="bt"  id="log">
			<input type="reset"  class="bt"  id="res">
		</div>
	</form>
</div>
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
<script src="<c:url value='/js/health.js' />"></script>
<script src="<c:url value='/js/common.js' />"></script>
</body>
</html>