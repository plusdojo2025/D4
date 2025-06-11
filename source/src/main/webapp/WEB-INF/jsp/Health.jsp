<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>情報登録</title>
</head>
<body>
<form method="POST" action="/D4/HealthServlet">

<p>野菜摂取量<br>
 一日の目標摂取量：３５０ｇ【手のひらサイズの小鉢一皿分（約７０ｇ）】<br>
<div class="rating">
  <input type="radio" id="star1" name="rating" value="1">
  <label for="star1" title="1 star"></label>
  <input type="radio" id="star2" name="rating" value="2">
  <label for="star2" title="2 stars"></label>
  <input type="radio" id="star3" name="rating" value="3">
  <label for="star3" title="3 stars"></label>
  <input type="radio" id="star4" name="rating" value="4">
  <label for="star4" title="4 stars"></label>
  <input type="radio" id="star5" name="rating" value="5">
  <label for="star5" title="5 stars"></label>
</div>
  <!-- 時間（0～10時間） -->
  <p>睡眠時間<br>
  <select name="sleep_hour">
    <option value="">時間</option>
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
    <option value="">分</option>
    <option value="15">15分</option>
    <option value="30">30分</option>
    <option value="45">45分</option>
	</select>

 	 <br><br>
運動量(歩数）<br><input type="text" name="walk"><br>
<br>
ストレス度<br>
	 <label><input type="radio" name="stress" value="1"> 低い</label>
	 <label><input type="radio" name="stress" value="2"> 普通</label>
	 <label><input type="radio" name="stress" value="3"> 高い</label><br>
	
<br>
体重（ｋｇ）<br><input type="text" name="weight"><br>
<br>
	<input type="submit">
	<input type="reset">
	
</form>
</body>
</html>