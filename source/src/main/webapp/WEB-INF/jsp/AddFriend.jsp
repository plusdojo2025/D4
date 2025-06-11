<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 詳細情報表示 -->

<!-- ボタンで送るためのフォーム -->
<form class="friendInfo" method="POST" action="/webapp/FriendListServlet">
<!-- 非表示でidを持つ -->
<!-- input type="hidden" name="friendId" value="${e.friendId}" class="id" -->
<!-- テキスト(相手の名前) -->
<p>相手の名前</p>
<!-- テキスト(連続ログイン) -->
<p>連続ログイン</p>
<!-- 表示制御(stateが1なら申請中、2なら申請されている状態、3ならフレンド) -->

<!-- ボタン(拒否/承認の処理　状態は2) -->
<input type="submit" name="submit" value="拒否">
<input type="submit" name="submit" value="承認">

<!-- ボタン(戻る/削除の処理 状態は3) -->
<input type="submit" name="submit" value="戻る">
<input type="submit" name="submit" value="削除">

<!-- ボタン(戻る/削除の処理 状態は0or1) -->
<input type="submit" name="submit" value="戻る">

<!-- 状態が1ならこのボタンは押せないようにする -->
<input type="submit" name="submit" value="申請">

<!-- 表示制御終わり -->
</form>
<!-- フォーム終わり -->
</body>
</html>