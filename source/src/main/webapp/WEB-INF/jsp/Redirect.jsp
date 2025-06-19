<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>処理結果 | けんこう日和</title>
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/redirect.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value ='/css/${sessionScope.users.theme}.css' />">

</head>
<body>
<%-- ヘッダー --%>
<header>
<div class="logo-set">
		<div class="logo"><!-- ロゴを適応 -->
		</div>
	</div>
</header>
<%-- ヘッダーここまで --%>
<main>
 <section class="content">
<div class="container"> 
<div class="balloon3">
<p class="redirect-message">${redirect.message}</p>
</div>
<div class="character-set"></div>
<form action="${redirect.backTo}" method="get">
<button class="bt "type="submit">OK</button>
</form>
</div>
</section>
</main>
<footer>
    <p>&copy;2025HARU</p>
</footer>
</body>
</html>