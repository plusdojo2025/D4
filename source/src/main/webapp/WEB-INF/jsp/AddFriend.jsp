<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>フレンド詳細|健康日和</title>
</head>
<body>
<!-- 詳細情報表示 -->

<!-- ボタンで送るためのフォーム -->
<form class="friendInfo" method="POST" action="/webapp/FriendListServlet">
<!-- 非表示でidを持つ -->
<input type="hidden" name="friendId" value="${user.id}" class="id">
<!-- テキスト(相手の名前) -->
<p>${usersList.name}</p>
<!-- テキスト(連続ログイン) -->
<p>${userList.nLogin}</p>

<!-- 表示制御(stateが1なら申請中、2なら申請されている状態、3ならフレンド) -->

<!-- フレンドリストに相手が登録されている場合の処理 -->
<c:if test="${hasFriend}">
<!-- ループで対象を探す -->
<c:forEach var="f" items="${friendList}">
<!-- 対象への処理 -->
<c:if test="${f.friendId == user.id}">

	<!--  ボタン(戻る/申請(押せない)の処理　状態は1) -->
	<c:if test="${friendList.state == 1}">
		<input type="submit" name="submit" value="戻る">
		<input type="submit" name="submit" value="申請済" disabled>
	</c:if>
	<!-- ボタン(拒否/承認の処理　状態は2) -->
	<c:if test="${friendList.state == 2}">
		<input type="submit" name="submit" value="拒否">
		<input type="submit" name="submit" value="承認">
	</c:if>
	<!-- ボタン(戻る/削除の処理 状態は3) -->
	<c:if test="${friendList.state == 3}">
		<input type="submit" name="submit" value="戻る">
		<input type="submit" name="submit" value="削除">
	</c:if>
</c:if>
<!-- 処理終了 -->
</c:forEach>
<!-- ループ終了 -->
</c:if>
<!-- リストに登録されていない場合の処理 -->
<c:if test="${hasFriend == false}">
<!-- ボタン(戻る/削除の処理) -->
	<input type="submit" name="submit" value="戻る">
	<input type="submit" name="submit" value="申請">
</c:if>

<!-- 表示制御終わり -->
</form>
<!-- フォーム終わり -->
</body>
</html>