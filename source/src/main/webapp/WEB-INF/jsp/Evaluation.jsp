<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
  
</style>
</head>
<body>

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
      %>
        <td><%= dayCounter %></td>
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
	    <input type="radio" id="average-star${i}" name="average" disabled
	      <c:if test="${i <= averageRating}">checked</c:if>>
	    <label for="average-star${i}" title="${i} star">★</label>
	  </c:forEach>
	</div>


	<div class="vegetable">
		野菜
		<c:forEach var="i" begin="1" end="5">
			<input type="radio" id="vegetable-star${i}" name="vegetable" disabled
				<c:if test="${i <= todayData.vegetable}">checked</c:if>>
			<label for="vegetable-star${i}" title="${i} star">★</label>
		</c:forEach>
	
		<span class="difference"> 
			前日比: <c:out value="${vegetableDiff}" />
		</span> 
		
		<span class="comment"> 
			<c:out value="${vegetableComment}" />
		</span>
	</div>

	<div class="sleep">
		睡眠
		<c:forEach var="i" begin="1" end="5">
			<input type="radio" id="sleep-star${i}" name="sleep" disabled 
			<c:if test="${i <= todayData.sleep}">checked</c:if>>
			<label for="sleep-star${i}" title="${i} star">★</label>
		</c:forEach>
	
		<span class="difference"> 
			前日比: <c:out value="${sleepDiff}" />
		</span> 
		
		<span class="comment"> 
			<c:out value="${sleepComment}" />
		</span>
	</div>

	<div class="steps">
		運動量
		<c:forEach var="i" begin="1" end="5">
			<input type="radio" id="steps-star${i}" name="steps" disabled
				<c:if test="${i <= todayData.walk}">checked</c:if>>
			<label for="steps-star${i}" title="${i} star">★</label>
		</c:forEach>
	
		<span class="difference"> 
			前日比: <c:out value="${walkDiff}" />
		</span> 
		
		<span class="comment"> 
			<c:out value="${walkComment}" />
		</span>
	</div>

	<p>あなたのBMI</p>
	<p>BMI : <c:out value="${bmi}" /> </p>

</body>
</html>
