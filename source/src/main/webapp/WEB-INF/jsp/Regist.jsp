<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規ユーザー登録 | けんこう日和</title>
</head>
<body>
	<div>
	<%-- ヘッダー --%>
	<h1>
	<%--ここにロゴ画像を入れる --%>
	</h1>
	<%-- ヘッダーここまで --%>
	<%-- メイン --%>
	<form>
		<table>
			<tr>
				<td>
					<label>新規ID<br>
					<input type="text">
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>新規パスワード<br>
					<input type="text">
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>新規パスワード(確認用)<br>
					<input type="text">
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>現在の身長(cm)<br>
					<input type="text">
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>現在の体重(kg)<br>
					<input type="text">
					</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>ニックネーム<br>
					<input type="text">
					</label>
				</td>
			</tr>
						<tr>
				<td>
					<input type="submit" value="登録">
					<input type="reset" value="リセット">
				</td>
			<tr>
			
		</table>
	</form>
	<%-- メインここまで --%>
	<%-- フッター --%>
	<div>
		<p>&copy;2025HAL</p>
	</div>
	<%-- フッターここまで --%>
	</div>
</body>
</html>