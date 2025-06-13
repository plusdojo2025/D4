<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>情報登録</title>
<link rel="stylesheet" type="text/css" href="css/health.css">
</head>
<body>
<div class="health">
	<form  method="POST" action="/D4/HealthServlet">
		<p>野菜摂取量<br>
		 一日の目標摂取量：３５０ｇ【手のひらサイズの小鉢一皿分（約７０ｇ）】<br>
			<div class="rating">
	  			<input type="radio" id="star1" name="vegetable" value="1" checked > 
	  			<label for="star1" title="1 star"></label>
	  			<input type="radio" id="star2" name="vegetable" value="2">
	  			<label for="star2" title="2 stars"></label>
	  			<input type="radio" id="star3" name="vegetable" value="3">
	  			<label for="star3" title="3 stars"></label>
	  			<input type="radio" id="star4" name="vegetable" value="4">
	  			<label for="star4" title="4 stars"></label>
	  			<input type="radio" id="star5" name="vegetable" value="5">
	  			<label for="star5" title="5 stars"></label>
			</div>
	  <!-- 時間（0～10時間） -->
	 <div class="box"> 
		<div class="info">  
		  	<p>睡眠時間<br>
		  		<select name="sleep_hour">
					<option value="0" selected>時間</option>
					<option value="1">1時間</option>
					<option value="2">2時間</option>
					<option value="3">3時間</option>
					<option value="4">4時間</option>
					<option value="5">5時間</option>
					<option value="6">6時間</option>
					<option value="7">7時間</option>
					<option value="8">8時間</option>
					<option value="9">9時間</option>
					<option value="10">10時間</option>
	  			</select>
	
	  <!-- 分（0分,  30分, ） -->
				<select name="sleep_minute">
					<option value="0" selected>分</option>
					<option value="15">15分</option>
					<option value="30">30分</option>
					<option value="45">45分</option>
				</select>
		</div>
	 	 		<br><br>
				<div class="info">  	 
					運動量(歩数）<br><input type="text" name="walk"><br><br>
				</div>
	
			<div class="info stress-level"> 
				<div class="label">ストレス度</div>
					<div class="radio-group">
		    			<label>
		      				<input type="radio" name="stress" value="1" checked>
		      				<span>低い</span>
		    			</label>
		    			<label>
					     	<input type="radio" name="stress" value="2">
					      	<span>普通</span>
					    </label>
					    <label>
					      <input type="radio" name="stress" value="3">
					      <span>高い</span>
					    </label>
		  			</div>
			</div>
		
			<div class="info"> 
				体重（ｋｇ）<br><input type="text" name="weight" value="${sessionScope.weight}"><br>
				<br>
			</div>
		</div>	
		
		<div class="button">
			<input type="submit" class="bt"  id="log">
			<input type="reset"  class="bt"  id="log">
		</div>
	</form>
</div>
</body>
</html>