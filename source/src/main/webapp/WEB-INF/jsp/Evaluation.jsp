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
		<c:forEach var="h" items="${healthList}">
			<tr>
				<td>全体スコア</td>
				<td><div class="card-review_star" data-rating="${h.vegetable}"></div></td>
			</tr>
			<tr>
				<td>野菜の量</td>
				<td><div class="card-review_star" data-rating="${h.vegetable}"></div></td>
			</tr>
			<tr>
				<td>睡眠時間</td>
				<td><div class="card-review_star" data-rating="${h.sleep}"></div></td>
			</tr>
			<tr>
				<td>運動量</td>
				<td><div class="card-review_star" data-rating="${h.walk}"></div></td>
			</tr>
		</c:forEach>

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