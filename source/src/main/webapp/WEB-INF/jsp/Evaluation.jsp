<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>評価表示 | 健康日和</title>
</head>
<body>
	<table>
		<tr>
			<div class = "allscore">
				全体スコア
				<input type="radio" id="allstar1" name="rating" value="1" disabled>
				<label for="star1" title="1 star"></label>
				<input type="radio" id="allstar2" name="rating" value="2" disabled>
				<label for="star2" title="2 stars"></label>
				<input type="radio" id="allstar3" name="rating" value="3" disabled>
				<label for="star3" title="3 stars"></label>
				<input type="radio" id="allstar4" name="rating" value="4" disabled>
				<label for="star4" title="4 stars"></label>
				<input type="radio" id="allstar5" name="rating" value="5" disabled>	
				<label for="star5" title="5 stars"></label>
			</div>
			
			<div class = "yesterday">
				前日比
			</div>
		</tr>

		<tr>
			<div class = "vege">
				野菜
				<input type="radio" id="vegetable-star1" name="rating" value="1" disabled>
				<label for="star1" title="1 star"></label>
				<input type="radio" id="vegetable-star2" name="rating" value="2" disabled>
				<label for="star2" title="2 stars"></label>
				<input type="radio" id="vegetable-star3" name="rating" value="3" disabled>
				<label for="star3" title="3 stars"></label>
				<input type="radio" id="vegetable-star4" name="rating" value="4" disabled>
				<label for="star4" title="4 stars"></label>
				<input type="radio" id="vegetable-star5" name="rating" value="5" disabled>
				<label for="star5" title="5 stars"></label>
				
			</div>
		</tr>
		<tr>
			<div class = "sle">
				睡眠
				<input type="radio" id="sleep-star1" name="rating" value="1" disabled>
				<label for="star1" title="1 star"></label>
				<input type="radio" id="sleep-star2" name="rating" value="2" disabled>
				<label for="star2" title="2 stars"></label>
				<input type="radio" id="sleep-star3" name="rating" value="3" disabled> 
				<label for="star3" title="3 stars"></label>
				<input type="radio" id="sleep-star4" name="rating" value="4" disabled>
				<label for="star4" title="4 stars"></label>
				<input type="radio" id="sleep-star5" name="rating" value="5" disabled>
				<label for="star5" title="5 stars"></label>
			</div>
		</tr>
			
		<tr>
			<div class = "steps">
				運動量
				<input type="radio" id="steps-star1" name="rating" value="1" disabled>
				<label for="star1" title="1 star"></label>
				<input type="radio" id="steps-star2" name="rating" value="2" disabled>
				<label for="star2" title="2 stars"></label>
				<input type="radio" id="steps-star3" name="rating" value="3" disabled>
				<label for="star3" title="3 stars"></label>
				<input type="radio" id="steps-star4" name="rating" value="4" disabled>
				<label for="star4" title="4 stars"></label>
				<input type="radio" id="star5" name="rating" value="5" disabled>
				<label for="star5" title="5 stars"></label>
			</div>
		</tr>
	</table>

</body>
</html>