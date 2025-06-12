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
				<td>全体スコア</td>
				<td><input type="radio" id="star1" name="rating" value="1"></td>
				<label for="star1" title="1 star"></label>
				<td><input type="radio" id="star2" name="rating" value="2"></td>
				<label for="star2" title="2 stars"></label>
				<td><input type="radio" id="star3" name="rating" value="3"></td>
				<label for="star3" title="3 stars"></label>
				<input type="radio" id="star4" name="rating" value="4">
				<label for="star4" title="4 stars"></label>
				<input type="radio" id="star5" name="rating" value="5">
				<label for="star5" title="5 stars"></label>
			</div>
		</tr>
			<tr>
				<div class = "vege">
			<td>野菜</td>
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

			</tr>
			<tr>
				<div class = "sle">
			<td>睡眠</td>
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

			</tr>
			<tr>
				<div class = "steps">
			<td>運動量</td>
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

			</tr>

	</table>

	<script>
    document.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll('.card-review_star').forEach(el => {
        const rating = parseInt(el.dataset.rating, 10) || 0;
        const pct = (rating / 5) * 100;
        el.style.setProperty('--starWidth', ${pct}%);
        el.setAttribute('role', 'img');
        el.setAttribute('aria-label', ${rating} / 5 stars);
      });
    });
  </script>

</body>
</html>